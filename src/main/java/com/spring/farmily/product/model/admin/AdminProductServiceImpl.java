package com.spring.farmily.product.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.user.model.UserVO;

@Service
public class AdminProductServiceImpl implements AdminProductService {

    @Autowired
    private AdminProductDao adminProductDao;

    @Override
    public List<ProductVO> getAllProducts(ProductVO vo) {
        return adminProductDao.getProductList(vo);
    }

    @Override
    public ProductVO getProductByCode(String pcode) {
        return adminProductDao.getProductByCode(pcode);
    }
    @Override
    public void insertProduct(ProductVO product) {
    	adminProductDao.insertProduct(product);
    }
    @Override
    public void updateProduct(ProductVO product) {
    	adminProductDao.updateProduct(product);
    }

    @Override
    public void deleteProduct(String pcode) {
    	adminProductDao.deleteProduct(pcode);
    }
    @Override
    public List<UserVO> searchFarmersByName(String keyword) {
        return adminProductDao.searchFarmersByName(keyword);
    }
    @Override
    public boolean isPcodeAvailable(String pcode) {
        return adminProductDao.isPcodeAvailable(pcode);
    }
    @Override
    public List<ProductVO> getAllProductsByPage(ProductVO vo, int page, int limit) {
        int offset = (page - 1) * limit;  // 페이징에 맞게 offset 계산
        return adminProductDao.getAllProductsByPage(vo, offset, limit);
    }

    @Override
    public int getAllProductCount(ProductVO vo) {
        return adminProductDao.getAllProductCount(vo);  // 전체 상품 수
    }
}