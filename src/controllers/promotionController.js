import * as pro from '../services/promotionService.js';

export const getPromotion = async (req, res) => {
    try {
        const result = await pro.getPromotions();
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy Promotions thất bại' ,error:error.message});
    }
}

export const createPromotion = async (req, res) => {
    try {
        const { PromotionName, Description, DiscountRate, StartDate, EndDate } = req.body;
        if (!PromotionName || !Description || !DiscountRate || !StartDate || !EndDate) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await pro.createPromotion(PromotionName, Description, DiscountRate, StartDate, EndDate);      
        return res.json({ message: "Tạo Promotion thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Tạo Promotion thất bại", error: error.message });
    }
}

export const updatePromotion = async (req, res) => {
    try {
        const {id} = req.params;
        const { PromotionName, Description, DiscountRate, StartDate, EndDate } = req.body;
        if (!id || !PromotionName || !Description || !DiscountRate || !StartDate || !EndDate ) {
            return res.status(400).json({ message: "Thiếu dữ liệu cần thiết!" });
        }
        const result = await pro.updatePromotion(id, PromotionName, Description, DiscountRate, StartDate, EndDate);
        return res.json({ message: "Cập nhật Promotion thành công!", result });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Cập nhật Promotion thất bại", error: error.message });
    }
}

