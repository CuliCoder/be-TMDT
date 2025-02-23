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
    const productID = req.body.productID;
    const quantity = req.body.quantity;
    const res = await cartService.addToCart(userID, productID, quantity);
    return res.status(200).json(res);
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
    const productID = req.body.productID;
    const quantity = req.body.quantity;
    const res = await cartService.updateCart(userID, productID, quantity);
    return res.status(200).json(res);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};
export const removeFromCart = async (req, res) => {
  try {
    const userID = req.body.userID;
    const productID = req.body.productID;
    const res = await cartService.removeFromCart(userID, productID);
    return res.status(200).json(res);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};