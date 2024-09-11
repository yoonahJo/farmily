package com.spring.farmily.user.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.farmily.user.model.UserVO;

@Service("AuserService")
public class AUserServiceImpl implements AUserService{
	@Autowired
    private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private AUserDao AuserDAO;
	
	@Override
    public UserVO selectAdminUserByIdAndPassword(UserVO vo) {
        // 사용자 정보를 데이터베이스에서 조회
        UserVO user = AuserDAO.selectAdminUserByIdAndPassword(vo);        
        return user;
    }


	@Override
	public boolean validatePassword(String rawPassword, String encodedPassword) {
	    return passwordEncoder.matches(rawPassword, encodedPassword);
	}

	@Override
	public void AaddUser(UserVO vo) {
		AuserDAO.AaddUser(vo);
	}
	@Override
	public void AeditUser(UserVO vo) {
		AuserDAO.AeditUser(vo);
	}
	@Override
	public void AdeleteUser(UserVO vo) {
		AuserDAO.AdeleteUser(vo);
	}
	@Override
	public UserVO AgetUser(UserVO vo) {
		return AuserDAO.AgetUser(vo);
	}
	@Override
	public UserVO AgetViewUser(UserVO vo) {
		return AuserDAO.AgetViewUser(vo);
	}
	@Override
	public List<UserVO> AgetUserList(UserVO vo) {
		return AuserDAO.AgetUserList(vo);
	}	
	 @Override
	    public boolean AisIdAvailable(String id) {
	        return AuserDAO.AcheckIdExists(id) == 0; 
	    }
}
