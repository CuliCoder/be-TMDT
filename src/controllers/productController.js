import * as productService from "../services/productService.js";

// Lấy danh sách sản phẩm
export const getProducts = async (req, res) => {
  try {
    console.log("🔍 [GET] /products - Lấy danh sách sản phẩm");
    const products = await productService.getAllProducts();
    res.status(200).json(products); 
  } catch (error) {
    res.status(500).json({ message: "Lỗi lấy danh sách sản phẩm", error: error.message });
  }
};
// Lấy chi tiết một sản phẩm
export const getProduct = async (req, res) => {
  try {
    console.log(`🔍 [GET] /products/${req.params.id} - Lấy sản phẩm`);
    const product = await productService.getProductById(req.params.id);
    if (!product) {
      return res.status(404).json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    res.json({ success: true, data: product });
  } catch (error) {
    res.status(500).json({ success: false, message: "Lỗi khi lấy sản phẩm", error: error.message });
  }
};
export const get_product_item = async (req, res) => {
  try {
    const product = await productService.get_product_item(req.params.id);
    if (!product) {
      return res.status(404).json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    return res.status(200).json({ success: true, data: product });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Lỗi khi lấy sản phẩm", error: error.message });
  }
}
export const get_product_item_all = async (req, res) => {
  try {
    const product = await productService.get_product_item_all();
    console.log(product)
    // if (!product) {
    //   return res.status(404).json({ success: false, message: "Không tìm thấy sản phẩm" });
    // }
    return res.status(200).json({ success: true, data: product });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Lỗi khi lấy sản phẩm", error: error.message });
  }
}
// Tạo sản phẩm mới
export const createProduct = async (req, res) => {
  try {
    console.log("🛠️ [POST] /products - Dữ liệu nhận được:", req.body);
    const product = await productService.createProduct(req.body);
    res.status(201).json({ success: true, message: "Tạo sản phẩm mới thành công", data: product });
  } catch (error) {
    res.status(500).json({ success: false, message: "Lỗi khi tạo sản phẩm", error: error.message });
  }
};

// Cập nhật sản phẩm
export const updateProduct = async (req, res) => {
  try {
    console.log(`✏️ [PUT] /products/${req.params.id} - Dữ liệu nhận được:`, req.body);
    const product = await productService.updateProduct(req.params.id, req.body);
    if (!product) {
      return res.status(404).json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    res.json({ success: true, message: "Cập nhật sản phẩm thành công", data: product });
  } catch (error) {
    res.status(500).json({ success: false, message: "Lỗi khi cập nhật sản phẩm", error: error.message });
  }
};

// Xóa sản phẩm
export const deleteProduct = async (req, res) => {
  try {
    console.log(`🗑️ [DELETE] /products/${req.params.id} - Yêu cầu xóa sản phẩm`);
    const product = await productService.deleteProduct(req.params.id);
    if (!product) {
      return res.status(404).json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    res.json({ success: true, message: "Xóa sản phẩm thành công" });
  } catch (error) {
    res.status(500).json({ success: false, message: "Lỗi khi xóa sản phẩm", error: error.message });
  }
};
