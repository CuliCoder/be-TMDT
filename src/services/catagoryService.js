import connection from "../database/database.js";

export const getCatagory = async () => {
    try {
        const query = "SELECT * FROM categories";
        const [result] = await connection.execute(query);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const createCatagory = async (CategoryName ) => {
    try {
        const query = `
            INSERT INTO categories (CategoryName)
            VALUES (?)
        `;
        await connection.execute(query, [CategoryName ]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const updateCatagory = async (CategoryID , CategoryName) => {
    try {
        const query = `
            UPDATE categories
            SET CategoryName = ?
            WHERE CategoryID  = ?
        `;
        await connection.execute(query, [CategoryName, CategoryID]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const deleteCatagory = async (CategoryID) => {
    try {
        const query = "DELETE FROM categories WHERE CategoryID = ?";
        await connection.execute(query, [CategoryID]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}