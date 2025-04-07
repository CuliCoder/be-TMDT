import * as cartService from "../services/cart.js";
export const getCart = async (req, res) => {
  try {
    const userID = req.query.userID;
    const carts = await cartService.getCart(userID);
    return res.status(200).json(carts);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};
export const addToCart = async (req, res) => {
  try {
    const userID = req.body.userID;
    const Product_Item_ID = req.body.Product_Item_ID;
    const quantity = req.body.quantity;
    const result = await cartService.addToCart(userID, Product_Item_ID, quantity);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};
export const updateCart = async (req, res) => {
  try {
    const userID = req.body.userID;
    const product_item_ID = req.body.product_item_ID;
    const quantity = req.body.quantity;
    const result = await cartService.updateCart(userID, product_item_ID, quantity);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};
export const removeFromCart = async (req, res) => {
  try {
    const userID = req.params.userid;
    const product_item_ID = req.params.id;
    const result = await cartService.removeFromCart(userID, product_item_ID);
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server" + error,
    });
  }
};
