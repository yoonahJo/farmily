package com.spring.farmily.pay.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.farmily.pay.model.PayVO;
import com.spring.farmily.pay.model.admin.APayService;

@Controller
@RequestMapping("/admin/pay")
public class APayController {

    @Autowired
    private APayService apayService;
    
    @RequestMapping(value="/APayList", method=RequestMethod.GET)
    public String ApayList() {
        return "/admin/pay/APayList"; 
    } 
   
    @RequestMapping
    public String listPayments(
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            Model model,
            HttpSession session) {
    	
    	session.getAttribute("id");

        int offset = (page - 1) * pageSize;

        List<PayVO> payList;
        int totalPayments;

        if (searchField != null && !searchField.trim().isEmpty()) {
            payList = apayService.getPayList(searchType, searchField, pageSize, offset);
            totalPayments = apayService.getTotalCount(searchType, searchField);
            model.addAttribute("pageTitle", "'" + searchField + "'의 결제 목록");
        } else {
            payList = apayService.getPayList(searchType, searchField, pageSize, offset);
            totalPayments = apayService.getTotalCount(null, null);
            model.addAttribute("pageTitle", "전체 결제 목록");
        }

        int totalPages = (int) Math.ceil((double) totalPayments / pageSize);
        int groupSize = 5;
        int startPage = ((page - 1) / groupSize) * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);

        model.addAttribute("payList", payList);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchField", searchField);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "/admin/pay/APayList";
    }
    @RequestMapping(value = "/payUpdate/{paycode}", method = RequestMethod.POST)
    public String updatePay(@PathVariable("paycode") int paycode, Model model) {
        PayVO vo = new PayVO();
        vo.setPaycode(paycode);
        vo.setPaydelcheck("1");
        vo.setRstate("결제취소");

        apayService.updatePay(vo);

        PayVO payDetail = apayService.getPayDetail(String.valueOf(paycode));
        List<PayVO> payList = apayService.getPayList("", "");

        model.addAttribute("payList", payList);
        model.addAttribute("payDetail", payDetail);

        return "/admin/pay/APayDetail";
    }

    @RequestMapping(value = "/payDetail/{paycode}", method = RequestMethod.GET)
    public String getPayDetail(@PathVariable("paycode") String paycode, Model model) {
        PayVO payDetail = apayService.getPayDetail(paycode);
        model.addAttribute("payDetail", payDetail);
        return "/admin/pay/APayDetail"; // JSP 파일 경로
    }
}
