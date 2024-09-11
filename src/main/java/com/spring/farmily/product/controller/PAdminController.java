package com.spring.farmily.product.controller;

import java.io.File; 
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.product.model.admin.AdminProductService;
import com.spring.farmily.user.model.UserVO;

@RequestMapping("/admin/product")
@Controller
public class PAdminController {

    @Autowired
    private AdminProductService productService;
    
    @RequestMapping(value="/productList", method=RequestMethod.GET)
    public String AproductList() {
        return "/admin/product/productList"; 
    } 
    
    @RequestMapping //상품전체리스트
    public String listProducts(@RequestParam(value = "page", defaultValue = "1") int page, 
    		@RequestParam(value = "searchCondition", required = false) String searchCondition,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            
            ProductVO vo, 
            Model model, 
            HttpSession session) {
        	//defaultValue = "1" ->페이지값전달받지 않으면 기본값 1 ,required = false-> 필수사항x이란뜻
    	
    	session.getAttribute("id");
    	
    	// VO에 사용자 ID와 검색 키워드 설정
        
        vo.setSearchKeyword(searchKeyword);
        vo.setSearchCondition(searchCondition);
        
     // 페이징 정보 계산
        int listCount = productService.getAllProductCount(vo);  // 전체 게시물 수
        int limit = 10;  // 한 페이지에 표시할 항목 수
        int pagingUnit = 5;  // 페이지 바에 표시할 페이지 번호 수

        // 상품 리스트 가져오기 (페이징 처리된 데이터)
        List<ProductVO> productList = productService.getAllProductsByPage(vo, page, limit);

        // 페이징 계산
        int maxPage = (int) Math.ceil((double) listCount / limit);  // 전체 페이지 수
        int startPage = (((int) ((double) page / pagingUnit + 0.9)) - 1) * pagingUnit + 1;  // 페이징 바 시작 번호
        int endPage = startPage + pagingUnit - 1;  // 페이징 바 끝 번호
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        // 모델에 데이터 전달
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("listCount", listCount);
        model.addAttribute("allProducts", productList); // 상품 목록을 JSP에 전달
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword); // 검색 키워드를 JSP에 전달
        

