import * as imageService from "../services/imageService.js";
import path from "path";
import { fileURLToPath } from "url";
import multer from "multer";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Cấu hình multer để lưu ảnh vào thư mục `public/products`
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../public/products")); // Lưu ảnh vào thư mục `public/products`
  },
  filename: (req, file, cb) => {
    const imageId = Date.now(); // Tạo ID ảnh dựa trên timestamp
    cb(null, `${imageId}.jpg`); // Lưu file dưới dạng `imageId.jpg`
  },
});

const upload = multer({ storage });

// Lấy danh sách hình ảnh
export const getImages = async (req, res) => {
  try {
    console.log("🔍 [GET] /images - Lấy danh sách hình ảnh");
    const images = await imageService.getAllImages();
    res.status(200).json(images); 
  } catch (error) {
    res.status(500).json({ message: "Lỗi lấy danh sách hình ảnh", error: error.message });
  }
};

// Lấy chi tiết một hình ảnh
export const getImage = async (req, res) => {
  try {
    console.log(`🔍 [GET] /images/${req.params.id} - Lấy hình ảnh`);
    const image = await imageService.getImageById(req.params.id);
    if (!image) {
      return res.status(404).json({ success: false, message: "Không tìm thấy hình ảnh" });
    }
    res.json({ success: true, data: image });
  } catch (error) {
    res.status(500).json({ success: false, message: "Lỗi khi lấy hình ảnh", error: error.message });
  }
};

export const createImage = async (req, res) => {
  try {
    const { ProductID } = req.body;
    const file = req.file; // Lấy file từ multer

    if (!ProductID || !file) {
      return res.status(400).json({ success: false, message: "Thiếu dữ liệu!" });
    }

    console.log("🛠️ [POST] /images - Dữ liệu nhận được:", req.body);

    // Lưu vào database trước để lấy `imageId`
    const image = await imageService.createImage(ProductID, "temp"); // Tạo tạm

    // Tạo đường dẫn ảnh chính xác
    const ImageID = 100000 + image.ImageID; // 100000 + ImageID từ DB
    const ImageURL = `/products/${ImageID}`;

    const newFilePath = path.join(__dirname, `../public/products/${ImageID}.jpg`);
    fs.renameSync(file.path, newFilePath); // Di chuyển file

    // Cập nhật đường dẫn ảnh vào database
    await imageService.updateImageURL(image.ImageID, ImageURL);

    res.status(201).json({ 
      success: true, 
      message: "Thêm hình ảnh mới thành công", 
      data: { ImageID, ProductID, ImageURL }
    });

  } catch (error) {
    console.error("❌ Lỗi khi thêm hình ảnh:", error);
    res.status(500).json({ success: false, message: "Lỗi server", error: error.message });
  }
};




