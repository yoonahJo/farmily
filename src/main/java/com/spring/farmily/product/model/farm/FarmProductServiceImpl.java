package com.spring.farmily.product.model.farm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.product.model.ProductVO;

@Service
public class FarmProductServiceImpl implements FarmProductService {

    @Autowired
    private FarmProductDao farmProductDao;

    @Override
    public List<ProductVO> getProductsByFarmerId(ProductVO vo) {
        return farmProductDao.getFarmerProductList(vo);
    }
    @Override
    public ProductVO getProductByCode(String pcode) {
        return farmProductDao.getProductByCode(pcode);
    }
    @Override
    public void insertProduct(ProductVO product) {
    	farmProductDao.insertProduct(product);
    }
    @Override
    public void updateProduct(ProductVO product) {
    	farmProductDao.updateProduct(product);
    }

    @Override
    public void deleteProduct(String pcode) {
    	farmProductDao.deleteProduct(pcode);
    }
    @Override
    public boolean isPcodeAvailable(String pcode) {
        return farmProductDao.isPcodeAvailable(pcode);
    }
    @Override
    public ProductVO getFarmInfoByUserId(String userId) {
        return farmProductDao.getFarmInfoByUserId(userId);
    }
    @Override
    public List<ProductVO> getProductsByPage(ProductVO vo, int page, int limit) {
        int offset = (page - 1) * limit;  // 페이징에 맞게 offset 계산
        return farmProductDao.getProductsByPage(vo, offset, limit);
    }

    @Override
    public int getProductCount(ProductVO vo) {
        return farmProductDao.getProductCount(vo);  // 전체 상품 수
    }
}