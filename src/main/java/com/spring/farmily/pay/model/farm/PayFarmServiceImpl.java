package com.spring.farmily.pay.model.farm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.pay.model.PayVO;

@Service
public class PayFarmServiceImpl implements PayFarmService {

    @Autowired
    private PayFarmDao payFarmDao;

    @Override
    public List<PayVO> getFarmPayListByPage(PayVO vo, int page, int limit) {
        int offset = (page - 1) * limit; // 페이지 오프셋 계산
        vo.setLimit(limit);
        vo.setOffset(offset);
        return payFarmDao.getFarmPayListByPage(vo); // DAO 호출
    }

    @Override
    public int getPayListCount(PayVO vo) {
        return payFarmDao.getPayListCount(vo); // 결제 내역 수 카운트
    }

    @Override
    public void updateMultipleDeliveryStates(String[] paycodes, String newDstate) {
        for (String paycode : paycodes) {
            payFarmDao.updateDeliveryState(paycode, newDstate); // 배송 상태 업데이트
        }
    }

    @Override
    public String getFnumByUserId(String userId) {
        return payFarmDao.getFnumByUserId(userId); // fnum 조회
    }

    @Override
    public PayVO getPayDetailByPaycode(String paycode) {
        return payFarmDao.getPayDetailByPaycode(paycode);
    }

    @Override
    public int countByDstate(String fnum, String dstate) {
        return payFarmDao.countByDstate(fnum, dstate);
    }
}