package com.spring.farmily.product.model.farm;

import java.util.List;

import com.spring.farmily.product.model.ProductVO;

public interface FarmProductService {
  
	public List<ProductVO> getProductsByFarmerId(ProductVO vo);//자기리스트(farmer)
    ProductVO getProductByCode(String pcode); //상세페이지
    void insertProduct(ProductVO product); //상품등록
    void updateProduct(ProductVO product); //수정
    void deleteProduct(String pcode); //삭제
    boolean isPcodeAvailable(String pcode);
    ProductVO getFarmInfoByUserId(String userId);
    List<ProductVO> getProductsByPage(ProductVO vo, int page, int limit); // 페이징 처리된 상품 리스트
    public int getProductCount(ProductVO vo); // 상품 수 카운트
}