import database from "../database/database.js";

// Lấy danh sách tất cả sản phẩm
export const getAllProducts = async () => {
  try {
    const [rows] = await database.execute("SELECT * FROM products");
    return rows;
  } catch (error) {
    throw error;
  }
};
export const get_product_item = (id) =>
  new Promise(async (resolve, reject) => {
    try {
      const [product] = await database.query(
        `SELECT it.*, 
      CONCAT('[', GROUP_CONCAT(CONCAT('{"variantName":"', va.VariantName, '","values":"', opt.value, '"}') SEPARATOR ','), ']') AS attributes
      FROM product_item as it join product_configuration as con 
      on it.id = con.product_item_id join variation_opt as opt 
      on con.variation_option_id = opt.id join variation as va 
      on opt.variationID = va.VariantID where it.product_id = ?
      group by it.id
      `,
        [id]
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
// Lấy thông tin chi tiết một sản phẩm theo ID
export const getProductById = async (id) => {
  try {
    const [rows] = await database.execute(
      "SELECT * FROM products WHERE ProductId = ?",
      [id]
    );
    return rows.length > 0 ? rows[0] : null;
  } catch (error) {
    throw error;
  }
};

// Thêm sản phẩm mới
export const createProduct = async (productData) => {
  try {
    const {
      ProductName,
      Description,
      Price_show,
      Price_origin,
      Brand,
      StockQuantity,
      screen_size,
      screen_technology,
      rear_camera,
      front_camera,
      Chipset,
      RAM_capacit,
      internal_storage,
      pin,
      SIM_card,
      OS,
      screen_resolution,
      screen_features,
    } = productData;

    // Kiểm tra xem có giá trị nào bị undefined không
    if (!ProductName || Price_show == null || Price_origin == null) {
      throw new Error(
        "Thiếu dữ liệu cần thiết! Hãy kiểm tra lại thông tin sản phẩm."
      );
    }

    // Chuyển đổi kiểu dữ liệu
    const priceShow = parseFloat(Price_show);
    const priceOrigin = parseFloat(Price_origin);
    const stockQuantity = parseInt(StockQuantity, 10);

    if (isNaN(priceShow) || isNaN(priceOrigin) || isNaN(stockQuantity)) {
      throw new Error("Dữ liệu không hợp lệ! Giá hoặc số lượng phải là số.");
    }

    const query = `
            INSERT INTO products
            (ProductName, Description, Price_show, Price_origin, Brand, StockQuantity, 
            screen_size, screen_technology, rear_camera, front_camera, Chipset, 
            RAM_capacit, internal_storage, pin, SIM_card, OS, screen_resolution, screen_features) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

    const [result] = await database.execute(query, [
      ProductName || null,
      Description || null,
      Price_show || null,
      Price_origin || null,
      Brand || null,
      StockQuantity || null,
      screen_size || null,
      screen_technology || null,
      rear_camera || null,
      front_camera || null,
      Chipset || null,
      RAM_capacit || null,
      internal_storage || null,
      pin || null,
      SIM_card || null,
      OS || null,
      screen_resolution || null,
      screen_features || null,
    ]);

    return { id: result.insertId, ...productData };
  } catch (error) {
    throw error;
  }
};

// Cập nhật thông tin sản phẩm theo ID
export const updateProduct = async (id, productData) => {
  try {
    // Kiểm tra nếu ID không hợp lệ
    if (!id) {
      throw new Error("ID sản phẩm không hợp lệ");
    }

    // Kiểm tra xem sản phẩm có tồn tại không
    const [existingProduct] = await database.execute(
      "SELECT * FROM products WHERE ProductID = ?",
      [id]
    );

    if (existingProduct.length === 0) {
      return null; // Không tìm thấy sản phẩm
    }

    // Lấy danh sách các cột trong bảng
    const [columns] = await database.execute("SHOW COLUMNS FROM products");
    const columnNames = columns.map((col) => col.Field);

    // Lọc ra các trường hợp lệ trong productData
    const updateFields = Object.keys(productData).filter((key) =>
      columnNames.includes(key)
    );

    if (updateFields.length === 0) {
      throw new Error("Không có dữ liệu hợp lệ để cập nhật");
    }

    // Tạo danh sách các trường cần cập nhật
    const updateQuery = updateFields.map((field) => `${field} = ?`).join(", ");
    const values = updateFields.map((field) => productData[field] ?? null); // Tránh undefined

    // Thực hiện truy vấn UPDATE
    const query = `UPDATE products SET ${updateQuery} WHERE ProductID = ?`;
    const [result] = await database.execute(query, [...values, id]);

    return result.affectedRows > 0 ? { id, ...productData } : null;
  } catch (error) {
    throw error;
  }
};

// Xóa sản phẩm theo ID
export const deleteProduct = async (id) => {
  try {
    const [result] = await database.execute(
      "DELETE FROM products WHERE productid = ?",
      [id]
    );
    return result.affectedRows > 0;
  } catch (error) {
    throw error;
  }
};
