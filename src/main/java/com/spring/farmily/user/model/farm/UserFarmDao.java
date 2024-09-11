package com.spring.farmily.user.model.farm;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.user.model.UserVO;

@Repository
public class UserFarmDao {
	@Autowired
	private SqlSessionTemplate mybatis;
	

	public UserVO login(UserVO vo) {
		 UserVO user = mybatis.selectOne("UserFarmDao.login", vo);
		return user;
	}

	public UserVO getUser(String id) {
		UserVO user = mybatis.selectOne("UserFarmDao.myinfo",id);
		return user;
	}

	public int update(UserVO vo) {
		int result = mybatis.update("UserFarmDao.update",vo);
		return result;
	}

	public int leave(UserVO vo) {
		int result = mybatis.delete("UserFarmDao.leave",vo);
		return result;
	}

	public boolean changePwd(UserVO vo) {
		if(mybatis.update("UserFarmDao.changePwd",vo)==1) {
			return true;
		}else {
			return false;
		}
	}
}
