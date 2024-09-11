package com.spring.farmily.order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.farmily.order.model.OrderPageVO;
import com.spring.farmily.order.model.OrderProductVO;
import com.spring.farmily.order.model.OrderService;
import com.spring.farmily.user.model.UserService;

@Controller
@RequestMapping("order")
public class OClientController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/myOrderList", method = RequestMethod.GET)
    public String getOrderPage(
            @RequestParam(value = "pcode", required = false) String pcode,
            @RequestParam(value = "pcount", required = false) Integer pcount,
            @RequestParam(value = "rcode", required = false) Integer rcode,
            @RequestParam(value = "orders", required = false) OrderPageVO vo2,
            @ModelAttribute OrderPageVO vo1, 
            HttpSession session, Model model) {
    	// pcode, pcount, rcode가 모두 null인 경우
        if (pcode == null && pcount == null && rcode == null && (vo1 == null || vo1.getOrders() == null || vo1.getOrders().isEmpty())) {
            return "/order/errorPage"; // 오류 페이지로 리디렉션
        }
    	System.out.println("진짜 pcode: " + pcode);
    	System.out.println("진짜 pcount: " + pcount);
    	System.out.println("진짜 rcode: " + rcode);
    	System.out.println("진짜 VO: " + vo1);    
    	
        String id = (String) session.getAttribute("id");
        // OrderPageVO의 orders 리스트가 null인지 확인하고 초기화합니다.
        if (vo1.getOrders() == null) {
            vo1.setOrders(new ArrayList<>()); // 리스트가 null이면 초기화합니다.
        }

        // OrderPageVO에 pcode와 pcount 값을 설정합니다.
        if (pcode != null && pcount != null && rcode != null) {
            OrderProductVO order = new OrderProductVO(); // OrderProductVO 객체는 OrderPageVO의 구성 요소입니다.
            order.setPcode(pcode);
            order.setPcount(pcount);
            order.setRcode(rcode);
            vo1.getOrders().add(order); // vo1의 orders 리스트에 추가
        }
        
        
        // null 체크 및 예외 처리
        if (vo1.getOrders() != null && !vo1.getOrders().isEmpty()) {
            List<OrderProductVO> orderList = orderService.getOrderInfo(vo1.getOrders());
            List<OrderProductVO> rcodeList = orderService.getRcodeInfo(vo1.getOrders());
            
            // null 체크 후 model에 추가
            if (orderList != null) {
                model.addAttribute("orderList", orderList);
            } else {
                model.addAttribute("orderList", null);
                model.addAttribute("errorMessage", "주문 정보를 불러오는 중 오류가 발생했습니다.");
            }
            
            if (rcodeList != null) {
                model.addAttribute("rcodeList", rcodeList);
            } else {
                model.addAttribute("rcodeList", null);
                model.addAttribute("errorMessage", "rcode 정보를 불러오는 중 오류가 발생했습니다.");
            }
        } else {
            model.addAttribute("orderList", null);
            model.addAttribute("rcodeList", null);
            model.addAttribute("errorMessage", "주문 정보가 없습니다.");
        }
        
        // 사용자 정보 추가
        if (id != null) {
            Object user = userService.getUser(id);
            if (user != null) {
                model.addAttribute("user", user);
            } else {
                model.addAttribute("user", null);
                model.addAttribute("errorMessage", "사용자 정보를 불러오는 중 오류가 발생했습니다.");
            }
        } else {
            model.addAttribute("user", null);
            model.addAttribute("errorMessage", "로그인 정보가 유효하지 않습니다.");
        }
        return "/order/orderPage";
    }
    
    @RequestMapping(value = "/orderResponse", method = RequestMethod.GET)
	public String orderResponse() {
		return "order/orderPageResponse";
	}
}