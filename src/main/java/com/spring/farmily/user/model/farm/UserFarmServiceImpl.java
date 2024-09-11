package com.spring.farmily.user.model.farm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.user.model.UserVO;

@Service("userFarmService")
public class UserFarmServiceImpl implements UserFarmService{
	@Autowired
	private UserFarmDao userFarmDao;
		
	@Override
	public UserVO getLogin(UserVO vo) {
		UserVO user = userFarmDao.login(vo); 
		return user;
	}

	@Override
	public UserVO getUser(String id) {
		UserVO user = userFarmDao.getUser(id);
		return user;
	}

	@Override
	public int update(UserVO vo) {
		int result = userFarmDao.update(vo);
		return result;		
	}

	@Override
	public int leave(UserVO vo) {
		int result = userFarmDao.leave(vo);
		return result;
	}

	@Override
	public boolean changePwd(UserVO vo) {
		return userFarmDao.changePwd(vo);
	}

}
