package com.spring.farmily.product.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDao {
    @Autowired
    private SqlSessionTemplate mybatis;
    
    public List<ProductVO> getProductsByPtype(ProductVO searchCriteria) {
        return mybatis.selectList("getProductsByPtype", searchCriteria);
    }
    
    public List<ProductVO> getTopProducts() {
        return mybatis.selectList("ProductDao.getTopProducts");
    }
    
    public List<ProductVO> getProductList(String ptype, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("ptype", ptype);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return mybatis.selectList("ProductDao.getProductList", params);
    }

    public ProductVO getProductByCode(String pcode) {
        return mybatis.selectOne("ProductDao.getProductByCode", pcode);
    }
    
    public ProductVO getProductByCodeDetail(String pcode) {
        return mybatis.selectOne("ProductDao.getProductByCodeDetail", pcode);
    }
    
    public List<ProductVO> searchProducts(String keyword, String ptype, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("ptype", ptype);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return mybatis.selectList("ProductDao.searchProducts", params);
    }

    public int getTotalProducts(String ptype) {
        return mybatis.selectOne("ProductDao.getTotalProducts", ptype);
    }

    public int getTotalProductsByKeyword(String keyword, String ptype) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("ptype", ptype);
        return mybatis.selectOne("ProductDao.getTotalProductsByKeyword", params);
    }
}
