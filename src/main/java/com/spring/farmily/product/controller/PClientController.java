package com.spring.farmily.product.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.farmily.product.model.ProductService;
import com.spring.farmily.product.model.ProductVO;

@Controller
@RequestMapping("/product")
public class PClientController {

    @Autowired
    private ProductService productService;
    
    
    
    @RequestMapping("/top")
    @ResponseBody
    public List<ProductVO> getTopProducts() {
        List<ProductVO> topProducts = productService.getTopProducts();
        return topProducts;
    }


    
    @RequestMapping(value = "/fast", method = RequestMethod.GET)
    public String listProducts(@RequestParam(value = "ptype", required = false) String ptype, Model model) {
        try {
            model.addAttribute("products", productService.getProductsByPtype(ptype));
            model.addAttribute("ptype", ptype);
            return "product/fastList"; 
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "상품 목록을 불러오는 중 오류가 발생했습니다.");
            return "product/fastList"; 
        }
    }
    
    
    @RequestMapping("/list")
    public String listProducts(
            @RequestParam(value = "ptype", required = false) String ptype,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page, // 페이지 번호 파라미터 추가
            @RequestParam(value = "pageSize", defaultValue = "9") int pageSize, // 페이지 크기 파라미터 추가
            Model model) {
    	
        // 페이징을 위한 offset 계산
        int offset = (page - 1) * pageSize;

        List<ProductVO> productList;
        int totalProducts; // 전체 상품 수

        if (keyword != null && !keyword.trim().isEmpty()) {
            // 검색어와 제품 유형이 있을 때
            productList = productService.searchProducts(keyword, ptype, offset, pageSize);
            totalProducts = productService.getTotalProductsByKeyword(keyword, ptype);
            model.addAttribute("pageTitle", "'" + keyword + "'의 상품 검색결과");
        } else {
            // 검색어가 없을 때, 제품 유형에 따라 조회
            productList = productService.getProductsByType(ptype, offset, pageSize);
            totalProducts = productService.getTotalProducts(ptype);
            model.addAttribute("pageTitle", ptype + " 상품");
        }

        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // 페이지 그룹 설정
        int groupSize = 5; // 그룹 사이즈 (예: 5페이지씩)
        int startPage = ((page - 1) / groupSize) * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);
        // 모델에 추가 정보 설정
        model.addAttribute("products", productList);
        model.addAttribute("ptype", ptype);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        
        return "/product/productList";
    }


    
    @RequestMapping(value = "/detail/{pcode}", method = RequestMethod.GET)
    public String getProductDetail(@PathVariable("pcode") String pcode, Model model) {
        ProductVO product = productService.getProductByCode(pcode);
        model.addAttribute("product", product);
        return "/product/productDetail";
    }
}