package com.spring.farmily.pay.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.spring.farmily.pay.model.PageInfo;
import com.spring.farmily.pay.model.PayService;
import com.spring.farmily.pay.model.PayVO;
import com.spring.farmily.product.model.ProductService;
import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.reserve.model.ReserveService;
import com.spring.farmily.reserve.model.ReserveVO;

@Controller
@RequestMapping("pay")
public class PayClientController {
	
	private IamportClient iamportClient;

	@PostConstruct
	public void init() {
		this.iamportClient = new IamportClient("7374485431405842",
				"5KbxLfgZGhzWuyZ8tzWlMKjWHQyFYj4bP91QCLhowtGbiNqSnGQpi16kwJNulXXhkPIQH1unmdryHlkt");
	}

	@Autowired
	private PayService payService;
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private ProductService productService;

	// 사전 검증
	@ResponseBody
	@RequestMapping(value = "/verifyIamport/{imp_uid}", method = RequestMethod.GET)
	public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String impUid)
			throws IamportResponseException, IOException {
		return iamportClient.paymentByImpUid(impUid);
	}

	private IamportResponse<Payment> verifyPayment(String impUid) throws IamportResponseException, IOException {
		// api는 paymentByImpUid 메서드를 가진 클래스의 인스턴스라고 가정합니다
		return iamportClient.paymentByImpUid(impUid);
	}

	// 사후 검증
	@RequestMapping(value = "/verifyPayment/{imp_uid}", method = RequestMethod.GET)
	@ResponseBody
	public IamportResponse<Payment> verifyPaymentPost(@PathVariable("imp_uid") String impUid)
			throws IamportResponseException, IOException {
		// 사후 검증을 위한 API 호출
		return iamportClient.paymentByImpUid(impUid);
	}

	// 결제
	@RequestMapping(value = "/complete/{imp_uid}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertPay(@RequestBody Map<String, Object> requestData, HttpSession session,
			@PathVariable("imp_uid") String impUid) {
		Map<String, Object> response = new HashMap<>();
		String id = (String) session.getAttribute("id");

		if (id != null) {
			try {

				// 결제 검증 수행
				IamportResponse<Payment> paymentResponse = verifyPayment(impUid);
				if (paymentResponse == null || !paymentResponse.getResponse().getStatus().equals("paid")) {
					response.put("success", false);
					response.put("message", "결제 검증에 실패했습니다.");
					return response;
				}

				// 실제 결제된 금액
				BigDecimal paidAmount = paymentResponse.getResponse().getAmount();

				// 요청 데이터에서 금액 추출
				BigDecimal requestAmount = new BigDecimal(requestData.get("amount").toString());
				
				// 금액 비교
				if (!paidAmount.equals(requestAmount)) {
					response.put("success", false);
					response.put("message", "결제 금액이 요청 금액과 일치하지 않습니다.");
					return response;
				}

				// 사후 검증 수행
				IamportResponse<Payment> postVerificationResponse = verifyPaymentPost(impUid);
				if (postVerificationResponse == null
						|| !postVerificationResponse.getResponse().getStatus().equals("paid")) {
					response.put("success", false);
					response.put("message", "사후 검증에 실패했습니다.");
					return response;
				}

				// 필드 데이터 가져오기
				String merchantUid = (String) requestData.get("merchant_uid");
				String nameField = (String) requestData.get("name");
				int amount = (int) requestData.get("amount");
				String buyerName = (String) requestData.get("buyer_name");
				String buyerTel = (String) requestData.get("buyer_tel");
				String buyerEmail = (String) requestData.get("buyer_email");
				String buyerAddr = (String) requestData.get("buyer_addr");
				String buyerPostcode = (String) requestData.get("buyer_postcode");
				String codeField = (String) requestData.get("code");
				String quantityField = (String) requestData.get("quantity");
				String payMethod = (String) requestData.get("pay_method");
				String unitPriceField = (String) requestData.get("unitPrice");

				// SOFT DELETE 관련 처리
				String rcodeField = requestData.containsKey("rcode") ? (String) requestData.get("rcode") : null;
				String rdelcheck = (String) requestData.get("RDELCHECK");

				ObjectMapper objectMapper = new ObjectMapper();
				List<String> codes = objectMapper.readValue(codeField, new TypeReference<List<String>>() {
				});
				List<Integer> quantities = objectMapper.readValue(quantityField, new TypeReference<List<Integer>>() {
				});
				List<Integer> unitPrices = objectMapper.readValue(unitPriceField, new TypeReference<List<Integer>>() {
				});
				List<Integer> rcodes = rcodeField != null
						? objectMapper.readValue(rcodeField, new TypeReference<List<Integer>>() {
						})
						: null;

				String[] names = nameField.split("--");
				
				// 최소 길이 체크
				int size = Math.min(codes.size(), Math.min(quantities.size(), unitPrices.size()));
				size = Math.min(size, names.length);
				if (rcodes != null) {
					size = Math.min(size, rcodes.size());
				}

				for (int i = 0; i < size; i++) {
					PayVO vo = new PayVO();
					vo.setId(id);
					vo.setImp_uid(impUid);
					vo.setMerchant_uid(merchantUid);
					vo.setName(names[i]);
					vo.setAmount(amount);
					vo.setCode(codes.get(i));
					vo.setQuantity(quantities.get(i));
					vo.setBuyer_name(buyerName);
					vo.setBuyer_tel(buyerTel);
					vo.setBuyer_email(buyerEmail);
					vo.setBuyer_addr(buyerAddr);
					vo.setBuyer_postcode(buyerPostcode);
					vo.setPaydate(new java.sql.Date(System.currentTimeMillis()));
					vo.setPay_method(payMethod);
					vo.setUnitPrice(unitPrices.get(i));

					if (rcodes != null && i < rcodes.size()) {
						vo.setRcode(rcodes.get(i));
					}

					// SOFT DELETE 관련 체크
					if (rdelcheck == null || "0".equals(rdelcheck)) {
						boolean success = payService.insertPay(vo);

						if (!success) {
							response.put("success", false);
							response.put("message", "결제 처리 중 오류가 발생했습니다12.");
							return response;
						}
					} else {
						response.put("success", false);
						response.put("message", "SOFT DELETE된 레코드는 처리할 수 없습니다.");
						return response;
					}
				}

				session.setAttribute("lastMerchantUid", merchantUid);

				// Payment 검증 통과 후, 실제 결제 금액을 확인
				BigDecimal responseAmount = paymentResponse.getResponse().getAmount();

				response.put("success", true);
				response.put("message", "결제가 완료되었습니다.");
				response.put("amount", responseAmount);
			} catch (Exception e) {
				response.put("success", false);
				response.put("message", "결제 처리 중 오류가 발생했습니다34.");
				e.printStackTrace();
			}
		} else {
			response.put("success", false);
			response.put("message", "세션 정보가 유효하지 않습니다.");
		}

		return response;
	}

	@RequestMapping(value = "/myPayList", method = RequestMethod.GET)
	public String getPayListAll(PayVO vo, Model model, HttpSession session,
			@RequestParam(required = false, name = "word") String paySearchKeyword,
			@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int limit) {
		String id = (String) session.getAttribute("id");

		vo.setId(id);

		int offset = (page - 1) * limit;
		vo.setLimit(limit);
		vo.setOffset(offset);
		vo.setPaySearchKeyword(paySearchKeyword);
		PageInfo pageInfo = payService.getPageInfo(vo, page, limit);

		Map<String, Boolean> orderStates = payService.getOrderStates(vo);

		model.addAttribute("myRecentList", payService.getMyPayListByMerchantUid(vo));
		model.addAttribute("page", page);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("paySearchKeyword", paySearchKeyword);
		model.addAttribute("payList", payService.getMyPayList(vo));
		model.addAttribute("orderStates", orderStates);

		return "/pay/myPayList";
	}
	
	@RequestMapping(value = "/delete/{merchant_uid}", method = RequestMethod.GET)
	public String getPayDelete(PayVO vo, HttpSession session, @PathVariable("merchant_uid") String merchant_uid,
			@RequestParam(defaultValue = "1") int page, @RequestParam(required = false, name = "word") String paySearchKeyword,
			@RequestParam(defaultValue = "5") int limit) {
		String id = (String) session.getAttribute("id");
		vo.setId(id);
		
		payService.getPayDelete(merchant_uid);

		int itemCount = payService.getPageItemCount(page, limit, paySearchKeyword);
		if(itemCount == 0) {
			PageInfo pageInfo = payService.getPageInfo(vo, page, limit);
	        int newPage = (page >= pageInfo.getMaxPage()) ? pageInfo.getMaxPage() : 1;
	        
	        newPage = Math.max(newPage, 1);
	        
	        String url = "/pay/myPayList?page=" + newPage;

			if (paySearchKeyword != null && !paySearchKeyword.isEmpty()) {
				String encodedSearchKeyword = URLEncoder.encode(paySearchKeyword, StandardCharsets.UTF_8);
				url += "&word=" + encodedSearchKeyword;
			}
			return "redirect:" + url;
		}

		String url = "/pay/myPayList?page=" + page;

		if (paySearchKeyword != null && !paySearchKeyword.isEmpty()) {
			String encodedSearchKeyword = URLEncoder.encode(paySearchKeyword, StandardCharsets.UTF_8);
			url += "&word=" + encodedSearchKeyword;
		}
		return "redirect:" + url;
	}	
	
	@RequestMapping(value = "/myRecentList", method = RequestMethod.GET)
    public String getMyRecentList(PayVO vo, Model model, HttpSession session) {
        String id = (String) session.getAttribute("id");
        String lastMerchantUid = (String) session.getAttribute("lastMerchantUid");
        
        vo.setId(id);
        vo.setMerchant_uid(lastMerchantUid);

        // SOFT DELETE 관련 처리
        model.addAttribute("myRecentList", payService.getMyPayListByMerchantUid(vo)); 
        
        return "/pay/payComplete";
    }
	
	@RequestMapping(value = "/payDetail/{merchant_uid}", method = RequestMethod.GET)
	public String getBoardList(@PathVariable("merchant_uid") String merchantUid, PayVO vo, Model model, HttpSession session, 		
			@RequestParam(required = false, name = "word") String paySearchKeyword,
	         @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int limit) {
	    String id = (String) session.getAttribute("id");
	    vo.setId(id);

         // 결제 목록 조회
         List<PayVO> payListDetail = payService.getMyPayListDetail(vo);
         
         
         int offset = (page - 1) * limit;
         vo.setLimit(limit);
         vo.setOffset(offset);
         vo.setPaySearchKeyword(paySearchKeyword);

         model.addAttribute("page", page);
         model.addAttribute("paySearchKeyword", paySearchKeyword);
         
         // 결제 목록에 포함된 상품 정보를 조회하기 위해 상품 코드 수집
         Set<String> productCodes = payListDetail.stream()
                                            .map(PayVO::getCode)  // 상품 코드를 가져오는 메서드 사용
                                            .collect(Collectors.toSet());

         // 상품 정보 조회
         Map<String, ProductVO> productMap = new HashMap<>();
         for (String code : productCodes) {
             ProductVO product = productService.getProductByCodeDetail(code);
             if (product != null) {
                 productMap.put(code, product);
             }
         }
         // 주문번호로 결제 정보를 그룹화
         Map<String, List<PayVO>> groupedPayList = payListDetail.stream()
                 .collect(Collectors.groupingBy(PayVO::getMerchant_uid));
      // 총 결제 상품 수 계산
         int totalItemCount = payListDetail.stream()
                                     .mapToInt(PayVO::getQuantity)
                                     .sum();
         // 모델에 데이터 추가
         model.addAttribute("groupedPayList", groupedPayList);
         model.addAttribute("productMap", productMap);
         model.addAttribute("totalItemCount", totalItemCount); // 총 결제 상품 수 추가
         model.addAttribute("payListDetail", payListDetail);
         return "/pay/payDetail";
    }
	
	
	@RequestMapping(value = "/afterPayDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> afterPayDelete(@RequestBody Map<String, Object> requestData, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		String id = (String) session.getAttribute("id");

		if (id != null) {
			try {

				// SOFT DELETE 관련 처리
				String rcodeField = (String) requestData.get("rcode"); // JSON 문자열로 받기

				ObjectMapper objectMapper = new ObjectMapper();
				List<Integer> rcodes = rcodeField != null
						? objectMapper.readValue(rcodeField, new TypeReference<List<Integer>>() {
						})
						: null;

				if (rcodes == null) {
					response.put("success", false);
					response.put("message", "삭제할 코드가 제공되지 않았습니다.");
					return response;
				}

				// 삭제 수행
				int deletedCount = 0;
				ReserveVO vo = new ReserveVO();
				vo.setId(id);

				for (Integer rcode : rcodes) {
					vo.setRcode(rcode);
					reserveService.deleteReserve(vo);
					deletedCount++;
				}

				response.put("success", true);
				response.put("deletedCount", deletedCount);
				response.put("message", "삭제가 완료되었습니다.");

			} catch (Exception e) {
				response.put("success", false);
				response.put("message", "삭제 처리 중 오류가 발생했습니다.");
				e.printStackTrace();
			}
		} else {
			response.put("success", false);
			response.put("message", "세션 정보가 유효하지 않습니다.");
		}

		return response;
	}

	@RequestMapping(value = "/rstateupdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> rstateUpdate(@RequestBody Map<String, Object> requestData, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		String id = (String) session.getAttribute("id");

		if (id != null) {
			try {

				// SOFT DELETE 관련 처리
				String rcodeField = (String) requestData.get("rcode"); // JSON 문자열로 받기

				ObjectMapper objectMapper = new ObjectMapper();
				List<Integer> rcodes = rcodeField != null
						? objectMapper.readValue(rcodeField, new TypeReference<List<Integer>>() {
						})
						: null;

				if (rcodes == null) {
					response.put("success", false);
					response.put("message", "수정할 코드가 제공되지 않았습니다.");
					return response;
				}

				// 수정 수행
				int updateCount = 0;
				ReserveVO vo = new ReserveVO();
				vo.setId(id);

				for (Integer rcode : rcodes) {
					vo.setRcode(rcode);
					reserveService.rstateUpdateReserve(vo);
					updateCount++;
				}

				response.put("success", true);
				response.put("updateCount", updateCount);
				response.put("message", "수정이 완료되었습니다.");

			} catch (Exception e) {
				response.put("success", false);
				response.put("message", "수정 처리 중 오류가 발생했습니다.");
				e.printStackTrace();
			}
		} else {
			response.put("success", false);
			response.put("message", "세션 정보가 유효하지 않습니다.");
		}

		return response;
	}
	
	@RequestMapping(value = "/updateDeliveryState", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateDeliveryState(@RequestParam("paycode") int paycode, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    String id = (String) session.getAttribute("id");

	    if (id != null) {
	        try {
	            // 배송 상태를 '배송완료'로 업데이트
	            payService.updateDeliveryState(paycode);

	            response.put("success", true);
	            response.put("message", "구매 확정이 완료되었습니다.");
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "구매 확정 처리 중 오류가 발생했습니다.");
	            e.printStackTrace();
	        }
	    } else {
	        response.put("success", false);
	        response.put("message", "세션이 만료되었습니다. 다시 로그인해주세요.");
	    }

	    return response;
	}
}