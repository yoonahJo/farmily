package com.spring.farmily.qna.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import com.spring.farmily.qna.model.QnaVO;
import com.spring.farmily.qna.model.farm.FarmQnaService;

@RequestMapping("/farm/qna")
@Controller
public class FQnaController {
    
    @Autowired
    private FarmQnaService farmQnaService;
    
  
    
    @RequestMapping
    public String getMyQna(
        @RequestParam(value = "page", defaultValue = "1") int page, 
        @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
        QnaVO vo, 
        Model model, 
        HttpSession session) {

        String userId = (String) session.getAttribute("id");  
        if (userId == null) {
            return "redirect:/user/login";  
        }
        vo.setId(userId);  
        vo.setSearchKeyword(searchKeyword);

        // 페이징 정보 계산
        int listCount = farmQnaService.getQnaCount(vo);
        int limit = 10;  // 한 페이지에 표시할 항목 수
        int pagingUnit = 5;  // 페이지 바에 표시할 페이지 번호 수

        List<QnaVO> myQnaList = farmQnaService.getQnaByPage(vo, page, limit);

        int maxPage = (int) Math.ceil((double) listCount / limit);
        int startPage = (((int) ((double) page / pagingUnit + 0.9)) - 1) * pagingUnit + 1;
        int endPage = startPage + pagingUnit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("listCount", listCount);
        model.addAttribute("myQnaList", myQnaList);
        model.addAttribute("searchKeyword", searchKeyword);

        return "/farm/qna/qnaMyList";
    }
    
    @RequestMapping("/detail/{qcode}") // 상세 페이지
    public String getQnaDetail(@PathVariable("qcode") int qcode, Model model) {
        QnaVO qna = farmQnaService.getQnaByCode(qcode);
        model.addAttribute("qna", qna);
        return "/farm/qna/qnaDetail";  // 농부용 상세 페이지
    }
    
    @RequestMapping(value = "/insertPage", method = RequestMethod.GET) // 작성 페이지
    public String showQnaForm() {
        return "/farm/qna/qnaInsert";
    }
    
    @RequestMapping(value = "/insertQna", method = RequestMethod.POST)
    public String insertQna(@ModelAttribute QnaVO vo, HttpServletRequest request, HttpSession session) {
        String userId = (String) session.getAttribute("id");  // 세션에서 사용자 ID 가져오기
        if (userId == null) {
            return "redirect:/farm/user/login";  // 사용자가 로그인되지 않았다면 로그인 페이지로 리다이렉트
        }
        vo.setId(userId);

        // 이미지 업로드 처리
        MultipartFile uploadFile = vo.getUploadFile();
        if (uploadFile != null && !uploadFile.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/") + "/resources/img/";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 디렉토리 생성
            }
            String fileName = uploadFile.getOriginalFilename();
            try {
                File file = new File(uploadPath + fileName);
                uploadFile.transferTo(file);
                vo.setImage(fileName); // 파일명을 VO에 설정
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        farmQnaService.insertQna(vo);
        return "redirect:/farm/qna"; 
    }
    @RequestMapping(value = "/rate/{qcode}", method = RequestMethod.POST)
    public String rateQna(@PathVariable("qcode") int qcode, 
                          @RequestParam("rating") int rating, 
                          @RequestParam("page") int page, 
                          @RequestParam("searchKeyword") String searchKeyword) {
        QnaVO qna = farmQnaService.getQnaByCode(qcode);
        if (qna != null) {
            qna.setRating(rating);  // 별점 설정
            farmQnaService.updateRating(qna);  // 별점 업데이트 메서드 호출
        }
        return "redirect:/farm/qna/detail/" + qcode + "?page=" + page + "&searchKeyword=" + searchKeyword;
    }
    
    @RequestMapping(value= "/updatePage/{qcode}")
    public String updatePageQna(@PathVariable("qcode") int qcode, Model model) {
    	QnaVO qna = farmQnaService.getQnaByCode(qcode);
    	model.addAttribute("qna", qna);
    	return "/farm/qna/qnaUpdate";
    }
    
    @RequestMapping(value = "/updateQna", method = RequestMethod.POST)
    public String updateQna(@ModelAttribute QnaVO vo, 
                            @RequestParam("page") int page, 
                            @RequestParam("searchKeyword") String searchKeyword,
                            @RequestParam(value = "newFile", required = false) MultipartFile newFile, 
                            @RequestParam(value = "existingFileName", required = false) String existingFileName, 
                            HttpServletRequest request) {

        // 새 파일이 없는 경우 기존 파일명을 그대로 사용
        if (newFile == null || newFile.isEmpty()) {
            vo.setImage(existingFileName);
        } else {
            // 새 파일이 있을 경우 파일 업로드 처리
            String newFileName = newFile.getOriginalFilename();
            
            try {
                String uploadPath = request.getServletContext().getRealPath("/") + "/resources/img/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // 디렉토리 생성
                }
                File file = new File(uploadPath + newFileName);
                newFile.transferTo(file);
                vo.setImage(newFileName); // 새 파일명으로 설정
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // QnA 업데이트 서비스 호출
        farmQnaService.updateQna(vo);

        // 리다이렉트 처리
        return "redirect:/farm/qna/detail/" + vo.getQcode() + "?page=" + page + "&searchKeyword=" + searchKeyword;
    }

    @RequestMapping(value = "/delete/{qcode}", method = RequestMethod.POST)
    public String deleteQna(@PathVariable("qcode") int qcode, @RequestParam("page") int page, @RequestParam("searchKeyword") String searchKeyword) {
        farmQnaService.deleteQna(qcode);
        return "redirect:/farm/qna?page=" + page + "&searchKeyword=" + searchKeyword;
    }

  

}