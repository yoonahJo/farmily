package com.spring.farmily.product.model.admin;

import java.util.List;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.user.model.UserVO;

public interface AdminProductService {
    public List<ProductVO> getAllProducts(ProductVO vo); //전체리스트(admin)
    ProductVO getProductByCode(String pcode); //상세페이지
    void insertProduct(ProductVO product); //상품등록
    void updateProduct(ProductVO product); //수정
    void deleteProduct(String pcode); //삭제
    List<UserVO> searchFarmersByName(String keyword); // 농부 검색 메서드
    boolean isPcodeAvailable(String pcode);
    List<ProductVO> getAllProductsByPage(ProductVO vo, int page, int limit); // 페이징 처리된 상품 리스트
    int getAllProductCount(ProductVO vo); // 상품 수 카운트
}