
package com.spring.farmily.reserve.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.reserve.model.ReserveVO;
import com.spring.farmily.reserve.model.admin.PageInfo;
import com.spring.farmily.reserve.model.admin.ReserveService;
import com.spring.farmily.user.model.UserVO;

@Controller
@RequestMapping("/admin/reserve")
public class RAdminController {

	@Autowired
	private ReserveService adminReserveService;
	

	@RequestMapping
	public String getAdminReserveList(@RequestParam(required = false, name = "sc") String listSearchCondition,
			@RequestParam(required = false, name = "word") String listSearchKeyword,
			@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int limit, Model model,
			HttpSession session) {


		int offset = (page - 1) * limit;
		ReserveVO vo = new ReserveVO();
		vo.setListSearchCondition(listSearchCondition);
		vo.setListSearchKeyword(listSearchKeyword);
		vo.setLimit(limit);
		vo.setOffset(offset);

		List<ReserveVO> reserveList = adminReserveService.getAdminReserveList(vo);
		PageInfo pageInfo = adminReserveService.getPageInfo(vo, page, limit);

		model.addAttribute("page", page);
		model.addAttribute("listSearchCondition", listSearchCondition);
		model.addAttribute("listSearchKeyword", listSearchKeyword);
		model.addAttribute("reserveList", reserveList);
		model.addAttribute("pageInfo", pageInfo);
		return "/admin/reserve/list";
	}

	/* 장바구니 수량 수정 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String modifyCountAll(ReserveVO vo, @RequestParam int page,
			@RequestParam(required = false, name = "sc") String listSearchCondition,
			@RequestParam(required = false, name = "word") String listSearchKeyword) {
		adminReserveService.adminModifyCount(vo);

		String url = "/admin/reserve?page=" + page;

		if (listSearchCondition != null && !listSearchCondition.isEmpty()) {
			url += "&sc=" + listSearchCondition;
		}

		if (listSearchKeyword != null && !listSearchKeyword.isEmpty()) {
			String encodedSearchKeyword = URLEncoder.encode(listSearchKeyword, StandardCharsets.UTF_8);
			url += "&word=" + encodedSearchKeyword;
		}

		System.out.println("Redirect URL: " + url);
		return "redirect:" + url;
	}

	@RequestMapping(value = "/detailUpdate", method = RequestMethod.POST)
	public String modifyCountDetail(ReserveVO vo, @RequestParam int rcode, @RequestParam int page,
			@RequestParam(required = false, name = "sc") String listSearchCondition,
			@RequestParam(required = false, name = "word") String listSearchKeyword) {
		adminReserveService.adminModifyCount(vo);

		String url = "/admin/reserve/detail/" + rcode + "?page=" + page;

		if (listSearchCondition != null && !listSearchCondition.isEmpty()) {
			url += "&sc=" + listSearchCondition;
		}

		if (listSearchKeyword != null && !listSearchKeyword.isEmpty()) {
			String encodedSearchKeyword = URLEncoder.encode(listSearchKeyword, StandardCharsets.UTF_8);
			url += "&word=" + encodedSearchKeyword;
		}

		System.out.println("Redirect URL: " + url);
		return "redirect:" + url;
	}
	
	@RequestMapping("/detail/{rcode}")
	public String getAdminReserveDetail(@PathVariable int rcode, @RequestParam(defaultValue = "1") int page,
			@RequestParam(required = false, name = "sc") String listSearchCondition,
			@RequestParam(required = false, name = "word") String listSearchKeyword, Model model, HttpSession session) {

		model.addAttribute("page", page);
		model.addAttribute("listSearchCondition", listSearchCondition);
		model.addAttribute("listSearchKeyword", listSearchKeyword);
		model.addAttribute("reserveDetail", adminReserveService.getAdminReserveDetail(rcode));

		return "/admin/reserve/detail";
	}

	@RequestMapping(value = "/delete/{rcode}", method = RequestMethod.GET)
	public String getAdminReserveDelete(@PathVariable("rcode") int rcode, @RequestParam(defaultValue = "1") int page,
			@RequestParam(required = false, name = "sc") String listSearchCondition,
			@RequestParam(required = false, name = "word") String listSearchKeyword) {

		adminReserveService.getAdminReserveDelete(rcode);

		String url = "/admin/reserve?page=" + page;

		if (listSearchCondition != null && !listSearchCondition.isEmpty()) {
			url += "&sc=" + listSearchCondition;
		}

		if (listSearchKeyword != null && !listSearchKeyword.isEmpty()) {
			String encodedSearchKeyword = URLEncoder.encode(listSearchKeyword, StandardCharsets.UTF_8);
			url += "&word=" + encodedSearchKeyword;
		}

		System.out.println("Redirect URL: " + url);
		return "redirect:" + url;
	}

	@RequestMapping(value = "/selectDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAll(@RequestBody Map<String, Object> payload) {

		// payload에서 rcodes를 추출
		@SuppressWarnings("unchecked")
		List<Integer> rcodes = (List<Integer>) payload.get("rcodes");

		// 응답용 Map
		Map<String, Object> response = new HashMap<>();
		response.put("deletedCount", 0);

		// 각 RCODE에 대해 삭제 수행
		for (Integer rcode : rcodes) {
			adminReserveService.getAdminReserveDelete(rcode);
			response.put("deletedCount", ((int) response.get("deletedCount")) + 1);
		}

		// 삭제된 항목의 수를 응답에 포함
		response.put("message", "Successfully deleted items.");

		return response; // JSON 형태로 응답
	}

	@RequestMapping("/insert")
	public String reserveInsert(ReserveVO vo, HttpSession session) {
		adminReserveService.reserveInsert(vo);
		return "redirect:/admin/reserve";
	}

	@RequestMapping(value = "/reserveForm", method = RequestMethod.GET)
	public String reserveForm(HttpSession session) {

		return "/admin/reserve/reserveForm";
	}

	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productList(ProductVO vo, Model model) {
		List<ProductVO> productList = adminReserveService.getProductList(vo);
		model.addAttribute("productSearch", vo.getSearchCondition());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("productList", productList);
		return "/admin/reserve/modalProList";
	}

	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(UserVO vo, Model model) {
		model.addAttribute("userSearchCondition", vo.getUserSearchCondition());
		model.addAttribute("userSearchKeyword", vo.getUserSearchKeyword());
		model.addAttribute("userList", adminReserveService.getUserList(vo));
		return "/admin/reserve/modalUserList";
	}
}