import database from "../database/database.js";

// Lấy danh sách tất cả sản phẩm
export const getAllProducts = async () => {
  try {
    const [rows] = await database.execute(
      "SELECT pr.*, ca.CategoryName FROM products as pr join categories as ca on pr.category_id = ca.CategoryID where pr.status = 1 order by pr.ProductID desc"
    );
    return rows;
  } catch (error) {
    throw error;
  }
};
export const get_product_item_by_ID = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [product] = await database.query(
        `SELECT it.*, pr.ProductName as Name, opt.variationID AS variantID, va.VariantName AS variantName,
opt.value FROM product_item AS it JOIN product_configuration AS con 
ON it.id = con.product_item_id
JOIN variation_opt AS opt 
ON con.variation_option_id = opt.id
JOIN products AS pr
ON it.product_id = pr.ProductID
JOIN variation AS va 
ON opt.variationID = va.VariantID
LEFT JOIN productpromotions AS pp
ON it.product_id = pp.ProductID
LEFT JOIN promotions AS pro
ON pp.PromotionID = pro.PromotionID
WHERE it.id = ? AND it.status != 0`,
        [id]
      );
      if (product.length === 0) {
        return resolve({
          error: 1,
          message: "Không tìm thấy sản phẩm",
        });
      }
      let productResult = {
        name: product[0].Name,
        id: product[0].id,
        product_id: product[0].product_id,
        sku: product[0].SKU,
        qty_in_stock: product[0].qty_in_stock,
        product_image: product[0].product_image,
        price: product[0].price,
        description: product[0].description,
        status: product[0].status,
        profit_margin: product[0].profit_margin,
        DiscountRate: product[0].DiscountRate,
        attributes: [],
      };
      product.forEach((product) => {
        productResult.attributes.push({
          variantID: product.variantID,
          variantName: product.variantName,
          values: product.value,
        });
      });
      return resolve(productResult);
    } catch (error) {
      console.log(error);
      return reject(error);
    }
  });
