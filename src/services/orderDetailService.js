import database from "../database/database.js";

export const addOrderDetail = (OrderID, ProductID, Quantity, Price) => 
    new Promise(async (resolve, reject) =>{
        try {
            const query = 
            `INSERT INTO orderdetails ( OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)`;
            const result = await database.execute(query, 
                [
                    OrderID,
                    ProductID,
                    Quantity,
                    Price,
                ]
            ); 
            resolve(result);     
        } catch (error) {
            reject(error);
        }
    })
export const getOrderDetail = (OrderID) => 
    new Promise(async(resolve, reject) => {
        try {
            const query = 
            `SELECT * FROM orderdetail WHERE OrderID = ?`;
            const result = await database.execute(query, [OrderID]);
            resolve(result);
        } catch (error) {
            reject(error)
        }
    })