package com.spring.farmily.user.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public UserVO userLogin(UserVO vo) {
		UserVO user = mybatis.selectOne("userDao.userLogin", vo);
		return user;
	}
	
	public UserVO isRegistedUser(String id) {
		UserVO user = mybatis.selectOne("userDao.isRegistedUser", id);
		return user;
	}
	
	public int registerUser(UserVO vo) {
		int result = mybatis.insert("userDao.registerUser", vo);
		return result;
	}
	
	public UserVO getUser(String id) {
		UserVO user = mybatis.selectOne("userDao.getUser", id);
		return user;
	}
	
	public int updateUser(UserVO vo) {
		int result = mybatis.update("userDao.updateUser", vo);
		return result;
	}
	
	public int dropUser(UserVO vo) {
		int result = mybatis.delete("userDao.dropUser", vo);
		return result;
	}
	
	public UserVO userInfoCheckForSocial(UserVO vo) {
		UserVO user = mybatis.selectOne("userDao.userInfoCheckForSocial", vo);
		return user;
	}
	
	public int insertSocialInfo(SocialVO vo) {
		int result = mybatis.insert("userDao.insertSocialInfo", vo);
		return result;
	}
	
	public SocialVO SocialLogin(SocialVO vo) {
		SocialVO user = mybatis.selectOne("userDao.SocialLogin", vo);
		return user;
	}
	
	public SocialVO naverSocialConnCheck(String id) {
		SocialVO naver_user = mybatis.selectOne("userDao.naverSocialConnCheck", id);
		return naver_user;
	}
	
	public SocialVO kakaoSocialConnCheck(String id) {
		SocialVO kakao_user = mybatis.selectOne("userDao.kakaoSocialConnCheck", id);
		return kakao_user;
	}
	
	public SocialVO kakaoUserId(SocialVO vo) {
		SocialVO kakao_user = mybatis.selectOne("userDao.kakaoUserId", vo);
		return kakao_user;
	}
	
	
	public UserVO findId(UserVO vo) {
		UserVO user = mybatis.selectOne("userDao.findId", vo);
		return user;
	}
	
	public UserVO findPw(UserVO vo) {
		UserVO user = mybatis.selectOne("userDao.findPw", vo);
		return user;
	}
	
	public int updateUserCode(UserVO vo) {
		int result = mybatis.update("userDao.updateUserCode", vo);
		return result;
	}
	
	public UserVO hasUserCode(UserVO vo) {
		UserVO user = mybatis.selectOne("userDao.hasUserCode", vo);
		return user;
	}
	
	public int resetPw(UserVO vo) {
		int result = mybatis.update("userDao.resetPw", vo);
		return result;
	}
	
	public int deleteUserCode(UserVO vo) {
		int result = mybatis.delete("userDao.deleteUserCode", vo);
		return result;
	}
	
	public int dropSocialUser(SocialVO vo) {
		int result = mybatis.update("userDao.dropSocialUser", vo);
		return result;
	}
	
	public int updatePassword(UserVO vo) {
		int result = mybatis.update("userDao.updatePassword", vo);
		return result;
	}
	
	// 사용자 관련 테이블 업데이트 메소드
    public void updateProduct(String userId) {
        mybatis.update("userDao.updateProduct", userId);
    }

    public void updateReserve(String userId) {
        mybatis.update("userDao.updateReserve", userId);
    }

    public void updatePay(String userId) {
        mybatis.update("userDao.updatePay", userId);
    }
	
}
