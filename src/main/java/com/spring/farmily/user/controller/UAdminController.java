package com.spring.farmily.user.controller;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.farmily.chart.controller.AdminChartController;
import com.spring.farmily.user.model.UserVO;
import com.spring.farmily.user.model.admin.AUserService;
import com.spring.farmily.user.model.admin.PageInfo;


@Controller
@RequestMapping(value="/admin")
public class UAdminController {   
	private static final Logger logger = LoggerFactory.getLogger(UAdminController.class);

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    private AUserService AuserService;
    
    @Autowired
    private AdminChartController adminChartController;
    
    @RequestMapping(value="", method=RequestMethod.GET)
	public String index(Model model, HttpSession session) {
	   
	    String chartView = adminChartController.getMonthlyUserStats(model);
	    return chartView;
	} //index에 차트띄우기
    
    // 관리자 로그인 화면으로 이동
    @RequestMapping(value="/Login", method=RequestMethod.GET)
    public String adminLoginView() {
        return "/admin/user/adminLogin"; // 로그인 화면으로 이동
    }
    
    // 로그아웃 처리
//    @RequestMapping("/logout")
//    public String logout(HttpSession session) {
//        printSessionAttributes(session); // 세션 속성 출력
//        session.invalidate(); // 세션 무효화
//        
//        return "redirect:/"; // 로그인 페이지로 리다이렉트
//    }
    @RequestMapping("/logout")
    public String logout(HttpServletResponse response, HttpSession session) {
        printSessionAttributes(session);
        // 캐시를 방지하는 헤더 설정
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // 세션 무효화
        session.invalidate();

        // 페이지 반환
        return "redirect:/"; // 로그인 페이지로 리다이렉트
    }
    
    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String handleAdminRequest(UserVO vo, HttpSession session, Model model) {
        UserVO user = AuserService.selectAdminUserByIdAndPassword(vo);

        if (user == null || !passwordEncoder.matches(vo.getPassword(), user.getPassword())) {
            // 비밀번호가 일치하지 않거나 유저가 존재하지 않는 경우
        	 model.addAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
             return "/admin/user/adminLogin"; // 로그인 페이지로 리다이렉트
        } else {
            // 유효한 사용자일 경우
            // 세션 속성 설정
            logger.info("Setting session attributes: id=" + user.getId() + ", role=" + user.getRole());
            session.setAttribute("id", user.getId());
            session.setAttribute("role", user.getRole()); // 역할이 유효하고 설정되어 있는지 확인
            logger.info("Session ID set: " + session.getAttribute("id"));
            logger.info("Session ROLE set: " + session.getAttribute("role"));

            // 관리 대시보드로 리다이렉트
            return "redirect:/admin";
        }
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.GET)
    public String addUserView(HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }
    

