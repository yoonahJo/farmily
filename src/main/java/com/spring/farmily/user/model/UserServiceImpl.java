package com.spring.farmily.user.model;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Override
	public UserVO userLogin(UserVO vo) {
		// TODO Auto-generated method stub
		UserVO user = userDao.userLogin(vo);
		return user;
	}
	
	@Override
	public UserVO isRegistedUser(String id) {
		// TODO Auto-generated method stub
		UserVO isUser = userDao.isRegistedUser(id);
		return isUser;
	}

	@Override
	public int userJoin(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.registerUser(vo);
		return result;
	}

	@Override
	public UserVO getUser(String id) {
		// TODO Auto-generated method stub
		UserVO user = userDao.getUser(id);
		return user;
	}

	@Override
	public int updateUser(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.updateUser(vo);
		
		return result;
	}
	
	

	@Override
	public int updatePassword(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.updatePassword(vo);
		
		return result;
	}

	@Override
	public int dropUser(UserVO vo) {
		// TODO Auto-generated method stub
		
		int result = userDao.dropUser(vo);
		
		return result;
	}

	@Override
	public UserVO userInfoCheckForSocial(SocialVO vo) {
		// TODO Auto-generated method stub
		UserVO userVO = new UserVO();
		
		userVO.setUname(vo.getSns_name());
		userVO.setBirth(vo.getBirth());
		userVO.setGender(vo.getGender());
		
		UserVO user = userDao.userInfoCheckForSocial(userVO);
		return user;
	}

	@Override
	public int naverUserForJoin(SocialVO vo) {
		// TODO Auto-generated method stub
		UserVO userVO = new UserVO();
		String birth = vo.getBirthyear() + vo.getBirthday().split("-")[0] + vo.getBirthday().split("-")[1];
		String ramdom_id = "@n"+ RandomStringUtils.random(8, true, true);
		
		userVO.setId(ramdom_id);
		userVO.setPassword("");
		userVO.setUname(vo.getSns_name());
		userVO.setBirth(birth);
		userVO.setEmail(vo.getEmail());
		userVO.setPhone(vo.getMobile());
		userVO.setUaddress("");
		userVO.setUzcode("");
		userVO.setGender(vo.getGender());
		userVO.setRole('C');
		userVO.setFname("");
		userVO.setFnum("");
		userVO.setFaddress("");
		userVO.setFzcode("");
		
		int result = userDao.registerUser(userVO);
		
		return result;
	}
	
	@Override
	public int kakaoUserForJoin(SocialVO vo) {
		// TODO Auto-generated method stub
		UserVO userVo = new UserVO();
		System.out.println("type : " + vo.getSns_type() );
		String ramdom_id = "@k"+ RandomStringUtils.random(8, true, true);		
		userVo.setId(ramdom_id);
		userVo.setPassword("");
		userVo.setUname(vo.getSns_name());
		userVo.setBirth(vo.getBirth());
		userVo.setEmail(vo.getEmail());
		userVo.setPhone(vo.getMobile()); 
		userVo.setUaddress("");
		userVo.setUzcode("");
		userVo.setGender(vo.getGender());
		userVo.setRole('C');
		userVo.setFname("");
		userVo.setFaddress("");
		userVo.setFnum("");
		userVo.setFzcode("");	
		
		int result = userDao.registerUser(userVo);
		return result;
	}

	@Override
	public int insertSocialInfo(SocialVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.insertSocialInfo(vo);
		return result;
	}

	@Override
	public SocialVO SocialLogin(SocialVO vo) {
		// TODO Auto-generated method stub
		SocialVO user = new SocialVO();
		user = userDao.SocialLogin(vo);
		return user;
	}

	@Override
	public SocialVO naverSocialConnCheck(String id) {
		// TODO Auto-generated method stub
		SocialVO user = new SocialVO();
		user = userDao.naverSocialConnCheck(id);
		return user;
	}
	
	@Override
	public SocialVO kakaoSocialConnCheck(String id) {
		// TODO Auto-generated method stub
		SocialVO user = new SocialVO();
		user = userDao.kakaoSocialConnCheck(id);
		return user;
	}
	
	

	@Override
	public int dropSocialUser(SocialVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.dropSocialUser(vo);
		
		return result;
	}

	@Override
	public String getAccessToken(String code) {
		// TODO Auto-generated method stub
		final String clientId = "f6a352809611dcbedb271d56ff68d255";
		final String redirectUri = "http://localhost:8080/kakao/login";
		try {
			String tokenUrl = String.format("https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id=%s&redirect_uri=%s&code=%s",
                    clientId, redirectUri, code);

            RestTemplate restTemplate = new RestTemplate();
            Map<String, String> response = restTemplate.getForObject(tokenUrl, HashMap.class);

            if (response != null && response.containsKey("access_token")) {
                return response.get("access_token");
            } else {
                System.out.println("토큰 발급 요청 실패 " + response);
                return null;
            }
        } catch (Exception e) {
            System.out.println("토큰 발급 요청 예외 발생 " + e.getMessage());
            return null;
        }
	}
	

	@Override
	public SocialVO kakaoUserId(SocialVO vo) {
		// TODO Auto-generated method stub
		SocialVO kakao_user = userDao.kakaoUserId(vo);
		return kakao_user;
	}

	@Override
	public void kakaoUnlink(String target) {
		// TODO Auto-generated method stub
		String unLinkUrl = "https://kapi.kakao.com/v1/user/unlink?target_id_type=user_id&target_id=" + target;
		String adminKey = "a748c1478861f82341fa9333437a0575";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + adminKey);
        
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
        RestTemplate restTemplate = new RestTemplate();
        
        try {
        	ResponseEntity<Map> responseEntity = restTemplate.exchange(unLinkUrl, HttpMethod.POST, entity, Map.class);
            Map<String, Object> response = responseEntity.getBody();
        }
        catch (Exception e) {
			// TODO: handle exception
        	e.printStackTrace();
		}
	}

	@Override
	public SocialVO getUserInfo(String accessToken) {
		// TODO Auto-generated method stub
		String userInfoUrl = "https://kapi.kakao.com/v2/user/me";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
        RestTemplate restTemplate = new RestTemplate();
        
        try {
            ResponseEntity<Map> responseEntity = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, Map.class);
            Map<String, Object> response = responseEntity.getBody();
            SocialVO kakaoUser = new SocialVO();
            if (response != null) {
                Map<String, Object> kakaoAccountMap = (Map<String, Object>) response.get("kakao_account");
                if (kakaoAccountMap != null) {
                	kakaoUser.setSns_id(response.get("id").toString());
                	kakaoUser.setSns_name(kakaoAccountMap.get("name").toString());
                	kakaoUser.setEmail(kakaoAccountMap.get("email").toString());
                	kakaoUser.setBirth(kakaoAccountMap.get("birthyear").toString() + kakaoAccountMap.get("birthday").toString());
                    kakaoUser.setMobile("0".concat(kakaoAccountMap.get("phone_number").toString().split(" ")[1]));
                    kakaoUser.setGender(kakaoAccountMap.get("gender").toString().toUpperCase().charAt(0));
                    kakaoUser.setRole('C');
                }
            }
            return kakaoUser;
        }
        catch(Exception e) {
        	e.printStackTrace();
        	return null;
        }
    }

	@Override
	public UserVO findId(UserVO vo) {
		// TODO Auto-generated method stub
		UserVO user = userDao.findId(vo);
		return user;
	}

	@Override
	public UserVO findPw(UserVO vo) {
		// TODO Auto-generated method stub
		UserVO user = userDao.findPw(vo);
		return user;
	}

	@Override
	public int updateUserCode(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.updateUserCode(vo);
		
		return result;
	}

	@Override
	public UserVO hasUserCode(UserVO vo) {
		// TODO Auto-generated method stub
		UserVO user = userDao.hasUserCode(vo);
		return user;
	}

	@Override
	public int resetPw(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.resetPw(vo);
		
		return result;
	}

	@Override
	public int deleteUserCode(UserVO vo) {
		// TODO Auto-generated method stub
		int result = userDao.deleteUserCode(vo);
		
		return result;
	}
	
	@Override
    public void updateRelatedTables(String id) {
        userDao.updateProduct(id);
        userDao.updateReserve(id);
        userDao.updatePay(id);
    }
	
}
