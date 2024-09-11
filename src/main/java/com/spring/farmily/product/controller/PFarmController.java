package com.spring.farmily.product.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;  // 추가된 부분

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
import com.spring.farmily.product.model.farm.FarmProductService;

@RequestMapping("/farm/product")
@Controller
public class PFarmController {

    @Autowired
    private FarmProductService farmProductService;

    @RequestMapping
    public String listMyProducts(
        @RequestParam(value = "page", defaultValue = "1") int page, 
        @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
        ProductVO vo, 
        Model model, 
        HttpSession session) {
    	//defaultValue = "1" ->페이지값전달받지 않으면 기본값 1 ,required = false-> 필수사항x
    	
        // 세션에서 사용자 ID 가져오기
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/user/login";
        }

        // VO에 사용자 ID와 검색 키워드 설정
        vo.setId(userId);
        vo.setSearchKeyword(searchKeyword);

     // 페이징 정보 계산
        int listCount = farmProductService.getProductCount(vo);  // 전체 게시물 수
        int limit = 10;  // 한 페이지에 표시할 항목 수
        int pagingUnit = 5;  // 페이지 바에 표시할 페이지 번호 수

        // 상품 리스트 가져오기 (페이징 처리된 데이터)
        List<ProductVO> productList = farmProductService.getProductsByPage(vo, page, limit);

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
        model.addAttribute("myProducts", productList); // 상품 목록을 JSP에 전달
        model.addAttribute("searchKeyword", searchKeyword); // 검색 키워드를 JSP에 전달

        return "/farm/product/productList";
    }

    @RequestMapping("/detail/{pcode}")
    public String productDetail(@PathVariable("pcode") String pcode, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        ProductVO product = farmProductService.getProductByCode(pcode);
        
        if (product == null) {
           
            return "redirect:/farm/product"; // 또는 에러 페이지로 리다이렉트
        }
        
        if (product.getPimg() != null) {
            String[] images = product.getPimg().split(",");
            model.addAttribute("mainImage", images[0]); // 첫 번째 이미지를 메인 이미지로 설정
            model.addAttribute("thumbnailImages", Arrays.asList(images)); // 나머지 이미지를 썸네일로 설정
        }
        
        model.addAttribute("product", product);
        model.addAttribute("page", page); 
        
        return "/farm/product/productDetail";
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insertProduct(@ModelAttribute ProductVO vo, HttpServletRequest request, HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        String userId = (String) session.getAttribute("id");  // 세션에서 사용자 ID 가져오기
        if (userId == null) {
            return "redirect:/user/login";  // 사용자가 로그인되지 않았다면 로그인 페이지로 리다이렉트
        }
        vo.setId(userId);

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
        farmProductService.insertProduct(vo);

        try {
            // 등록된 상품의 pcode 가져오기
            String pcode = vo.getPcode();  // 등록된 상품의 pcode를 가져옵니다.
            
            // 검색 키워드를 인코딩
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";

            // 등록 후 해당 제품의 상세 페이지로 리다이렉트
            return "redirect:/farm/product/detail/" + pcode 
                   + "?page=" + page 
                   + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 발생 시 상품 목록 페이지로 리다이렉트
            return "redirect:/farm/product";
        }
    }

    @RequestMapping(value = "/insertPage", method = RequestMethod.GET)
    public String showRegisterPage(Model model, HttpSession session) {
        String userId = (String) session.getAttribute("id");  // 세션에서 사용자 ID 가져오기
        if (userId == null) {
            return "redirect:/user/login";  // 사용자가 로그인되지 않았다면 로그인 페이지로 리다이렉트
        }

        ProductVO productInfo = farmProductService.getFarmInfoByUserId(userId);
        model.addAttribute("product", productInfo);
        return "/farm/product/productInsert"; 
    }

    @RequestMapping(value = "/updatePage/{pcode}", method = RequestMethod.GET)
    public String updatePageProduct(@PathVariable("pcode") String pcode, Model model) {
        ProductVO product = farmProductService.getProductByCode(pcode);
        model.addAttribute("product", product);
        return "/farm/product/productUpdate";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateProduct(@ModelAttribute ProductVO vo, 
                                HttpServletRequest request, 
                                @RequestParam(value = "page", defaultValue = "1") int page, 
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                @RequestParam(value = "existingFileName", required = false, defaultValue = "") String existingFileName) {
        
        MultipartFile[] uploadFiles = vo.getUploadFiles();
        String uploadPath = request.getServletContext().getRealPath("/") + "/resources/img/";

        // 새로운 파일이 없으면 기존 파일명 유지
        if (uploadFiles == null || uploadFiles.length == 0 || uploadFiles[0].isEmpty()) {
            vo.setPimg(existingFileName);  // 기존 파일명을 설정
        } else {
            // 새로운 파일이 있을 경우 파일 업로드 처리
            StringBuilder uploadedFileNames = new StringBuilder();
            for (MultipartFile uploadFile : uploadFiles) {
                if (!uploadFile.isEmpty()) {
                    try {
                        String fileName = uploadFile.getOriginalFilename();
                        File dir = new File(uploadPath);
                        if (!dir.exists()) {
                            dir.mkdirs();  // 디렉토리 생성
                        }
                        uploadFile.transferTo(new File(uploadPath + fileName));
                        if (uploadedFileNames.length() > 0) {
                            uploadedFileNames.append(",");
                        }
                        uploadedFileNames.append(fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            vo.setPimg(uploadedFileNames.toString());  // 새 파일명 설정
        }

        // 상품 업데이트 서비스 호출
        farmProductService.updateProduct(vo);

        try {
            String encodedPcode = URLEncoder.encode(vo.getPcode(), "UTF-8");
            String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";
            return "redirect:/farm/product/detail/" + encodedPcode + "?page=" + page + "&searchKeyword=" + encodedKeyword;
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/farm/product";
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deleteProduct(@RequestParam("pcode") String pcode, 
                                @RequestParam(value = "page", defaultValue = "1") int page, 
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        farmProductService.deleteProduct(pcode);
        try {
            searchKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  // 예외가 발생하면 로그 출력 (혹은 다른 처리를 할 수 있음)
        }
        return "redirect:/farm/product?page=" + page + "&searchKeyword=" + searchKeyword;
    }

    @RequestMapping(value = "/deleteMultiple", method = RequestMethod.POST)
    public String deleteMultipleProducts(@RequestParam("pcode") List<String> pcodes, 
                                         @RequestParam(value = "page", defaultValue = "1") int page, 
                                         @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
        for (String pcode : pcodes) {
            farmProductService.deleteProduct(pcode);
        }
        try {
            searchKeyword = URLEncoder.encode(searchKeyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return "redirect:/farm/product?page=" + page + "&searchKeyword=" + searchKeyword;
    }

    @RequestMapping("/checkPcode")
    @ResponseBody
    public Map<String, Boolean> checkPcode(@RequestParam("pcode") String pcode) {
        boolean Available = farmProductService.isPcodeAvailable(pcode);
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", Available);
        return response;
    }
}