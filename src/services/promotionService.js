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