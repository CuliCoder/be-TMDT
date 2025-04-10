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
    const result = await cartService.addToCart(userID, productID, quantity);
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
    const result = await cartService.updateCart(
      userID,
      product_item_ID,
      quantity
    );
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

export const placeOrder = async (req, res) => {
  try {
    const userID = req.params.userid;
    const name = req.body.name;
    const phonenumber = req.body.phonenumber;
    const address = req.body.address;
    const method = req.body.method;
    const result = await cartService.placeOrder(
      userID,
      name,
      phonenumber,
      address,
      method
    );
    return res.status(200).json(result);
  } catch (error) {
    return res.status(500).json({
      error: 1,
      message: "Lỗi server",
    });
  }
};
// export const cancelOrder = async (req, res) => {
//   try {
//     const orderID = req.params.orderID;
//     const result = await cartService.cancelOrder(orderID);
//     return res.status(200).json(result);
//   } catch (error) {
//     return res.status(500).json({
//       error: 1,
//       message: "Lỗi server",
//     });
//   }
// }
