import * as sup from '../services/supplierService.js';

export const getSuppliers = async (req, res) => {
    try {
        const suppliers = await sup.getSuppliers();
        res.status(200).json(suppliers);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Lấy danh sách nhà cung cấp thất bại', error: error.message });
    }
};

export const getSupplierById = async (req, res) => {
    try {
        const { id } = req.params;
        const supplier = await sup.getSupplierById(id);
        res.status(200).json(supplier);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Lấy thông tin nhà cung cấp thất bại', error: error.message });
    }
};

export const addSupplier = async (req, res) => {
    try {
        const { SupplierName, ContactName, ContactEmail, ContactPhone, Address } = req.body;
        await sup.addSupplier(SupplierName, ContactName, ContactEmail, ContactPhone, Address);
        res.status(201).json({ message: 'Thêm nhà cung cấp thành công' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Thêm nhà cung cấp thất bại', error: error.message });
    }
};

export const updateSupplier = async (req, res) => {
    try {
        const { id } = req.params;
        const { SupplierName, ContactName, ContactEmail, ContactPhone, Address } = req.body;
        await sup.updateSupplier(id, SupplierName, ContactName, ContactEmail, ContactPhone, Address);
        res.status(200).json({ message: 'Cập nhật nhà cung cấp thành công' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Cập nhật nhà cung cấp thất bại', error: error.message });
    }
};

export const deleteSupplier = async (req, res) => {
    try {
        const { id } = req.params;
        await sup.deleteSupplier(id);
        res.status(200).json({ message: 'Xóa nhà cung cấp thành công' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Xóa nhà cung cấp thất bại', error: error.message });
    }
};

export const statusSupplier = async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;
        await sup.statusSupplier(id, status);
        res.status(200).json({ message: 'Cập nhật trạng thái thành công' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Cập nhật trạng thái thất bại', error: error.message });
    }
};
