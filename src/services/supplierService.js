import connection from '../database/database.js';

export const getSuppliers = async () => {
    const query = "SELECT * FROM suppliers";
    const [result] = await connection.execute(query);
    return result;
};

export const getSupplierById = async (id) => {
    const query = "SELECT * FROM suppliers WHERE SupplierID = ?";
    const [result] = await connection.execute(query, [id]);
    return result;
};

export const addSupplier = async (SupplierName, ContactName, ContactEmail, ContactPhone, Address) => {
    const query = `
        INSERT INTO suppliers (SupplierName, ContactName, ContactEmail, ContactPhone, Address)
        VALUES (?, ?, ?, ?, ?)
    `;
    await connection.execute(query, [SupplierName, ContactName, ContactEmail, ContactPhone, Address]);
};

export const updateSupplier = async (id, SupplierName, ContactName, ContactEmail, ContactPhone, Address) => {
    const query = `
        UPDATE suppliers 
        SET SupplierName = ?, ContactName = ?, ContactEmail = ?, ContactPhone = ?, Address = ?
        WHERE SupplierID = ?
    `;
    await connection.execute(query, [SupplierName, ContactName, ContactEmail, ContactPhone, Address, id]);
};

export const deleteSupplier = async (id) => {
    const query = "DELETE FROM suppliers WHERE SupplierID = ?";
    await connection.execute(query, [id]);
};

// export const statusSupplier = async (id, status) => {
//     const query = "UPDATE suppliers SET status = ? WHERE SupplierID = ?";
//     await connection.execute(query, [status, id]);
// };
