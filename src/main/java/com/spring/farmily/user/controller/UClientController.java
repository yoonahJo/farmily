package com.spring.farmily.user.controller;

import java.net.URLEncoder;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.farmily.user.model.SocialVO;
import com.spring.farmily.user.model.UserService;
import com.spring.farmily.user.model.UserVO;

@Controller
@RequestMapping("/")
public class UClientController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
    private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private JavaMailSender mailSender;
	
//	@RequestMapping(value = "/")
//	public String home (HttpServletResponse res) {
//		res.setHeader(HttpHeaders.CACHE_CONTROL, "no-cache, no-store, max-age=0, must-revalidate");
//        res.setHeader(HttpHeaders.PRAGMA, "no-cache"); // HTTP/1.0 호환성 추가
//        res.setDateHeader(HttpHeaders.EXPIRES, 0); // 만료 시간 설정
//		System.out.println("home return");
//		return "index";
//	}
	
	@RequestMapping("/checkId")
	@ResponseBody
	public boolean checkId(@RequestParam String id) {
		UserVO vo = userService.isRegistedUser(id);
		
		if(vo != null) {
			return true;
		}
		return false;
		
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginAction(UserVO vo, Model model, HttpSession session) {
	    UserVO loginUser = userService.userLogin(vo);
	    String reqUrl = (String) session.getAttribute("reqUrl");
	    String reqBody = (String) session.getAttribute("reqBody");

	    if (loginUser != null) {
	        if (bcrypt.matches(vo.getPassword(), loginUser.getPassword())) {
	            session.setAttribute("id", loginUser.getId());
	            session.setAttribute("role", loginUser.getRole());

	            // reqBody가 JSON 형식이라고 가정하고 ptype 및 pcode 값을 추출
	            if (reqBody != null) {
	                try {
	                    ObjectMapper mapper = new ObjectMapper();
	                    JsonNode jsonNode = mapper.readTree(reqBody);
	                    String ptype = jsonNode.path("ptype").asText();
	                    String page = jsonNode.path("page").asText();
	                    String pcode = jsonNode.path("pcode").asText();

	                    // URL에 "one"이 포함되어 있는지 여부 확인
	                    boolean isOneInUrl = reqUrl != null && reqUrl.contains("one");

	                    if (!ptype.isEmpty()) {
	                        if (isOneInUrl) {
	                            // ptype이 있고 URL에 "one"이 포함되어 있을 때
	                            return "redirect:/order/orderResponse";
	                        } else {
	                            // ptype이 있고 URL에 "one"이 포함되어 있지 않을 때
	                            String encodedPtype = URLEncoder.encode(ptype, "UTF-8");
	                            String redirectUrl = String.format("/product/list?page=%s&ptype=%s", page, encodedPtype);
	                            return "redirect:" + redirectUrl;
	                        }
	                    } else if (!pcode.isEmpty()) {
	                        if (isOneInUrl) {
	                            // pcode 값이 있고 URL에 "one"이 포함되어 있을 때
	                            return "redirect:/order/orderResponse";
	                        } else {
	                            // pcode 값이 있고 URL에 "one"이 포함되어 있지 않을 때
	                            String redirectUrl = String.format("/product/detail/%s", pcode);
	                            return "redirect:" + redirectUrl;
	                        }
	                    }
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    model.addAttribute("loginFailed", "로그인 처리 중 오류가 발생했습니다.");
	                    return "user/login";
	                }
	            }

	            // reqUrl이 설정된 경우 해당 URL로 리다이렉트
	            if (reqUrl != null) {
	                return "redirect:" + reqUrl;
	            }

	            // 기본 리다이렉트
	            return "redirect:/";
	        } else {
	            model.addAttribute("loginFailed", "ID 또는 Password가 일치하지 않습니다.");
	            return "user/login";
	        }

	    } else {
	        model.addAttribute("loginFailed", "회원 정보가 존재하지 않습니다.");
	        return "user/login";
	    }
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "user/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinAction(UserVO vo, HttpServletRequest request) {
		
		vo.setPassword(bcrypt.encode(vo.getPassword()));
		String newAddress = (String) request.getParameter("newAddress");
		String detail = (String) request.getParameter("detailAddress");
		String fnewAddress = (String)request.getParameter("fNewAddress");
		String fdetail = (String)request.getParameter("fdetailAddress");
		System.out.println("newAddress : " + newAddress);
		System.out.println("detail : " + detail);
		System.out.println("fnewAddress : " + fnewAddress);
		System.out.println("fdetail : " + fdetail);
		if(request.getParameter("detailAddress").isEmpty() || request.getParameter("detailAddress") == null) {
				vo.setUaddress(newAddress);
		}
		else {
				vo.setUaddress(newAddress + "," + detail);
		}
		
		if(request.getParameter("fzcode").isEmpty() || request.getParameter("fzcode") == null) {
			vo.setFaddress("");
			vo.setFname("");
			vo.setFnum("");
			vo.setFzcode("");
			vo.setRole('C');
			userService.userJoin(vo);
			return "redirect:/login";
		}
		else {
			if(request.getParameter("fdetailAddress").isEmpty() || request.getParameter("fdetailAddress") == null) {
					vo.setFaddress(fnewAddress);
			}
			else {
					vo.setFaddress(fnewAddress + ", " + fdetail);
			}
			vo.setRole('F');
			userService.userJoin(vo);
			return "redirect:/farm/user/login";
		}
		
	}
	
	@RequestMapping(value = "/user/info", method = RequestMethod.GET)
	public String info(Model model, HttpSession session, HttpServletResponse response) {
		String userId = (String) session.getAttribute("id");
		UserVO vo = userService.getUser(userId);
		model.addAttribute("user", vo);
		
		
		return "user/info";
	}
	
	
	@RequestMapping(value = "/user/update", method = RequestMethod.POST)
	public String updateAction(UserVO vo, Model model, HttpServletRequest request, RedirectAttributes rttr) {
		UserVO loginUser = userService.userLogin(vo);
		System.out.println(vo.getPassword());
		System.out.println("loginUser : " + loginUser);
		if(bcrypt.matches(vo.getPassword(), loginUser.getPassword())) {
			String newAddress = (String) request.getParameter("newAddress");
			String detail = (String) request.getParameter("detailAddress");
			if(request.getParameter("detailAddress").isEmpty()) {
					vo.setUaddress(newAddress);
			}
			else {
					vo.setUaddress(newAddress + "," + detail);
					
			}
			vo.setPassword(bcrypt.encode(vo.getPassword()));
			userService.updateUser(vo);
			rttr.addFlashAttribute("updateSuccess", "수정이 완료되었습니다.");
		}
		else {
			rttr.addFlashAttribute("updateSuccess", "비밀번호가 일치하지 않습니다.");
		}
		return "redirect:/user/info";
	}
	
	@RequestMapping(value = "/user/socialupdate", method = RequestMethod.POST)
	public String updateSocial(UserVO vo, Model model, HttpServletRequest request, RedirectAttributes rttr) {
		UserVO loginUser = userService.userLogin(vo);		
		System.out.println("loginUser : " + loginUser);	
		String newAddress = (String) request.getParameter("newAddress");
		String detail = (String) request.getParameter("detailAddress");
		if(request.getParameter("detailAddress").isEmpty()) {
				vo.setUaddress(newAddress);
		}
		else {
				vo.setUaddress(newAddress + "," + detail);
					
		}			
		userService.updateUser(vo);
		rttr.addFlashAttribute("updateSuccess", "수정이 완료되었습니다.");
		
		return "redirect:/user/info";
	}
	
	@RequestMapping(value = "/user/updatePw", method = RequestMethod.POST)
	@ResponseBody
	public boolean updatePwAction(UserVO vo, HttpServletRequest request, HttpSession session) {
		UserVO loginUser = userService.userLogin(vo);
		
		if(bcrypt.matches(vo.getPassword(), loginUser.getPassword())) {
			String newPassword = (String) request.getParameter("newPassword");
			vo.setPassword(bcrypt.encode(newPassword));
			userService.updatePassword(vo);
			session.invalidate();
			return true;
		}
		
		return false;
	}
	
	
	@RequestMapping(value = "/user/drop", method = RequestMethod.POST)
	@ResponseBody
	public boolean deleteAction(UserVO vo, SocialVO social, Model model, HttpSession session, RedirectAttributes rttr) {
		UserVO user = userService.userLogin(vo);
		
		if(user != null && !user.getId().contains("@")) { // 일반 유저 및 일반 가입에서 소셜 연동한 회원
			if(bcrypt.matches(vo.getPassword(), user.getPassword())) {
				social.setSns_name(user.getUname());
				SocialVO kakaoUser = userService.kakaoUserId(social);
				System.out.println("kakaoUser : " + kakaoUser);
				if(kakaoUser != null && kakaoUser.getSns_type().equals("kakao")) {
					userService.kakaoUnlink(kakaoUser.getSns_id());
				}
				userService.dropSocialUser(social);
				System.out.println("vo : " + vo);
				userService.dropUser(vo);
				userService.updateRelatedTables(user.getId());
				session.invalidate();
				return true;
			}
		}
		else if(user != null && user.getId().contains("@")) { // 소셜 회원
			social.setSns_name(user.getUname());
			SocialVO kakaoUser = userService.kakaoUserId(social);
			if(kakaoUser.getSns_type().equals("kakao")) {
				System.out.println(kakaoUser.getSns_id());
				userService.kakaoUnlink(kakaoUser.getSns_id());
			}
			
			userService.dropSocialUser(social);
			userService.dropUser(vo);
			userService.updateRelatedTables(user.getId());
			session.invalidate();
			return true;
		}
		return false;
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String findId() {
		return "user/findId";
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	@ResponseBody
	public String findIdAction(UserVO vo) {
		UserVO user = userService.findId(vo);
		
		if(user!= null) {
			if(user.getId().startsWith("@")) {
				return "social";
			}
			String setfrom = "dydtjrwn1111@naver.com";
			String tomail = vo.getEmail();
			String title = "[farmily] 아이디 찾기 조회 결과"; 
			String content = "<span>가입하신 아이디는 " + "<strong>" + user.getId() + "</strong>" + "입니다.</span>"; 
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");

				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content, true);

				mailSender.send(message);
				return "send";
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		return "noData";
		
	}
	
	
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPw() {
		return "user/findPw";
	}
	
	@RequestMapping(value = "/findPw", method = RequestMethod.POST)
	@ResponseBody
	public String findPwAction(UserVO vo) {
		UserVO user = userService.findPw(vo);		
		if(user!= null) {
			if(user.getId().startsWith("@")) {
				return "social";
			}
			String ramdom_code = RandomStringUtils.random(16, true, true);
			String setfrom = "dydtjrwn1111@naver.com";
			String tomail = vo.getEmail();
			String title = "[farmily] 비밀번호 재설정"; 
			String content = "<br> <p>하단에 첨부된 링크를 통해 비밀번호를 재설정 하세요.</p> <br>" 
			+ "<a href='http://localhost:8080/resetPw/" + ramdom_code 
			+ "'>비밀번호 재설정 링크</a><br>"
			+ "<br> <p>비밀번호 재설정 후 해당 링크는 만료되며 만료 후에는 비밀번호 재설정이 불가합니다. 비밀번호 찾기를 다시 이용하여 새로운 이메일을 받으세요.</p>"; 
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");
				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content, true);
				user.setUsercode(ramdom_code);
				userService.updateUserCode(user);
				mailSender.send(message);
				return "send";
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
			return "noData";		
	}
	
	@RequestMapping(value = "/resetPw/{code}", method = RequestMethod.GET)
	public String resetPw(@PathVariable String code) {
		
		return "user/resetPwForm";
	}
	
	@RequestMapping(value = "/resetPw/{code}", method = RequestMethod.POST)
	@ResponseBody
	public boolean resetPwAction(@PathVariable String code, UserVO vo) {
		vo.setUsercode(code);
		UserVO user = userService.hasUserCode(vo);
		try {
			if(user != null) {
				user.setPassword(bcrypt.encode(vo.getPassword()));
				userService.resetPw(user);
				return true;
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			userService.deleteUserCode(user);
		}
		return false;
	}
	
}