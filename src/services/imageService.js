import database from "../database/database.js";

// Lấy danh sách tất cả hình ảnh
export const getAllImages = async () => {
  try {
    const [rows] = await database.execute("SELECT * FROM images");
    return rows;
  } catch (error) {
    throw error;
  }
};

// Lấy thông tin chi tiết một hình ảnh theo ID
export const getImageById = async (id) => {
    try {
      const [rows] = await database.execute("SELECT * FROM images WHERE ImageID = ?", [id]);
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      throw error;
    }
  };

// Thêm ảnh mới vào bảng `images`
export const createImage = async (ProductID, ImageURL) => {
  try {
    const query = `
      INSERT INTO images (ProductID, ImageURL) 
      VALUES (?, ?)
    `;
    const [result] = await database.execute(query, [ProductID, ImageURL]);

    return { ImageID: result.insertId, ProductID, ImageURL };
  } catch (error) {
    throw error;
  }
};

// Cập nhật đường dẫn ảnh
export const updateImageURL = async (ImageID, ImageURL) => {
  try {
    const query = `UPDATE images SET ImageURL = ? WHERE ImageID = ?`;
    await database.execute(query, [ImageURL, ImageID]);
  } catch (error) {
    throw error;
  }
};