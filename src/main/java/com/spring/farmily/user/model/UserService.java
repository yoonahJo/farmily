package com.spring.farmily.user.model;

public interface UserService {
	public UserVO userLogin(UserVO vo);
	public int userJoin(UserVO vo);
	public UserVO isRegistedUser(String id);
	public UserVO getUser(String id);
	public int updateUser(UserVO vo); 
	public int dropUser(UserVO vo);
	public UserVO userInfoCheckForSocial(SocialVO vo);
	public int naverUserForJoin(SocialVO vo);
	public int kakaoUserForJoin(SocialVO vo);
	public int insertSocialInfo(SocialVO vo);
	public SocialVO SocialLogin(SocialVO vo);
	public SocialVO naverSocialConnCheck(String id);
	public SocialVO kakaoSocialConnCheck(String id);
	public String getAccessToken(String code);
	public SocialVO getUserInfo(String accessToken);
	public UserVO findId(UserVO vo);
	public UserVO findPw(UserVO vo);
	public int updateUserCode(UserVO vo);
	public UserVO hasUserCode(UserVO vo);
	public int resetPw(UserVO vo);
	public int deleteUserCode(UserVO vo);
	public int dropSocialUser(SocialVO vo);
	public int updatePassword(UserVO vo);
	public SocialVO kakaoUserId(SocialVO vo);
	public void kakaoUnlink(String target);
	public void updateRelatedTables(String id);
}
