package com.spring.farmily.user.model.farm;

import com.spring.farmily.user.model.UserVO;

public interface UserFarmService {
	public UserVO getLogin(UserVO vo);
	public UserVO getUser(String id);
	public int update(UserVO vo);
	public int leave(UserVO vo);
	public boolean changePwd(UserVO vo);
}