export const get_product_item_by_productID = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [rows] = await database.query(
        `SELECT it.*, pr.ProductName, CASE 
         WHEN pro.StartDate <= NOW() AND pro.EndDate >= NOW() THEN pro.DiscountRate
         ELSE NULL
       END AS DiscountRate, 
        opt.variationID AS variantID, va.VariantName AS variantName, opt.value 
        FROM product_item AS it JOIN product_configuration AS con ON it.id = con.product_item_id 
        JOIN products AS pr ON it.product_id = pr.ProductID 
        LEFT JOIN productpromotions AS pp ON it.product_id = pp.ProductID 
        LEFT JOIN promotions AS pro ON pp.PromotionID = pro.PromotionID 
        JOIN variation_opt AS opt ON con.variation_option_id = opt.id 
        JOIN variation AS va ON opt.variationID = va.VariantID 
        WHERE it.product_id = ? AND it.status != 0 ORDER BY it.id DESC `,
        [id]
      );
      if (rows.length === 0) {
        return resolve({
          error: 0,
          message: "Không có sản phẩm nào",
          data: [],
        });
      }

      // Gom dữ liệu thành các sản phẩm với mảng attributes
      const products = [];
      const productMap = new Map();

      rows.forEach((row) => {
        if (!productMap.has(row.id)) {
          const product = {
            id: row.id,
            product_id: row.product_id,
            sku: row.SKU,
            qty_in_stock: row.qty_in_stock,
            product_image: row.product_image,
            price: row.price,
            description: row.description,
            status: row.status,
            profit_margin: row.profit_margin,
            ProductName: row.ProductName,
            DiscountRate: row.DiscountRate,
            attributes: [],
          };
          productMap.set(row.id, product);
          products.push(product);
        }

        // Thêm thuộc tính vào mảng attributes
        const product = productMap.get(row.id);
        product.attributes.push({
          variantID: row.variantID,
          variantName: row.variantName,
          values: row.value,
        });
      });
      return resolve({
        error: 0,
        message: "Lấy danh sách sản phẩm thành công",
        data: products,
      });
    } catch (error) {
      console.log(error);
      return reject({
        error: 1,
        message: "Lấy danh sách sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const get_product_item_all = () =>
  new Promise(async (resolve, reject) => {
    try {
      const [product] = await database.query(
        `SELECT it.*, pr.ProductName as Name,
      CONCAT('[', GROUP_CONCAT(CONCAT('{"variantName":"', va.VariantName, '","values":"', opt.value, '"}') SEPARATOR ','), ']') AS attributes
      FROM product_item as it join product_configuration as con 
      on it.id = con.product_item_id join variation_opt as opt 
      on con.variation_option_id = opt.id 
      JOIN products AS pr
      ON it.product_id = pr.ProductID
      join variation as va 
      on opt.variationID = va.VariantID
      where it.status != 0
      group by it.id order by it.id desc;`
      );
      if (product.length !== 0) {
        for (let i = 0; i < product.length; i++) {
          product[i].attributes = JSON.parse(product[i].attributes);
        }
      }
      return resolve(product);
    } catch (error) {
      return reject(error);
    }
  });
export const add_product_item = (data, imagePath) =>
  new Promise(async (resolve, reject) => {
    try {
      const [checkSKU] = await database.query(
        `SELECT * FROM product_item WHERE sku = ? and status = 1`,
        [data.sku]
      );
      if (checkSKU.length !== 0) {
        return resolve({
          error: 0,
          message: "SKU đã tồn tại",
        });
      }
      const [product] = await database.query(
        `INSERT INTO product_item (product_id, sku, qty_in_stock, product_image, price, description, profit_margin, status) VALUES (?,?,?,?,?,?,?,2) `,
        [
          data.product_id,
          data.sku,
          0,
          "/products/" + imagePath.filename,
          0,
          data.description,
          data.profit_margin,
        ]
      );
      if (product.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Thêm sản phẩm thất bại",
        });
      }
      const product_item_id = product.insertId;
      const variants = JSON.parse(data.variants);
      for (let i = 0; i < variants.length; i++) {
        const [variation] = await database.query(
          `SELECT * FROM variation_opt where variationID = ? and value = ?`,
          [variants[i].idVariation, variants[i].value]
        );
        if (variation.length === 0) {
          const [insertVariation] = await database.query(
            `INSERT INTO variation_opt (variationID, value) VALUES (?,?)`,
            [variants[i].idVariation, variants[i].value]
          );
          if (insertVariation.affectedRows === 0) {
            return resolve({
              error: 1,
              message: "Thêm biến thể sản phẩm thất bại",
            });
          }
          await database.query(
            `INSERT INTO product_configuration (product_item_id, variation_option_id) VALUES (?,?)`,
            [product_item_id, insertVariation.insertId]
          );
          continue;
        }
        await database.query(
          `INSERT INTO product_configuration (product_item_id, variation_option_id) VALUES (?,?)`,
          [product_item_id, variation[0].id]
        );
      }
      return resolve({
        error: 0,
        message: "Thêm biến thể sản phẩm thành công",
        product_item_id: product_item_id,
      });
    } catch (error) {
      console.log(error);
      return reject({
        error: 1,
        message: "Thêm biến thể sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const edit_product_item = (data, imagePath) =>
  new Promise(async (resolve, reject) => {
    try {
      const [checkSKU] = await database.query(
        `SELECT * FROM product_item WHERE sku = ? and id != ? and status != 0`,
        [data.sku, data.product_item_id]
      );
      if (checkSKU.length !== 0) {
        return resolve({
          error: 0,
          message: "SKU đã tồn tại",
        });
      }
      const [checkProduct] = await database.query(
        `SELECT * FROM product_item WHERE id = ? and status != 0`,
        [data.product_item_id]
      );
      if (checkProduct.length === 0) {
        return resolve({
          error: 1,
          message: "Không tìm thấy sản phẩm",
        });
      }
      if (checkProduct[0].price == 0) {
        const [product] = await database.query(
          imagePath
            ? `UPDATE product_item SET sku = ?, product_image = ?, description = ?, profit_margin = ? WHERE id = ?`
            : `UPDATE product_item SET sku = ?, description = ?, profit_margin = ? WHERE id = ?`,
          imagePath
            ? [
                data.sku,
                "/products/" + imagePath.filename,
                data.description,
                data.profit_margin,
                data.product_item_id,
              ]
            : [
                data.sku,
                data.description,
                data.profit_margin,
                data.product_item_id,
              ]
        );
        if (product.affectedRows === 0) {
          return resolve({
            error: 1,
            message: "Cập nhật sản phẩm thất bại 1",
          });
        }
      } else {
        const priceOrigin =
          checkProduct[0].price / (1 + checkProduct[0].profit_margin / 100);
        const price = priceOrigin * (1 + data.profit_margin / 100);
        const [product] = await database.query(
          imagePath
            ? `UPDATE product_item SET sku = ?, product_image = ?, description = ?, profit_margin = ?, price = ? WHERE id = ?`
            : `UPDATE product_item SET sku = ?, description = ?, profit_margin = ?, price = ? WHERE id = ?`,
          imagePath
            ? [
                data.sku,
                "/products/" + imagePath.filename,
                data.description,
                data.profit_margin,
                price,
                data.product_item_id,
              ]
            : [
                data.sku,
                data.description,
                data.profit_margin,
                price,
                data.product_item_id,
              ]
        );
        if (product.affectedRows === 0) {
          return resolve({
            error: 1,
            message: "Cập nhật sản phẩm thất bại 1",
          });
        }
      }
      const product_item_id = data.product_item_id;
      const variants = JSON.parse(data.variants);
      const [deleteVariants] = await database.query(
        `DELETE FROM product_configuration WHERE product_item_id = ?`,
        [product_item_id]
      );
      if (deleteVariants.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Cập nhật biến thể sản phẩm thất bại 2",
        });
      }
      for (let i = 0; i < variants.length; i++) {
        const [variation] = await database.query(
          `SELECT * FROM variation_opt where variationID = ? and value = ?`,
          [variants[i].variantID, variants[i].values]
        );
        if (variation.length === 0) {
          const [insertVariation] = await database.query(
            `INSERT INTO variation_opt (variationID, value) VALUES (?,?)`,
            [variants[i].variantID, variants[i].values]
          );
          await database.query(
            `INSERT INTO product_configuration (product_item_id, variation_option_id) VALUES (?,?)`,
            [product_item_id, insertVariation.insertId]
          );
          continue;
        }
        await database.query(
          `INSERT INTO product_configuration (product_item_id, variation_option_id) VALUES (?,?)`,
          [product_item_id, variation[0].id]
        );
      }
      resolve({
        error: 0,
        message: "Cập nhật biến thể sản phẩm thành công",
        product_item_id: product_item_id,
      });
    } catch (error) {
      console.log(error);
      reject({
        error: 1,
        message: "Cập nhật biến thể sản phẩm thất bại 3",
        error: error.message,
      });
    }
  });
export const add_product = (data, imagePath) =>
  new Promise(async (resolve, reject) => {
    try {
      const [add_product] = await database.execute(
        `INSERT INTO products (ProductName, Description, category_id, product_image) values (?,?,?,?)`,
        [
          data.nameProduct,
          data.description,
          data.categoryID,
          "/products/" + imagePath,
        ]
      );
      resolve({
        error: add_product.affectedRows === 0 ? 1 : 0,
        message:
          add_product.affectedRows === 0
            ? "Thêm sản phẩm thất bại"
            : "Thêm sản phẩm thành công",
        product_id: add_product.insertId,
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Thêm sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const getProductById = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [rows] = await database.execute(
        "SELECT * FROM products WHERE ProductID = ? and status = 1",
        [id]
      );
      resolve(rows[0]);
    } catch (error) {
      reject(error);
    }
  });
export const update_product = (data, imagePath) =>
  new Promise(async (resolve, reject) => {
    try {
      const [update_product] = await database.execute(
        imagePath
          ? `UPDATE products SET ProductName = ?, Description = ?, category_id = ?, product_image = ? WHERE ProductID = ?`
          : `UPDATE products SET ProductName = ?, Description = ?, category_id = ? WHERE ProductID = ?`,
        imagePath
          ? [
              data.nameProduct,
              data.description,
              data.categoryID,
              "/products/" + imagePath,
              data.product_id,
            ]
          : [
              data.nameProduct,
              data.description,
              data.categoryID,
              data.product_id,
            ]
      );
      resolve({
        error: update_product.affectedRows === 0 ? 1 : 0,
        message:
          update_product.affectedRows === 0
            ? "Cập nhật sản phẩm thất bại"
            : "Cập nhật sản phẩm thành công",
        product_id: update_product.insertId,
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Cập nhật sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const add_attribute = (category_id, name) =>
  new Promise(async (resolve, reject) => {
    try {
      const [checkExist] = await database.execute(
        "SELECT * FROM variation WHERE CategoryID = ? AND VariantName = ?",
        [category_id, name]
      );
      if (checkExist.length !== 0) {
        return resolve({
          error: 0,
          message: "Thuộc tính đã tồn tại",
        });
      }
      const [attribute] = await database.execute(
        "INSERT INTO variation (CategoryID,VariantName) VALUES (?,?)",
        [category_id, name]
      );
      resolve({
        error: attribute.affectedRows === 0 ? 1 : 0,
        message:
          attribute.affectedRows === 0
            ? "Thêm thuộc tính thất bại"
            : "Thêm thuộc tính thành công",
        attribute_id: attribute.insertId,
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Thêm thuộc tính thất bại",
        error: error.message,
      });
    }
  });
export const delete_product_item = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [delete_product_item] = await database.execute(
        `update product_item set status = 0 where id = ?`,
        [id]
      );
      resolve({
        error: delete_product_item.affectedRows === 0 ? 1 : 0,
        message:
          delete_product_item.affectedRows === 0
            ? "Xóa sản phẩm thất bại"
            : "Xóa sản phẩm thành công",
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Xóa sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const delete_product = (id) =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await database.getConnection();
      await client.beginTransaction(); // Bắt đầu giao dịch
      const [delete_product] = await client.execute(
        `update products set status = 0 where ProductID = ?`,
        [id]
      );
      if (delete_product.affectedRows === 0) {
        await client.rollback(); // Rollback nếu có lỗi
        return resolve({
          error: 1,
          message: "Xóa sản phẩm thất bại",
        });
      }
      const [delete_product_item] = await client.execute(
        `update product_item set status = 0 where product_id = ?`,
        [id]
      );
      if (delete_product_item.affectedRows === 0) {
        await client.rollback(); // Rollback nếu có lỗi
        return resolve({
          error: 1,
          message: "Xóa sản phẩm thất bại",
        });
      }
      await client.commit(); // Commit giao dịch nếu không có lỗi
      resolve({
        error: delete_product.affectedRows === 0 ? 1 : 0,
        message:
          delete_product.affectedRows === 0
            ? "Xóa sản phẩm thất bại"
            : "Xóa sản phẩm thành công",
      });
    } catch (error) {
      await client.rollback(); // Rollback nếu có lỗi
      reject({
        error: 1,
        message: "Xóa sản phẩm thất bại",
        error: error.message,
      });
    } finally {
      if (client) {
        client.release(); // Giải phóng kết nối
      }
    }
  });
export const import_product = (data) =>
  new Promise(async (resolve, reject) => {
    try {
      const [import_product] = await database.execute(
        `INSERT INTO product_imports (idsupplier,total_price) VALUES (?,?)`,
        [data.idsupplier, data.total_price]
      );
      if (import_product.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Nhập hàng thất bại",
        });
      }
      const import_id = import_product.insertId;
      let values = [];
      let placeholders = [];

      for (let i = 0; i < data.orderImport.length; i++) {
        values.push(
          import_id,
          data.orderImport[i].id_item_product,
          data.orderImport[i].qty,
          data.orderImport[i].price
        );
        placeholders.push("(?, ?, ?, ?)");
      }

      const query = `INSERT INTO product_import_details (idproduct_import, idproduct_item, quantity, price) VALUES ${placeholders.join(
        ", "
      )}`;
      const [import_product_item] = await database.execute(query, values);
      if (import_product_item.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Nhập hàng thất bại",
        });
      }
      for (let i = 0; i < data.orderImport.length; i++) {
        const [get_product_item] = await database.execute(
          `SELECT * FROM product_item WHERE id = ?`,
          [data.orderImport[i].id_item_product]
        );
        if (get_product_item.length === 0) {
          return resolve({
            error: 1,
            message: "Nhập hàng thất bại",
          });
        }
        const qty_in_stock =
          get_product_item[0].qty_in_stock + data.orderImport[i].qty;
        const price =
          data.orderImport[i].price *
          (1 + get_product_item[0].profit_margin / 100);
        const [update_product_item] = await database.execute(
          `UPDATE product_item SET qty_in_stock = ?, price = ?, status = 1 WHERE id = ?`,
          [qty_in_stock, price, data.orderImport[i].id_item_product]
        );
        if (update_product_item.affectedRows === 0) {
          return resolve({
            error: 1,
            message: "Nhập hàng thất bại",
          });
        }
      }
      resolve({
        error: 0,
        message: "Nhập hàng thành công",
        import_id: import_id,
      });
    } catch (error) {
      console.log(error);
      reject({
        error: 1,
        message: "Nhập hàng thất bại",
        error: error.message,
      });
    }
  });
export const get_product_display = () =>
  new Promise(async (resolve, reject) => {
    try {
      // Truy vấn dữ liệu thô từ cơ sở dữ liệu
      const [rows] = await database.query(
        `SELECT it.*, pr.ProductName, pr.category_id, CASE 
         WHEN pro.StartDate <= NOW() AND pro.EndDate >= NOW() THEN pro.DiscountRate
         ELSE NULL
       END AS DiscountRate,
opt.variationID AS variantID, va.VariantName AS variantName, opt.value FROM product_item AS it
JOIN product_configuration AS con ON it.id = con.product_item_id 
JOIN products AS pr ON it.product_id = pr.ProductID
LEFT JOIN productpromotions AS pp ON it.product_id = pp.ProductID
LEFT JOIN promotions AS pro ON pp.PromotionID = pro.PromotionID
JOIN variation_opt AS opt ON con.variation_option_id = opt.id 
JOIN variation AS va ON opt.variationID = va.VariantID 
WHERE it.status = 1 ORDER BY it.id DESC`
      );

      if (rows.length === 0) {
        return resolve({
          error: 0,
          message: "Không có sản phẩm nào",
          data: [],
        });
      }

      // Gom dữ liệu thành các sản phẩm với mảng attributes
      const products = [];
      const productMap = new Map();

      rows.forEach((row) => {
        if (!productMap.has(row.id)) {
          const product = {
            id: row.id,
            product_id: row.product_id,
            sku: row.SKU,
            qty_in_stock: row.qty_in_stock,
            product_image: row.product_image,
            price: row.price,
            description: row.description,
            status: row.status,
            profit_margin: row.profit_margin,
            ProductName: row.ProductName,
            DiscountRate: row.DiscountRate,
            attributes: [],
          };
          productMap.set(row.id, product);
          products.push(product);
        }

        // Thêm thuộc tính vào mảng attributes
        const product = productMap.get(row.id);
        product.attributes.push({
          variantID: row.variantID,
          variantName: row.variantName,
          values: row.value,
        });
      });

      resolve({
        error: 0,
        message: "Lấy danh sách sản phẩm thành công",
        data: products,
      });
    } catch (error) {
      console.error("Error in get_product_display:", error);
      reject({
        error: 1,
        message: "Lấy danh sách sản phẩm thất bại",
        error: error.message,
      });
    }
  });
export const get_product_item_by_categoryID = (categoryID) =>
  new Promise(async (resolve, reject) => {
    try {
      const [rows] = await database.query(
        `SELECT it.*, pr.ProductName, CASE 
         WHEN pro.StartDate <= NOW() AND pro.EndDate >= NOW() THEN pro.DiscountRate
         ELSE NULL
       END AS DiscountRate, opt.variationID AS variantID, va.VariantName AS variantName, opt.value FROM product_item AS it
JOIN product_configuration AS con 
  ON it.id = con.product_item_id
JOIN products AS pr
  ON it.product_id = pr.ProductID
LEFT JOIN productpromotions AS pp
  ON it.product_id = pp.ProductID
LEFT JOIN promotions AS pro
  ON pp.PromotionID = pro.PromotionID
JOIN variation_opt AS opt
  ON con.variation_option_id = opt.id
JOIN variation AS va
  ON opt.variationID = va.VariantID
WHERE it.status = 1 and pr.category_id = ?
order by it.id desc`,
        [categoryID]
      );
      if (rows.length === 0) {
        return resolve({
          error: 0,
          message: "Không có sản phẩm nào",
          data: [],
        });
      }
      // Gom dữ liệu thành các sản phẩm với mảng attributes
      const products = [];
      const productMap = new Map();
      rows.forEach((row) => {
        if (!productMap.has(row.id)) {
          const product = {
            id: row.id,
            product_id: row.product_id,
            sku: row.SKU,
            qty_in_stock: row.qty_in_stock,
            product_image: row.product_image,
            price: row.price,
            description: row.description,
            status: row.status,
            profit_margin: row.profit_margin,
            ProductName: row.ProductName,
            DiscountRate: row.DiscountRate,
            attributes: [],
          };
          productMap.set(row.id, product);
          products.push(product);
        }

        // Thêm thuộc tính vào mảng attributes
        const product = productMap.get(row.id);
        product.attributes.push({
          variantID: row.variantID,
          variantName: row.variantName,
          values: row.value,
        });
      });

      resolve({
        error: 0,
        message: "Lấy danh sách sản phẩm thành công",
        data: products,
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Lấy danh sách sản phẩm thất bại",
        error: error.message,
      });
    }
  });
