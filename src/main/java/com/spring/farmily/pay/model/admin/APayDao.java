package com.spring.farmily.pay.model.admin;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.spring.farmily.pay.model.PayVO;

@Repository
public class APayDao {
    @Autowired
    private SqlSessionTemplate mybatis;

    public List<PayVO> getPayList(Map<String, Object> params) {
        System.out.println("===> mybatis로 getPayList() 기능 처리");
        System.out.println("파라미터: " + params); // 파라미터 로그 출력
        return mybatis.selectList("APayDao.getPayList", params);
    }

    public int getTotalCount(Map<String, Object> params) {
        return mybatis.selectOne("APayDao.getTotalCount", params);
    }

    public int updatePay(PayVO vo) {
        System.out.println("Updating paycode: " + vo.getPaycode());
        int result = mybatis.update("APayDao.updatePay", vo);
        System.out.println("Rows affected: " + result);
        return result;
    }

    public PayVO getPayDetail(String paycode) {
        return mybatis.selectOne("APayDao.getPayDetail", paycode);
    }

}
