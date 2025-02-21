import database from "../database/database.js";

export const addOrder = (userid, totalAmount) =>
new Promise(async (resolve, reject) => {
    try {
        const query =
        `INSERT INTO orders (UserID ,OrderDate, TotalAmount, Status) VALUES (?, ?, ?, ?)`;
        const currentTime = new Date();
        const result = await database.execute(query, 
            [
                userid,
                currentTime,
                totalAmount,
                1,
            ]
        );
        resolve(result);
    } catch (error) {
        reject(error);
    }
});
export const getOrders = () =>
    new Promise(async(resolve, reject) => {
        try {
            const query  = 
            `SELECT * FROM orders WHERE`;
            const result = await database.execute(query);
            resolve(result);
        } catch (error) {  
            reject(error);         
        }
    })
export const getOrderByID = (OrderID) =>
    new Promise(async(resolve, reject) => {
        try {
            const query = 
            `SELECT * FROM orders WHERE OrderID = ?`;
            const result = await database.execute(query, [OrderID]);
            resolve(result);
        } catch (error) {
            reject(error);
        }
    })
// export const getOrderbyDate = (startDate, endDate) => 
//     new Promise(async(resolve, reject) => {
//         try {
//             const query =
//             `SELECT * FROM orders WHERE (OrderDate BETWEEN ? AND ?)`;
//             const result = await database.execute(query, [startDate, endDate]);
//             resolve(result);
//         } catch (error) {
//             reject(error)
//         }
//     })