package com.spring.farmily.user.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.farmily.user.model.SocialVO;
import com.spring.farmily.user.model.UserService;
import com.spring.farmily.user.model.UserVO;

@Controller
public class SocialController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/oauth/login", method=RequestMethod.GET)
    public String callBack() {
        return "user/callback";
    }
	
	@RequestMapping(value = "/naver/login", method = RequestMethod.POST)
    @ResponseBody
    public String naverLogin(SocialVO vo, HttpSession session) {
    	String reqUrl = (String) session.getAttribute("reqUrl");
    	String reqBody = (String)session.getAttribute("reqBody");
		String birth = vo.getBirthyear() + vo.getBirthday().split("-")[0] + vo.getBirthday().split("-")[1];
		vo.setBirth(birth);
    	
		UserVO user_info = userService.userInfoCheckForSocial(vo);
		
    	String status = "no";
    	
    	if(user_info == null) {
    		userService.naverUserForJoin(vo);
    		user_info = userService.userInfoCheckForSocial(vo);
    		vo.setId(user_info.getId());
    		vo.setSns_type("naver");
    		userService.insertSocialInfo(vo);
    		SocialVO social_info = userService.SocialLogin(vo);
    		
    		session.setAttribute("id", social_info.getId());
	        session.setAttribute("snsName", social_info.getSns_name());
	        session.setAttribute("role", social_info.getRole());
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
	                		String redirectUrl = "/order/orderResponse";
	                        session.setAttribute("redirect", redirectUrl);
	                        return "redirect";
                        } else {
	                    // ptype 값을 URL 인코딩
	                	String encodedPtype = URLEncoder.encode(ptype, "UTF-8");
	                    // 페이지 정보와 함께 리다이렉트 URL 생성
	                    String redirectUrl = String.format("/product/list?page=%s&ptype=%s", page, encodedPtype);
	                    session.setAttribute("redirect", redirectUrl);
	                    return "redirect";
	                }
	                }else if (!pcode.isEmpty()) {
	                	if (isOneInUrl) {
	                		String redirectUrl = "/order/orderResponse";
	                        session.setAttribute("redirect", redirectUrl);
	                        return "redirect";
                        }
	                    // pcode 값이 있을 경우, 해당 상품 상세 페이지로 리다이렉트
	                    String redirectUrl = String.format("/product/detail/%s", pcode);
	                    session.setAttribute("redirect", redirectUrl);
	                    return "redirect";
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	                return "no";
	            } 
	        }else if(reqUrl!=null) {	
	    		return "res";
	    	}
	        status = "ok";
    	}
    	else {
    		SocialVO social_user = userService.naverSocialConnCheck(user_info.getId());
    		
    		if(social_user == null) {
    			vo.setId(user_info.getId());
    			session.setAttribute("user", vo);
    			status = "conn";
    		}
    		else {
    			SocialVO naverData = userService.SocialLogin(vo);
    			
    			session.setAttribute("id", naverData.getId());
    			session.setAttribute("snsName", naverData.getSns_name());
    			session.setAttribute("role", naverData.getRole());
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
    	                		String redirectUrl = "/order/orderResponse";
    	                        session.setAttribute("redirect", redirectUrl);
    	                        return "redirect";
                            } else {
    	                    // ptype 값을 URL 인코딩
    	                	String encodedPtype = URLEncoder.encode(ptype, "UTF-8");
    	                    // 페이지 정보와 함께 리다이렉트 URL 생성
    	                    String redirectUrl = String.format("/product/list?page=%s&ptype=%s", page, encodedPtype);
    	                    session.setAttribute("redirect", redirectUrl);
    	                    return "redirect";
    	                }
    	                }else if (!pcode.isEmpty()) {
    	                	if (isOneInUrl) {
    	                		String redirectUrl = "/order/orderResponse";
    	                        session.setAttribute("redirect", redirectUrl);
    	                        return "redirect";
                            }
    	                    // pcode 값이 있을 경우, 해당 상품 상세 페이지로 리다이렉트
    	                    String redirectUrl = String.format("/product/detail/%s", pcode);
    	                    session.setAttribute("redirect", redirectUrl);
    	                    return "redirect";
    	                }
    	            } catch (Exception e) {
    	                e.printStackTrace();
    	                return "no";
    	            } 
    	        }else if(reqUrl!=null) {	
    	    		return "res";
    	    	}
    			status = "ok";
    		}
    	}
        
        return status; 
    }
	
    @RequestMapping(value = "/connection", method = RequestMethod.GET)
    public String naverConn() {
		return "/user/connection";
    }
    
    @RequestMapping(value = "/connection", method = RequestMethod.POST)
    public String naverConnAction(SocialVO vo, HttpSession session, Model model) {
    	String reqUrl = (String) session.getAttribute("reqUrl");
    	String reqBody = (String)session.getAttribute("reqBody");
    	if(vo.getSns_id().toString().length() > 10) {
    		vo.setSns_type("naver");
    	}
    	else {
    		vo.setSns_type("kakao");
    	}
    	userService.insertSocialInfo(vo);
    	
    	SocialVO naverData = userService.SocialLogin(vo);
    	
    	session.setAttribute("id", naverData.getId());
		session.setAttribute("snsName", naverData.getSns_name());
		session.setAttribute("role", naverData.getRole());
    	session.removeAttribute("user");
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
    }
    
    
    @RequestMapping(value = "/kakao/login", method = RequestMethod.GET)
    public String kakaoLogin(@RequestParam String code, HttpSession session, Model model) {
    	String reqUrl = (String) session.getAttribute("reqUrl");
    	String reqBody = (String)session.getAttribute("reqBody");
        String accessToken = userService.getAccessToken(code);
        if(accessToken == null) {
        	return "redirect:/login";
        }
        
        SocialVO userInfo = userService.getUserInfo(accessToken);
        UserVO existedUser = userService.userInfoCheckForSocial(userInfo);
        boolean isOneInUrl = reqUrl != null && reqUrl.contains("one");
        
        if(existedUser == null) {
        	userService.kakaoUserForJoin(userInfo);
        	existedUser = userService.userInfoCheckForSocial(userInfo);
        	userInfo.setId(existedUser.getId());
        	userInfo.setSns_type("kakao");
        	userService.insertSocialInfo(userInfo);
        	SocialVO social_info = userService.SocialLogin(userInfo);
        	session.setAttribute("id", social_info.getId());
        	session.setAttribute("snsName", social_info.getSns_name());
        	session.setAttribute("role", social_info.getRole());
        	if (reqBody != null) {
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    JsonNode jsonNode = mapper.readTree(reqBody);
                    String ptype = jsonNode.path("ptype").asText();
                    String page = jsonNode.path("page").asText();
                    String pcode = jsonNode.path("pcode").asText();
                                       
                    if (!ptype.isEmpty()) {
                    	if(isOneInUrl) {
                    		return "redirect:/order/orderResponse";
                    	}
                        // ptype 값을 URL 인코딩
                    	String encodedPtype = URLEncoder.encode(ptype, "UTF-8");
                        // 페이지 정보와 함께 리다이렉트 URL 생성
                        String redirectUrl = String.format("/product/list?page=%s&ptype=%s", page, encodedPtype);
                        return "redirect:" + redirectUrl;
                    } else if (!pcode.isEmpty()) {
                    	if(isOneInUrl) {
                    		return "redirect:/order/orderResponse";
                    	}
                        // pcode 값이 있을 경우, 해당 상품 상세 페이지로 리다이렉트
                        String redirectUrl = String.format("/product/detail/%s", pcode);
                        return "redirect:" + redirectUrl;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    model.addAttribute("loginFailed", "로그인 처리 중 오류가 발생했습니다.");
                    return "redirect:/login";
                } 
            }else if(reqUrl!=null) {	
	    		return "redirect:"+reqUrl;
	    	}
        	return "redirect:/";
        }
        else {
        	SocialVO socialConnectedUser = userService.kakaoSocialConnCheck(existedUser.getId());
        	if(socialConnectedUser == null) {
        		userInfo.setId(existedUser.getId());
        		model.addAttribute("user", userInfo);
        		return "user/connection";
        	}
        	else {
        		SocialVO kakaoData = userService.SocialLogin(userInfo);
        		session.setAttribute("id", kakaoData.getId());
        		session.setAttribute("snsName", kakaoData.getSns_name());
        		session.setAttribute("role", kakaoData.getRole());
        		if (reqBody != null) {
                    try {
                        ObjectMapper mapper = new ObjectMapper();
                        JsonNode jsonNode = mapper.readTree(reqBody);
                        String ptype = jsonNode.path("ptype").asText();
                        String page = jsonNode.path("page").asText();
                        String pcode = jsonNode.path("pcode").asText();

                        if (!ptype.isEmpty()) {
                        	if(isOneInUrl) {
                        		return "redirect:/order/orderResponse";
                        	}
                            // ptype 값을 URL 인코딩
                        	String encodedPtype = URLEncoder.encode(ptype, "UTF-8");
                            // 페이지 정보와 함께 리다이렉트 URL 생성
                            String redirectUrl = String.format("/product/list?page=%s&ptype=%s", page, encodedPtype);
                            return "redirect:" + redirectUrl;
                        } else if (!pcode.isEmpty()) {
                        	if(isOneInUrl) {
                        		return "redirect:/order/orderResponse";
                        	}
                            // pcode 값이 있을 경우, 해당 상품 상세 페이지로 리다이렉트
                            String redirectUrl = String.format("/product/detail/%s", pcode);
                            return "redirect:" + redirectUrl;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        model.addAttribute("loginFailed", "로그인 처리 중 오류가 발생했습니다.");
                        return "redirect:/login";
                    } 
                }else if(reqUrl!=null) {	
    	    		return "redirect:"+reqUrl;
    	    	}
        		return "redirect:/";
        	}
        }
        
    }


}