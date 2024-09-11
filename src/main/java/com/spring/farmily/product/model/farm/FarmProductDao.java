package com.spring.farmily.product.model.farm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.product.model.ProductVO;

@Repository
public class FarmProductDao {
    @Autowired
    private SqlSessionTemplate mybatis;
    
  
    
    public List<ProductVO> getFarmerProductList(ProductVO vo) {
        return mybatis.selectList("ProductDao.getFarmerProductList", vo);
    }
    
    public ProductVO getProductByCode(String pcode) {
        return mybatis.selectOne("ProductDao.agetProductByCode", pcode);
    }
    
    public void insertProduct(ProductVO product) {
        mybatis.insert("ProductDao.insertProductWithUserInfo", product);
    }

    public void updateProduct(ProductVO product) {
        mybatis.update("ProductDao.updateProduct", product);
    }

    public void deleteProduct(String pcode) {
        mybatis.delete("ProductDao.deleteProduct", pcode);
    }
    public boolean isPcodeAvailable(String pcode) {
        Integer count = mybatis.selectOne("ProductDao.countPcode", pcode);
        return count == 0;
    }
    public ProductVO getFarmInfoByUserId(String userId) {
        return mybatis.selectOne("ProductDao.getFarmInfoByUserId", userId); 
    }
    public List<ProductVO> getProductsByPage(ProductVO vo, int offset, int limit) {
        // MyBatis로 전달할 매개변수들을 Map에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("id", vo.getId());
        params.put("searchKeyword", vo.getSearchKeyword());
        params.put("offset", offset);
        params.put("limit", limit);

        return mybatis.selectList("ProductDao.getProductsByPage", params);
    }

    public int getProductCount(ProductVO vo) {
        return mybatis.selectOne("ProductDao.getProductCount", vo);
    }
}