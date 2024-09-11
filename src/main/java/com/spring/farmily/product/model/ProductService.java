package com.spring.farmily.product.model;

import java.util.List;

public interface ProductService {
	List<ProductVO> getProductsByPtype(String ptype);//빠른구매
	List<ProductVO> getTopProducts(); // 이 메서드를 추가합니다.
    List<ProductVO> getProductsByType(String ptype, int offset, int pageSize);
    ProductVO getProductByCode(String pcode);
    List<ProductVO> searchProducts(String keyword, String ptype, int offset, int pageSize);
    int getTotalProducts(String ptype);  // 전체 상품 수를 가져오는 메서드
    int getTotalProductsByKeyword(String keyword, String ptype);  // 검색어를 포함한 전체 상품 수를 가져오는 메서드
	ProductVO getProductByCodeDetail(String code);
}
