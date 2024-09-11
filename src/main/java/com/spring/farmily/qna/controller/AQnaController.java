package com.spring.farmily.qna.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.farmily.qna.model.QnaVO;
import com.spring.farmily.qna.model.admin.AdminQnaService;

@RequestMapping("/admin/qna")
@Controller
public class AQnaController {
    
    @Autowired
    private AdminQnaService adminQnaService;
    
 
    // 관리자 QnA 리스트
    @RequestMapping
    public String getAllQna(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "searchCondition", required = false) String searchCondition,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            QnaVO vo, Model model, HttpSession session) {

        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/admin";
        }
        vo.setId(userId);

        vo.setSearchKeyword(searchKeyword);
        vo.setSearchCondition(searchCondition);

        // 페이징 정보 계산
        int listCount = adminQnaService.getAllQnaCount(vo);
        int limit = 10;
        int pagingUnit = 5;

        int maxPage = (int) Math.ceil((double) listCount / limit);
        int startPage = (((int) ((double) page / pagingUnit + 0.9)) - 1) * pagingUnit + 1;
        int endPage = startPage + pagingUnit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        List<QnaVO> QnaList = adminQnaService.getAllQna(vo, page, limit);
        model.addAttribute("qnaList", QnaList);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("listCount", listCount);

        return "/admin/qna/qnaList";
    }
    
    
    @RequestMapping("/detail/{qcode}")
    public String getQnaDetail(
    		@PathVariable("qcode") int qcode,
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "searchCondition", required = false) String searchCondition,
        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
        Model model, HttpSession session) {
        
        QnaVO qna = adminQnaService.getQnaByCode(qcode);
        model.addAttribute("qna", qna);
        model.addAttribute("page", page);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword);
        
        return "/admin/qna/qnaDetail";  // 관리자용 상세 페이지
    }

    
    @RequestMapping(value = "/insertReply/{qcode}", method = RequestMethod.POST)
    public String insertReply(@PathVariable("qcode") int qcode, 
                              @ModelAttribute QnaVO vo,
                              @RequestParam("page") int page,
                              @RequestParam("searchCondition") String searchCondition,
                              @RequestParam("searchKeyword") String searchKeyword) {
        System.out.println("Qcode: " + qcode);
        System.out.println("Rcontent: " + vo.getRcontent());
        adminQnaService.insertReply(vo);
        return "redirect:/admin/qna/detail/" + qcode 
               + "?page=" + page 
               + "&searchCondition=" + searchCondition 
               + "&searchKeyword=" + searchKeyword;
    }

    @RequestMapping(value = "/deleteReply/{qcode}", method = RequestMethod.POST)
    public String deleteReply(@PathVariable("qcode") int qcode,
                              @RequestParam("page") int page,
                              @RequestParam("searchCondition") String searchCondition,
                              @RequestParam("searchKeyword") String searchKeyword) {
        adminQnaService.deleteReply(qcode);
        return "redirect:/admin/qna/detail/" + qcode 
               + "?page=" + page 
               + "&searchCondition=" + searchCondition 
               + "&searchKeyword=" + searchKeyword;
    }
    @RequestMapping(value = "/delete/{qcode}", method = RequestMethod.POST)
    public String deleteQna(@PathVariable("qcode") int qcode, 
                            @RequestParam("page") int page, 
                            @RequestParam("searchCondition") String searchCondition,
                            @RequestParam("searchKeyword") String searchKeyword) {
        // URL 인코딩 적용
        String encodedKeyword = URLEncoder.encode(searchKeyword, StandardCharsets.UTF_8);
        adminQnaService.deleteQna(qcode);
        return "redirect:/admin/qna?page=" + page 
               + "&searchCondition=" + searchCondition 
               + "&searchKeyword=" + encodedKeyword;
    }
}