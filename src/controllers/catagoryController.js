import * as catagoryService from '../services/catagoryService.js';

export const getCatagory = async (req, res) => {
    try {
        const result = await catagoryService.getCatagory();
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy danh sách loại thất bại', error: error.message });
    }
}

export const createCatagory = async (req, res) => {
    try {
        const { CategoryName  } = req.body;
        if (!CategoryName ) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await catagoryService.createCatagory(CategoryName );
        return res.json({ message: "Tạo loại thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Tạo loại thất bại", error: error.message });
    }
}

export const updateCatagory = async (req, res) => {
    try {
        const { id } = req.params;
        const { CategoryName } = req.body;
        if (!id || !CategoryName) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await catagoryService.updateCatagory(id, CategoryName);
        return res.json({ message: "Cập nhật loại thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Cập nhật loại thất bại", error: error.message });
    }
}

export const deleteCatagory = async (req, res) => {
    try {
        const { id } = req.params;
        await catagoryService.deleteCatagory(id);
        return res.status(200).json({ message: "Xóa loại thành công!" });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Xóa loại thất bại", error: error.message });
    }
}
