package com.spring.farmily.product.model.admin;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.user.model.UserVO;

@Repository
public class AdminProductDao {
    @Autowired
    private SqlSessionTemplate mybatis;
    
    public List<ProductVO> getProductList(ProductVO vo) {
        return mybatis.selectList("ProductDao.agetProductList", vo);
    }   
    
    
    public ProductVO getProductByCode(String pcode) {
        return mybatis.selectOne("ProductDao.getProductByCode", pcode);
    }
    
    public void insertProduct(ProductVO product) {
        mybatis.insert("ProductDao.insertProduct", product);
    }

    public void updateProduct(ProductVO product) {
        mybatis.update("ProductDao.updateProduct", product);
    }

    public void deleteProduct(String pcode) {
        mybatis.delete("ProductDao.deleteProduct", pcode);
    }
    public List<UserVO> searchFarmersByName(String keyword) {
        return mybatis.selectList("ProductDao.searchFarmersByName", keyword);
    }
    public boolean isPcodeAvailable(String pcode) {
        Integer count = mybatis.selectOne("ProductDao.countPcode", pcode);
        return count == 0;
    }
    public List<ProductVO> getAllProductsByPage(ProductVO vo, int offset, int limit) {
        // MyBatis로 전달할 매개변수들을 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("searchCondition", vo.getSearchCondition());
        params.put("searchKeyword", vo.getSearchKeyword());
        params.put("offset", offset);
        params.put("limit", limit);

        return mybatis.selectList("ProductDao.getAllProductsByPage", params);
    }

    public int getAllProductCount(ProductVO vo) {
        return mybatis.selectOne("ProductDao.getAllProductCount", vo);
    }
}