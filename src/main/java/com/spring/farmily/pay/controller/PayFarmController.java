package com.spring.farmily.pay.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.farmily.pay.model.PayVO;
import com.spring.farmily.pay.model.farm.PayFarmService;

@RequestMapping("/farm/pay")
@Controller
public class PayFarmController {

    @Autowired
    private PayFarmService payFarmService;

    @RequestMapping
    public String farmPayList(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "searchCondition", required = false) String searchCondition,
                              @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                              Model model, HttpSession session) {

        // 세션에서 사용자 ID를 가져옴
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/user/login";
        }

        // fnum을 설정하기 위해 사용자 ID로 조회
        String fnum = payFarmService.getFnumByUserId(userId);
        if (fnum == null) {
            // fnum이 없으면 결제 내역을 조회할 수 없음
            model.addAttribute("farmPayList", null);
            return "/farm/pay/farmPayList";
        }

        PayVO vo = new PayVO();
        vo.setFnum(fnum); // fnum 설정
        vo.setSearchCondition(searchCondition);
        vo.setSearchKeyword(searchKeyword);

        // 페이징 처리
        int listCount = payFarmService.getPayListCount(vo);
        int limit = 10;
        int pagingUnit = 5;

        List<PayVO> farmPayList = payFarmService.getFarmPayListByPage(vo, page, limit);

        int maxPage = (int) Math.ceil((double) listCount / limit);
        int startPage = (((int) ((double) page / pagingUnit + 0.9)) - 1) * pagingUnit + 1;
        int endPage = startPage + pagingUnit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        // 주문 상태별 카운트 계산
        int preparingCount = payFarmService.countByDstate(fnum, "배송준비중");
        int shippingCount = payFarmService.countByDstate(fnum, "배송중");
        int completedCount = payFarmService.countByDstate(fnum, "배송완료");

        // 모델에 데이터 설정
        model.addAttribute("farmPayList", farmPayList);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("preparingCount", preparingCount);
        model.addAttribute("shippingCount", shippingCount);
        model.addAttribute("completedCount", completedCount);

        return "/farm/pay/farmPayList";
    }

    @RequestMapping(value = "/updateMultipleDeliveryStates", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> updateMultipleDeliveryStates(@RequestParam("paycodes") String paycodes,
                                                               @RequestParam("newDstate") String newDstate,
                                                               HttpSession session) {
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // paycodes를 콤마로 분리하여 배열로 변환
        String[] paycodeArray = paycodes.split(",");

        // 선택한 결제 코드들에 대해 배송 상태 업데이트
        payFarmService.updateMultipleDeliveryStates(paycodeArray, newDstate);

        return ResponseEntity.ok("선택한 항목의 배송 상태가 업데이트되었습니다.");
    }

    @RequestMapping("/farmPayDetail/{paycode}")
    public String payDetail(@PathVariable("paycode") String paycode,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "searchCondition", required = false) String searchCondition,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            Model model) {
        PayVO payDetail = payFarmService.getPayDetailByPaycode(paycode);

        Calendar cal = Calendar.getInstance();
        cal.setTime(payDetail.getPaydate());
        cal.add(Calendar.DATE, 3);  // 3일 추가
        Date shippingDeadline = cal.getTime();

        model.addAttribute("payDetail", payDetail);
        model.addAttribute("shippingDeadline", shippingDeadline);
        model.addAttribute("page", page);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("searchKeyword", searchKeyword);
        return "/farm/pay/farmPayDetail";
    }

    @RequestMapping("/updateDeliveryState")
    public String updateDeliveryState(@RequestParam("paycode") String paycode,
                                      @RequestParam("newDstate") String newDstate,
                                      @RequestParam(value = "page", defaultValue = "1") int page,
                                      @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                                      HttpSession session) {
        // 세션에서 사용자 ID 확인
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/user/login";
        }

        // 선택한 결제 코드에 대해 배송 상태 업데이트
        payFarmService.updateMultipleDeliveryStates(new String[]{paycode}, newDstate);

        // 처리 후 상세페이지로 리다이렉트, 페이지와 검색값도 전달
        return "redirect:/farm/pay/farmPayDetail/" + paycode 
               + "?page=" + page 
               + "&searchKeyword=" + searchKeyword;
    }
    
    @RequestMapping(value = "/updateDeliveryStateFromList", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> updateDeliveryStateFromList(@RequestParam("paycode") String paycode,
                                                              @RequestParam("newDstate") String newDstate,
                                                              HttpSession session) {
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        // 선택한 결제 코드에 대해 배송 상태 업데이트
        payFarmService.updateMultipleDeliveryStates(new String[]{paycode}, newDstate);

        return ResponseEntity.ok("배송 상태가 업데이트되었습니다.");
    }

}