        return "/admin/product/productList";
    }
    	
      
    
 
    @RequestMapping("/detail/{pcode}")
    public String productDetail(@PathVariable("pcode") String pcode, Model model) {
     
        ProductVO product = productService.getProductByCode(pcode);
        
        if (product.getPimg() != null) {
            String[] images = product.getPimg().split(",");
            model.addAttribute("mainImage", images[0]); // 첫 번째 이미지를 메인 이미지로 설정
            model.addAttribute("thumbnailImages", Arrays.asList(images)); // 나머지 이미지를 썸네일로 설정
        }
        

        model.addAttribute("product", product);
        
  
        return "/admin/product/productDetail";
    }
    
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insertProduct(@ModelAttribute ProductVO vo, 
                                HttpServletRequest request, 
                                @RequestParam(value = "page", defaultValue = "1") int page, 
                                @RequestParam(value = "searchCondition", required = false) String searchCondition, 
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        MultipartFile[] uploadFiles = vo.getUploadFiles();
        if (uploadFiles != null && uploadFiles.length > 0) {
            String uploadPath = request.getServletContext().getRealPath("/") + "/resources/img/";

            for (MultipartFile uploadFile : uploadFiles) {
                if (!uploadFile.isEmpty()) {
                    try {
                        String fileName = uploadFile.getOriginalFilename();
                        File dir = new File(uploadPath);
                        if (!dir.exists()) {
                            dir.mkdirs(); // 디렉토리 생성
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        uploadFile.transferTo(new File(filePath));
                        vo.setPimg(vo.getPimg() == null ? fileName : vo.getPimg() + "," + fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        // 상품 등록
        productService.insertProduct(vo);

        try {
            // 검색 키워드를 인코딩
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";

            // 상품 등록 후 상세 페이지로 리다이렉트
            return "redirect:/admin/product/detail/" + vo.getPcode() 
                   + "?page=" + page 
                   + "&searchCondition=" + searchCondition 
                   + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 발생 시 상품 목록 페이지로 리다이렉트
            return "redirect:/admin/product";
        }
    }
    
    
    
    @RequestMapping(value = "/insertPage", method = RequestMethod.GET)
    public String showRegisterPage() {
        return "/admin/product/productInsert"; 
    }
    
 // 상품 수정 페이지로 이동
    @RequestMapping(value = "/updatePage/{pcode}", method = RequestMethod.GET)
    public String updatePageProduct(@PathVariable("pcode") String pcode, Model model) {
        ProductVO product = productService.getProductByCode(pcode);
        model.addAttribute("product", product);
        return "/admin/product/productUpdate"; 
    }

    // 상품 수정 처리
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateProduct(@ModelAttribute ProductVO vo, 
                                HttpServletRequest request, 
                                @RequestParam(value = "page", defaultValue = "1") int page, 
                                @RequestParam(value = "searchCondition", required = false) String searchCondition, 
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        // 파일 업로드 처리
        MultipartFile[] uploadFiles = vo.getUploadFiles();
        if (uploadFiles != null && uploadFiles.length > 0) {
            String uploadPath = request.getServletContext().getRealPath("/") + "/resources/img/";
            for (MultipartFile uploadFile : uploadFiles) {
                if (!uploadFile.isEmpty()) {
                    try {
                        String fileName = uploadFile.getOriginalFilename();
                        File dir = new File(uploadPath);
                        if (!dir.exists()) {
                            dir.mkdirs(); // 디렉토리 생성
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        uploadFile.transferTo(new File(filePath));
                        vo.setPimg(vo.getPimg() == null ? fileName : vo.getPimg() + "," + fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        // 제품 정보 업데이트
        productService.updateProduct(vo);

        try {
            // 검색 키워드를 인코딩
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";

            // 수정 후 해당 제품의 상세 페이지로 리다이렉트
            return "redirect:/admin/product/detail/" + vo.getPcode() 
                   + "?page=" + page 
                   + "&searchCondition=" + searchCondition 
                   + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 발생 시 상품 목록 페이지로 리다이렉트
            return "redirect:/admin/product";
        }
    }

    // 상품 삭제 처리
    @RequestMapping(value = "/delete/{pcode}", method = RequestMethod.GET)
    public String deleteProduct(@PathVariable("pcode") String pcode,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "searchCondition", required = false) String searchCondition,
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        // 상품 삭제 로직
        productService.deleteProduct(pcode);

        try {
            // 검색 키워드를 인코딩
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";

            // 삭제 후 원래의 리스트 페이지로 리다이렉트
            return "redirect:/admin/product?page=" + page
                   + "&searchCondition=" + searchCondition
                   + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/product";
        }
    }

//상품 체크박스 멀티삭
    @RequestMapping(value = "/deleteMultiple", method = RequestMethod.POST)
    public String deleteMultipleProducts(@RequestParam("pcode") List<String> pcodes,
                                         @RequestParam(value = "page", defaultValue = "1") int page,
                                         @RequestParam(value = "searchCondition", required = false) String searchCondition,
                                         @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        for (String pcode : pcodes) {
            productService.deleteProduct(pcode);
        }
        
        try {
            // 검색 키워드를 인코딩
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";

            // 삭제 후 원래의 리스트 페이지로 리다이렉트
            return "redirect:/admin/product?page=" + page
                   + "&searchCondition=" + searchCondition
                   + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/product";
        }
    }
@RequestMapping("/searchFarmer")
@ResponseBody
public List<UserVO> searchFarmer(@RequestParam("keyword") String keyword) {
    return productService.searchFarmersByName(keyword);
}

@RequestMapping("/checkPcode")
@ResponseBody
public Map<String, Boolean> checkPcode(@RequestParam("pcode") String pcode) {
    boolean Available = productService.isPcodeAvailable(pcode);
    Map<String, Boolean> response = new HashMap<>();
    response.put("available", Available);
    return response;
}
}
