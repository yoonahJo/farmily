package com.spring.farmily.product.model;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("productService")
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;
    
    @Override
    public List<ProductVO> getProductsByPtype(String ptype) {
        ProductVO searchCriteria = new ProductVO();
        searchCriteria.setPtype(ptype);
        return productDao.getProductsByPtype(searchCriteria);

    }
    
    @Override
    public List<ProductVO> getTopProducts() {
        return productDao.getTopProducts();
    }
    
    
    @Override
    public List<ProductVO> getProductsByType(String ptype, int offset, int pageSize) {
        return productDao.getProductList(ptype, offset, pageSize);
    }

    @Override
    public ProductVO getProductByCode(String pcode) {
        return productDao.getProductByCode(pcode);
    }
    
    @Override
    public ProductVO getProductByCodeDetail(String pcode) {
        return productDao.getProductByCodeDetail(pcode);
    }
    
    @Override
    public List<ProductVO> searchProducts(String keyword, String ptype, int offset, int pageSize) {
        return productDao.searchProducts(keyword, ptype, offset, pageSize);
    }

    @Override
    public int getTotalProducts(String ptype) {
        return productDao.getTotalProducts(ptype);
    }

    @Override
    public int getTotalProductsByKeyword(String keyword, String ptype) {
        return productDao.getTotalProductsByKeyword(keyword, ptype);
    }
}
