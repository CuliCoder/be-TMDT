import connection from "../database/database.js";

export const getPromotions = async () => {
    try {
        const query = "select * from promotions";
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

export const getProductWithPromotion = async (id) => {
    try {
        const query = `
            SELECT p.ProductID, p.ProductName,
            CASE WHEN pp.PromotionID IS NOT NULL THEN 1 ELSE 0 END as IsPromotion
            FROM products as p
            LEFT JOIN productpromotions as pp ON p.ProductID = pp.ProductID AND pp.PromotionID = ?
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