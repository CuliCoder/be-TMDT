import connection from "../database/database.js";

export const getPromotions = async () => {
    try {
        const query = "SELECT * FROM promotions";
        const [result] = await connection.execute(query);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const createPromotion = async (PromotionName, Description, DiscountRate, StartDate, EndDate) => {
    try {
        const query = `
            INSERT INTO promotions (PromotionName, Description, DiscountRate, StartDate, EndDate)
            VALUES (?, ?, ?, ?, ?)
        `;
        await connection.execute(query, [PromotionName, Description, DiscountRate, StartDate, EndDate]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}



export const updatePromotion = async (PromotionID, PromotionName, Description, DiscountRate, StartDate, EndDate) => {
    try {
        const query = `
            UPDATE promotions
            SET PromotionName = ?, Description = ?, DiscountRate = ?, StartDate = ?, EndDate = ?
            WHERE PromotionID = ?
        `;
        await connection.execute(query, [PromotionName, Description, DiscountRate, StartDate, EndDate, PromotionID]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const deletePromotion = async (PromotionID) => {
    try {
        const query = "DELETE FROM promotions WHERE PromotionID = ?";
        await connection.execute(query, [PromotionID]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}


export const getProductWithPromotion = async (id) => {
    try {
        const query = `
            SELECT p.ProductID, p.ProductName,
            CASE WHEN pp.PromotionID IS NOT NULL THEN 1 ELSE 0 END as IsPromotion
            FROM products as p
            LEFT JOIN productpromotions as pp ON p.ProductID = pp.ProductID AND pp.PromotionID = ?
            where p.status = 1
        `;
        const [result] = await connection.execute(query, [id]);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
};

export const applyPromotion = async (id, products) => {
    try {
        const query = `
            delete from productpromotions where PromotionID = ?;
        `;
        await connection.execute(query, [id]);
        if (products.length>0){
            const so_luong = products.map(() => "(?, ?)").join(',');
            const query = `
                insert into productpromotions (ProductID, PromotionID) values ${so_luong};
            `;
            const values = products.flatMap(pd => [pd, id]);
            const [result] = await connection.execute(query,values);
            return result;
        }
    }
    catch (error) {
        console.error(error);
        throw error;
    }
} 
export const getpercent_by_productID = async (product_item_ID) => {
    try {
        console.log(product_item_ID);
        const query = `
            SELECT p.DiscountRate
            FROM promotions as p
            JOIN productpromotions as pp ON p.PromotionID = pp.PromotionID
            WHERE pp.Product_item_ID = ? AND CURDATE() BETWEEN p.StartDate AND p.EndDate
        `;
        const [result] = await connection.execute(query, [product_item_ID]);
        return result[0]?.DiscountRate || 0;
    } catch (error) {
        console.error(error);
        throw error;
    }
}