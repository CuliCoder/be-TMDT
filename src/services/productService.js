import database from "../database/database.js";

// Lấy danh sách tất cả sản phẩm
export const getAllProducts = async () => {
  try {
    const [rows] = await database.execute(
      "SELECT pr.*, ca.CategoryName FROM products as pr join categories as ca on pr.category_id = ca.CategoryID"
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
        `SELECT it.*,
  JSON_ARRAYAGG(
    JSON_OBJECT(
      'variantID', opt.variationID,
      'variantName', va.VariantName,
      'values', opt.value
      )
  ) AS attributes
FROM product_item AS it 
JOIN product_configuration AS con 
  ON it.id = con.product_item_id 
JOIN variation_opt AS opt 
  ON con.variation_option_id = opt.id 
JOIN variation AS va 
  ON opt.variationID = va.VariantID 
WHERE it.id = ?
GROUP BY it.id;`,
        [id]
      );
      resolve(product[0]);
    } catch (error) {
      console.log(error);
      reject(error);
    }
  });
export const get_product_item_by_productID = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [product] = await database.query(
        `SELECT it.*,
  JSON_ARRAYAGG(
    JSON_OBJECT(
      'variantID', opt.variationID,
      'variantName', va.VariantName,
      'values', opt.value
      )
  ) AS attributes
FROM product_item AS it 
JOIN product_configuration AS con 
  ON it.id = con.product_item_id 
JOIN variation_opt AS opt 
  ON con.variation_option_id = opt.id 
JOIN variation AS va 
  ON opt.variationID = va.VariantID 
WHERE it.product_id = ?
GROUP BY it.id;`,
        [id]
      );
      resolve(product);
    } catch (error) {
      console.log(error);
      reject(error);
    }
  });
export const get_product_item_all = () =>
  new Promise(async (resolve, reject) => {
    try {
      const [product] = await database.query(
        `SELECT it.*, 
      CONCAT('[', GROUP_CONCAT(CONCAT('{"variantName":"', va.VariantName, '","values":"', opt.value, '"}') SEPARATOR ','), ']') AS attributes
      FROM product_item as it join product_configuration as con 
      on it.id = con.product_item_id join variation_opt as opt 
      on con.variation_option_id = opt.id join variation as va 
      on opt.variationID = va.VariantID
      group by it.id
      `
      );
      if (product.length !== 0) {
        for (let i = 0; i < product.length; i++) {
          product[i].attributes = JSON.parse(product[i].attributes);
        }
      }
      resolve(product);
    } catch (error) {
      reject(error);
    }
  });
export const add_product_item = (data, imagePath) =>
  new Promise(async (resolve, reject) => {
    try {
      const [checkSKU] = await database.query(
        `SELECT * FROM product_item WHERE sku = ?`,
        [data.sku]
      );
      if (checkSKU.length !== 0) {
        return resolve({
          error: 0,
          message: "SKU đã tồn tại",
        });
      }
      const [product] = await database.query(
        `INSERT INTO product_item (product_id, sku, qty_in_stock, product_image, price, description) VALUES (?,?,?,?,?,?) `,
        [
          data.product_id,
          data.sku,
          0,
          "/products/" + imagePath.filename,
          0,
          data.description,
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
        message: "Thêm biến thể sản phẩm thành công",
        product_item_id: product_item_id,
      });
    } catch (error) {
      console.log(error);
      reject({
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
        `SELECT * FROM product_item WHERE sku = ? and id != ?`,
        [data.sku, data.product_item_id]
      );
      if (checkSKU.length !== 0) {
        return resolve({
          error: 0,
          message: "SKU đã tồn tại",
        });
      }
      const [product] = await database.query(
        imagePath
          ? `UPDATE product_item SET sku = ?, product_image = ?, description = ? WHERE id = ?`
          : `UPDATE product_item SET sku = ?, description = ? WHERE id = ?`,
        imagePath
          ? [
              data.sku,
              "/products/" + imagePath.filename,
              data.description,
              data.product_item_id,
            ]
          : [data.sku, data.description, data.product_item_id]
      );
      if (product.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Cập nhật sản phẩm thất bại 1",
        });
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
        "SELECT * FROM products WHERE ProductID = ?",
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
