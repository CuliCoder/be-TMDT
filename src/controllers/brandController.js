import * as brandService from '../services/brandService.js';

export const getBrands = async (req, res) => {
    try {
        const result = await brandService.getBrands();
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy danh sách hãng thất bại', error: error.message });
    }
}

export const createBrand = async (req, res) => {
    try {
        const { name } = req.body;
        if (!name) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await brandService.createBrand(name);
        return res.json({ message: "Tạo hãng thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Tạo hãng thất bại", error: error.message });
    }
}

export const updateBrand = async (req, res) => {
    try {
        const { id } = req.params;
        const { name } = req.body;
        if (!id || !name) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await brandService.updateBrand(id, name);
        return res.json({ message: "Cập nhật hãng thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Cập nhật hãng thất bại", error: error.message });
    }
}

export const deleteBrand = async (req, res) => {
    try {
        const { id } = req.params;
        await brandService.deleteBrand(id);
        return res.status(200).json({ message: "Xóa hãng thành công!" });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Xóa hãng thất bại", error: error.message });
    }
}
