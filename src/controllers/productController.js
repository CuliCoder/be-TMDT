import * as productService from "../services/productService.js";

// Lấy danh sách sản phẩm
export const getProducts = async (req, res) => {
  try {
    console.log("🔍 [GET] /products - Lấy danh sách sản phẩm");
    const products = await productService.getAllProducts();
    return res.status(200).json(products);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Lỗi lấy danh sách sản phẩm", error: error.message });
  }
};
// Lấy chi tiết một sản phẩm
export const getProduct = async (req, res) => {
  try {
    console.log(`🔍 [GET] /products/${req.params.id} - Lấy sản phẩm`);
    const product = await productService.getProductById(req.params.id);
    if (!product) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    res.json({ success: true, data: product });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Lỗi khi lấy sản phẩm",
      error: error.message,
    });
  }
};
export const get_product_item_by_ID = async (req, res) => {
  try {
    const product = await productService.get_product_item_by_ID(req.params.id);
    if (!product) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    return res.status(200).json({ success: true, data: product });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Lỗi khi lấy sản phẩm",
      error: error.message,
    });
  }
};
export const get_product_item_by_productID = async (req, res) => {
  try {
    const product = await productService.get_product_item_by_productID(
      req.params.id
    );
    if (!product) {
      return res
        .status(404)
        .json({ success: false, message: "Không tìm thấy sản phẩm" });
    }
    return res.status(200).json({ success: true, data: product });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Lỗi khi lấy sản phẩm",
      error: error.message,
    });
  }
};
export const get_product_item_all = async (req, res) => {
  try {
    const product = await productService.get_product_item_all();
    return res.status(200).json({ success: true, data: product });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Lỗi khi lấy sản phẩm",
      error: error.message,
    });
  }
};
export const add_product_item = async (req, res) => {
  try {
    if (!req.body.product_id || !req.body.sku) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const profitMargin = parseFloat(req.body.profit_margin);
    if (isNaN(profitMargin) || profitMargin >= 100 || profitMargin < 0) {
      return res.status(400).json({
        error: 1,
        message: "Lợi nhuận không hợp lệ",
      });
    }
    if (JSON.parse(req.body.variants).length === 0) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng thêm thuộc tính sản phẩm",
      });
    }
    if (!req.file) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng chọn file ảnh",
      });
    }
    const product = await productService.add_product_item(req.body, req.file);
    return res.status(200).json(product);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const update_product_item = async (req, res) => {
  try {
    if (!req.body.product_item_id || !req.body.sku) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const profitMargin = parseFloat(req.body.profit_margin);
    if (isNaN(profitMargin) || profitMargin >= 100 || profitMargin < 0) {
      return res.status(400).json({
        error: 1,
        message: "Lợi nhuận không hợp lệ",
      });
    }
    if (JSON.parse(req.body.variants).length === 0) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng thêm thuộc tính sản phẩm",
      });
    }
    const result = await productService.edit_product_item(
      req.body,
      req.file ? req.file : null
    );
    return res.status(200).json(result);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};
export const add_product = async (req, res) => {
  try {
    if (!req.body.nameProduct || !req.body.categoryID) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    if (!req.file) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng chọn file ảnh",
      });
    }
    const product = await productService.add_product(
      req.body,
      req.file.filename
    );
    return res.status(200).json(product);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const get_product_by_productID = async (req, res) => {
  try {
    if (!req.params.id) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const product = await productService.getProductById(req.params.id);
    return res.status(200).json(product);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const update_product = async (req, res) => {
  try {
    if (!req.body.product_id || !req.body.nameProduct || !req.body.categoryID) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const result = await productService.update_product(
      req.body,
      req.file ? req.file.filename : null
    );
    return res.status(200).json(result);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};
export const add_attribute = async (req, res) => {
  try {
    if (!req.body.name || !req.body.categoryID) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const result = await productService.add_attribute(
      req.body.categoryID,
      req.body.name
    );
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const delete_product_item = async (req, res) => {
  try {
    if (!req.params.id) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const result = await productService.delete_product_item(req.params.id);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const delete_product = async (req, res) => {
  try {
    if (!req.params.id) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const result = await productService.delete_product(req.params.id);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const import_product = async (req, res) => {
  try {
    const result = await productService.import_product(req.body);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const get_product_display = async (req, res) => {
  try {
    const result = await productService.get_product_display();
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
export const get_product_item_by_categoryID = async (req, res) => {
  try {
    if (!req.params.id) {
      return res.status(400).json({
        error: 1,
        message: "Vui lòng nhập đủ thông tin",
      });
    }
    const result = await productService.get_product_item_by_categoryID(req.params.id);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json(error);
  }
};
