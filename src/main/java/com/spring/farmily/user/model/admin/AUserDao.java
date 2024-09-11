package com.spring.farmily.user.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.user.model.UserVO;
@Repository
public class AUserDao {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void AaddUser(UserVO vo) {
		System.out.println("===> Mybatis로 addUser() 기능 처리");
		mybatis.insert("AUserDAO.AaddUser", vo);
	}
	
	public UserVO AgetUser(UserVO vo) {
		System.out.println("===> mybatis로 getUser() 기능 처리");
		return (UserVO) mybatis.selectOne("AUserDAO.AgetUser", vo);
	}
	
	public void AeditUser(UserVO vo) {
		System.out.println("===> mybatis로 editUser() 기능 처리");
		mybatis.update("AUserDAO.AeditUser", vo);
	}
	public void AdeleteUser(UserVO vo) {
		System.out.println("===> mybatis로 deleteUser() 기능 처리");
		mybatis.delete("AUserDAO.AdeleteUser", vo);
	}
	
	public UserVO AgetViewUser(UserVO vo) {
		System.out.println("===> mybatis로 getViewUser() 기능 처리");
		return (UserVO) mybatis.selectOne("AUserDAO.AgetViewUser", vo);
	}
	
	public List<UserVO> AgetUserList(UserVO vo) {
		System.out.println("===> mybatis로 getUserList() 기능 처리");	
		return mybatis.selectList("AUserDAO.AgetUserList", vo);
	}
	public int AcheckIdExists(String id) {
        System.out.println("===> mybatis로 checkIdExists() 기능 처리");
        return (Integer) mybatis.selectOne("AUserDAO.AcheckIdExists", id);
    }

	public UserVO selectAdminUserByIdAndPassword(UserVO vo) {
		System.out.println("===> mybatis로 selectUserByIdAndPassword() 기능 처리");
		UserVO user = mybatis.selectOne("AUserDAO.selectAdminUserByIdAndPassword", vo);
		return user;
	}

}
