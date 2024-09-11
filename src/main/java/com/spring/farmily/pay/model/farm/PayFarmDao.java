package com.spring.farmily.pay.model.farm;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.pay.model.PayVO;

@Repository
public class PayFarmDao {

    @Autowired
    private SqlSessionTemplate mybatis;

    public List<PayVO> getFarmPayListByPage(PayVO vo) {
        return mybatis.selectList("farmPayDao.getFarmPayListByPage", vo);
    }

    public int getPayListCount(PayVO vo) {
        return mybatis.selectOne("farmPayDao.getPayListCount", vo);
    }

    public void updateDeliveryState(String paycode, String newDstate) {
        mybatis.update("farmPayDao.updateDeliveryState", 
                       Map.of("paycode", paycode, "newDstate", newDstate));
    }

    public String getFnumByUserId(String userId) {
        return mybatis.selectOne("farmPayDao.getFnumByUserId", userId);
    }

    public PayVO getPayDetailByPaycode(String paycode) {
        return mybatis.selectOne("farmPayDao.getPayDetailByPaycode", paycode);
    }

    public int countByDstate(String fnum, String dstate) {
        return mybatis.selectOne("farmPayDao.countByDstate", 
                                 Map.of("fnum", fnum, "dstate", dstate));
    }
}