        printSessionAttributes(session); // 세션 속성 출력
        return "/admin/user/addUser"; // 회원 추가 페이지로 이동
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> addUser(UserVO vo, HttpSession session) throws IOException {
        Map<String, String> response = new HashMap<>();

        if (session.getAttribute("id") == null) {
            response.put("redirectUrl", "/login");
            return response; // 로그인 페이지로 리다이렉트
        }
        
        // 비밀번호 암호화 및 사용자 추가 처리
        String encodedPassword = passwordEncoder.encode(vo.getPassword());
        vo.setPassword(encodedPassword);
        AuserService.AaddUser(vo);

        // 성공적인 사용자 추가 후 리다이렉트 URL을 설정
        response.put("redirectUrl", "/admin/list");
        return response;
    }


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getUserList(
            @RequestParam(value = "role", required = false) String role,
            @RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "10") int limit, // 기본값을 10으로 설정
            HttpSession session, 
            Model model) {

        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리디렉션
        }

        // 모든 사용자 목록 가져오기
        List<UserVO> allUsers = AuserService.AgetUserList(new UserVO()); // 빈 필터 객체를 넘겨서 전체 목록을 가져옴

        // 역할 필터링 적용
        List<UserVO> filteredUsers;
        if (role != null && !role.isEmpty() && !"전체".equals(role)) {
            char filterRole = role.charAt(0); // role 값을 char로 변환
            filteredUsers = allUsers.stream()
                                    .filter(user -> user.getRole() == filterRole) // role을 char로 비교
                                    .collect(Collectors.toList());
        } else {
            // 필터가 없는 경우 전체 사용자 목록 반환
            filteredUsers = allUsers;
        }

        // 전체 항목 수
        int listCount = filteredUsers.size();

        // 페이징 정보 계산
        int maxPage = (int) Math.ceil((double) listCount / limit); // 총 페이지 수
        int startPage = ((page - 1) / 5) * 5 + 1; // 현재 페이지 그룹의 시작 페이지 번호
        int endPage = Math.min(startPage + 4, maxPage); // 현재 페이지 그룹의 끝 페이지 번호

        // PageInfo 객체 생성
        PageInfo pageInfo = new PageInfo();
        pageInfo.setPage(page);
        pageInfo.setMaxPage(maxPage);
        pageInfo.setStartPage(startPage);
        pageInfo.setEndPage(endPage);
        pageInfo.setListCount(listCount);

        // 페이징 적용
        int offset = (page - 1) * limit;
        List<UserVO> pagedUsers = filteredUsers.stream()
                                               .skip(offset)
                                               .limit(limit)
                                               .collect(Collectors.toList());

        // 모델에 사용자 목록 및 페이지 정보 추가
        model.addAttribute("userList", pagedUsers);
        model.addAttribute("page", page);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("role", role);

        // 디버깅 로그 추가
        System.out.println("Filtered role: " + role);
        System.out.println("User list size: " + pagedUsers.size());

        return "/admin/user/list";
    }

    @RequestMapping(value = "/getFilteredUserList", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getFilteredUserList(@RequestParam(value = "role", required = false) String role,
                                       @RequestParam(value = "page", defaultValue = "1") int page,
                                       HttpSession session,
                                       HttpServletRequest request) {
        if (session.getAttribute("id") == null) {
            throw new IllegalStateException("Unauthorized");
        }

        int pageSize = 10; // 페이지당 사용자 수
        int startIndex = (page - 1) * pageSize;

        // 모든 사용자 목록 가져오기
        List<UserVO> allUsers = AuserService.AgetUserList(new UserVO()); // 빈 필터 객체를 넘겨서 전체 목록을 가져옴

        // 역할 필터링 적용
        List<UserVO> filteredUsers;
        if (role != null && !role.isEmpty() && !"전체".equals(role)) {
            char filterRole = role.charAt(0); // role 값을 char로 변환
            filteredUsers = allUsers.stream()
                                    .filter(user -> user.getRole() == filterRole) // role을 char로 비교
                                    .collect(Collectors.toList());
        } else {
            // 필터가 없는 경우 전체 사용자 목록 반환
            filteredUsers = allUsers;
        }

        // 페이징 처리
        int totalUsers = filteredUsers.size();
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        filteredUsers = filteredUsers.stream()
                                     .skip(startIndex)
                                     .limit(pageSize)
                                     .collect(Collectors.toList());

        // JSP 페이지의 HTML을 반환
        StringBuilder html = new StringBuilder();
        String contextPath = request.getContextPath(); // 컨텍스트 경로를 가져옴
        for (UserVO user : filteredUsers) {
            String roleText;
            switch (user.getRole()) {
                case 'C':
                    roleText = "일반회원";
                    break;
                case 'F':
                    roleText = "농부";
                    break;
                case 'A':
                    roleText = "관리자";
                    break;
                default:
                    roleText = "미지정";
                    break;
            }
            html.append("<tr>")
            .append("<td class=\"text-center px-0\">")
            .append("<div class=\"d-flex justify-content-center align-items-center\" style=\"height: 100%;\">") // 중앙 정렬
            .append("<input class=\"custom-checkbox\" type=\"checkbox\" name=\"selectUser\" value=\"").append(user.getId()).append("\">")
            .append("</div>")
            .append("</td>")
            .append("<td class=\"text-center clickable-cell\" style=\"width: 280px;\" data-href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\">")
            .append(user.getId())
            .append("</td>")
            .append("<td class=\"text-center clickable-cell\" style=\"width: 150px;\" data-href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\">")
            .append(user.getUname())
            .append("</td>")
            .append("<td class=\"text-center clickable-cell\" style=\"width: 180px;\" data-href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\">")
            .append(roleText)
            .append("</td>")
            .append("<td class=\"text-center clickable-cell\" style=\"width: 180px;\" data-href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\">")
            .append(user.getPhone())
            .append("</td>")
            .append("<td class=\"text-center clickable-cell\" style=\"width: 180px;\" data-href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\">")
            .append(new SimpleDateFormat("yyyy-MM-dd").format(user.getRegdate()))
            .append("</td>")
            .append("<td class=\"text-center\" style=\"width: 250px;\">")
            .append("<div class=\"d-flex justify-content-center gap-2\">")
            .append("<a href=\"").append(contextPath).append("/admin/viewUser/").append(user.getId()).append("\" class=\"btn btn-secondary\">회원 수정</a>")
            .append("<form action=\"/admin/deleteUser\" method=\"post\" class=\"d-inline me-2 delete-user-form\" data-user-id=\"").append(user.getId()).append("\">")
            .append("<input type=\"hidden\" name=\"id\" value=\"").append(user.getId()).append("\">")
            .append("<button type=\"submit\" class=\"btn btn-outline-secondary\">회원 삭제</button>")
            .append("</form>")
            .append("</div>")
            .append("</td>")
            .append("</tr>");

        }

        // 페이지 정보 반환
        return html.toString() + "|pageInfo=" + totalPages + "," + page;
    }


    @RequestMapping("/viewUser/{id}")
    public String viewUser(@PathVariable("id") String id, HttpSession session, Model model) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리디렉션
        }

        printSessionAttributes(session); // 세션 속성 출력

        UserVO vo = new UserVO();
        vo.setId(id);

        UserVO user = AuserService.AgetViewUser(vo);

        if (user == null) {
            return "redirect:/admin/list"; // 사용자 목록 페이지로 리디렉션
        }

        model.addAttribute("user", user);
        return "/admin/user/viewUser"; // 사용자 상세 정보 페이지로 이동
    }

    @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    public String editUser(@ModelAttribute UserVO vo, HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리디렉션
        }

        printSessionAttributes(session); // 세션 속성 출력

        // 사용자 정보 수정
        AuserService.AeditUser(vo); 

        return "redirect:/admin/list"; // 사용자 목록 페이지로 리디렉션
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public String deleteUser(UserVO vo, HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리디렉션
        }

        printSessionAttributes(session); // 세션 속성 출력
        AuserService.AdeleteUser(vo);
        return "redirect:/admin/list"; // 사용자 목록 페이지로 리디렉션
    }
    @RequestMapping(value = "/deleteSelectedUsers", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteSelectedUsers(
            @RequestParam("selectedUserIds") String selectedUserIds,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        // 세션 체크
        if (session.getAttribute("id") == null) {
            response.put("message", "로그인 필요");
            return response;
        }

        try {
            // 선택된 사용자 ID 배열로 변환
            String[] idArray = selectedUserIds.split(",");

            for (String id : idArray) {
                UserVO vo = new UserVO();
                vo.setId(id.trim());

                // 사용자 삭제
                AuserService.AdeleteUser(vo);
            }

            response.put("message", "삭제가 완료되었습니다");
        } catch (Exception e) {
            // 오류 발생 시 로그 기록
            LoggerFactory.getLogger(getClass()).error("사용자 삭제 중 오류 발생", e);
            response.put("message", "삭제 중 오류 발생");
        }

        return response;
    }

    @RequestMapping(value = "/checkIdAvailability")
    @ResponseBody
    public Map<String, Boolean> checkIdAvailability(@RequestParam("id") String id) {
        // ID 확인 기능은 관리자 권한과 무관하므로 별도 권한 체크 없음
        Map<String, Boolean> response = new HashMap<>();
        boolean available = AuserService.AisIdAvailable(id); 
        response.put("available", available);
        return response;
    }

    // 세션 속성 출력 메서드 정의
    public void printSessionAttributes(HttpSession session) {
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            Object value = session.getAttribute(name);
            System.out.println("Session Attribute - " + name + ": " + value);
        }
    }
}