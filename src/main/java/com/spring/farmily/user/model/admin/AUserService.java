package com.spring.farmily.user.model.admin;

import java.util.List;

import com.spring.farmily.user.model.UserVO;

public interface AUserService {
	UserVO selectAdminUserByIdAndPassword(UserVO vo);
    boolean validatePassword(String rawPassword, String encodedPassword);
	void AaddUser(UserVO vo);
	void AeditUser(UserVO vo);
	void AdeleteUser(UserVO vo);
	UserVO AgetUser(UserVO vo);
	UserVO AgetViewUser(UserVO vo);
	List<UserVO> AgetUserList(UserVO vo);
	boolean AisIdAvailable(String id);
	
	
}
