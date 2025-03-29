import connection from "../database/database.js";

export const getBrands = async () => {
    try {
        const query = "SELECT * FROM brand";
        const [result] = await connection.execute(query);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const createBrand = async (name) => {
    try {
        const query = `
            INSERT INTO brand (name)
            VALUES (?)
        `;
        await connection.execute(query, [name]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const updateBrand = async (idbrand, name) => {
    try {
        const query = `
            UPDATE brand
            SET name = ?
            WHERE idbrand = ?
        `;
        await connection.execute(query, [name, idbrand]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}

export const deleteBrand = async (idbrand) => {
    try {
        const query = "DELETE FROM brand WHERE idbrand = ?";
        await connection.execute(query, [idbrand]);
    } catch (error) {
        console.error(error);
        throw error;
    }
}