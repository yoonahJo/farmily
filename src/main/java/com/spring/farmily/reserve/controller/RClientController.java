package com.spring.farmily.reserve.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.spring.farmily.reserve.model.ReserveService;
import com.spring.farmily.reserve.model.ReserveVO;

@Controller
@RequestMapping("/reserve")
public class RClientController {

    @Autowired
    private ReserveService reserveService;
    
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getBoardList(ReserveVO vo, Model model, HttpSession session,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "5") int pageSize) {
        
        String id = (String) session.getAttribute("id");
        vo.setId(id); // 세션에서 가져온 ID를 VO에 설정
        // 페이징을 위한 offset 계산
        int offset = (page - 1) * pageSize;
        
        // totalCount 초기화
        int totalCount = reserveService.getTotalCount(vo); // reserveService를 통해 총 개수 가져오기

        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 페이지 그룹 설정
        int groupSize = 5; // 그룹 사이즈 (예: 5페이지씩)
        int startPage = ((page - 1) / groupSize) * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);

        // 모델에 추가 정보 설정
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("reserveList", reserveService.getMyReserveList(vo, offset, pageSize)); // model 정보 저장
        model.addAttribute("totalCount", totalCount); // totalCount 추가

        return "/reserve/myReserveList"; // view 이름 리턴
    }
    
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> modifyCount(
            @RequestBody Map<String, Object> requestData,
            HttpSession session) {

        String id = (String) session.getAttribute("id");
        Map<String, Object> response = new HashMap<>();

        try {
            // JSON에서 각 필드를 안전하게 추출합니다.
            int rcode = Integer.parseInt(String.valueOf(requestData.get("rcode")));
            int pcount = Integer.parseInt(String.valueOf(requestData.get("pcount")));
            int rprice = Integer.parseInt(String.valueOf(requestData.get("rprice")));

            ReserveVO vo = new ReserveVO();
            vo.setId(id);
            vo.setRcode(rcode);
            vo.setPcount(pcount);
            vo.setRprice(rprice);

            reserveService.modifyCount(vo);

            response.put("status", "success");
            return ResponseEntity.ok(response);
        } catch (NumberFormatException e) {
            response.put("status", "error");
            response.put("message", "잘못된 데이터 형식입니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteReserve(
            @RequestBody Map<String, Object> requestData,
            HttpSession session) {
        String id = (String) session.getAttribute("id");  // 세션에서 ID 가져오기
        Map<String, Object> response = new HashMap<>();  // 응답 객체 생성

        try {
            // 클라이언트로부터 받은 rcode를 안전하게 가져옵니다.
            int rcode = Integer.parseInt(String.valueOf(requestData.get("rcode")));

            // ReserveVO 객체 생성 및 데이터 설정
            ReserveVO vo = new ReserveVO();
            vo.setId(id);
            vo.setRcode(rcode);

            // reserveService를 통해 삭제 작업 수행
            reserveService.deleteReserve(vo);

            response.put("status", "success");
            return ResponseEntity.ok(response);  // 성공 응답 반환
        } catch (NumberFormatException e) {
            response.put("status", "error");
            response.put("message", "잘못된 데이터 형식입니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);  // 형식 오류 응답
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);  // 서버 오류 응답
        }
    }
    
    @RequestMapping(value = "/deleteAll", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteAll(@RequestBody Map<String, Object> payload, HttpSession session) {
        String id = (String) session.getAttribute("id");
        
        // 세션에서 가져온 ID를 VO에 설정
        ReserveVO vo = new ReserveVO();
        vo.setId(id);
        
        // payload에서 rcodes를 추출
        @SuppressWarnings("unchecked")
        List<Integer> rcodes = (List<Integer>) payload.get("rcodes");
        
        // 응답용 Map
        Map<String, Object> response = new HashMap<>();
        response.put("deletedCount", 0);

        // 각 RCODE에 대해 삭제 수행
        for (Integer rcode : rcodes) {
            vo.setRcode(rcode);
            reserveService.deleteReserve(vo);
            response.put("deletedCount", ((int) response.get("deletedCount")) + 1);
        }
        
        // 삭제된 항목의 수를 응답에 포함
        response.put("message", "Successfully deleted items.");
        
        return response; // JSON 형태로 응답
    }
    
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public boolean insertReserve(@RequestBody ReserveVO vo, HttpSession session) {
        String userId = (String) session.getAttribute("id");
        
        // 세션에서 가져온 ID를 VO에 설정
        vo.setId(userId);
        
        // 먼저 해당 상품이 이미 장바구니에 있는지 확인
        boolean exists = reserveService.isProductInCart(vo);
        if (!exists) {
            // 장바구니에 상품이 없으면 추가
            reserveService.insertReserve(vo);
        }
        else {
        	reserveService.updateCountReserve(vo);
        }
        session.removeAttribute("reqUrl");
        session.removeAttribute("reqBody");
        return exists; // JSON 형태로 응답
    }

    
    @RequestMapping(value = "/oneInsert", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> insertOneReserve(
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        // 세션에서 사용자 ID를 가져옵니다.
        String userId = (String) session.getAttribute("id");

        // 요청에서 pcode와 pcount 값을 가져옵니다.
        String pcode = (String) payload.get("pcode");
        int pcount = Integer.parseInt(payload.get("pcount").toString()); // 문자열을 정수로 변환합니다.

        // ReserveVO 객체를 생성하고 값을 설정합니다.
        ReserveVO vo = new ReserveVO();
        vo.setId(userId);
        vo.setPcode(pcode);
        vo.setPcount(pcount);

        // 해당 상품이 장바구니에 이미 있는지 확인합니다.
        boolean exists = reserveService.isProductInCart(vo);
        if (!exists) {
            // 장바구니에 없으면 상품을 추가합니다.
            reserveService.insertReserve(vo);
        }

        // 상품의 rcode를 가져옵니다.
        int rcode = reserveService.getRcode(vo);

        // 응답을 위한 Map을 생성하고 데이터를 추가합니다.
        Map<String, Object> response = new HashMap<>();
        List<Map<String, Object>> orders = new ArrayList<>();

        // 첫 번째 인덱스에 해당하는 주문 정보를 생성
        Map<String, Object> orderDetails = new HashMap<>();
        orderDetails.put("pcode", pcode);
        orderDetails.put("pcount", pcount);
        orderDetails.put("rcode", rcode);

        // orders 리스트에 주문 정보를 추가
        orders.add(orderDetails);

        // 응답 데이터에 추가
        response.put("orders", orders);
        response.put("redirect", "/order/myOrderList"); // 리다이렉트할 기본 URL을 설정합니다.
        
        session.removeAttribute("reqUrl");
        session.removeAttribute("reqBody");
        // 응답을 JSON 형태로 반환합니다.
        return ResponseEntity.ok(response);
    }
}