package com.spring.farmily.pay.model.farm;

import java.util.List;
import com.spring.farmily.pay.model.PayVO;

public interface PayFarmService {
    List<PayVO> getFarmPayListByPage(PayVO vo, int page, int limit); // 페이징 처리된 결제 내역
    int getPayListCount(PayVO vo); // 결제 내역 총 수
    void updateMultipleDeliveryStates(String[] paycodes, String newDstate); // 배송 상태 업데이트
    String getFnumByUserId(String userId); // fnum을 가져오는 메서드
    PayVO getPayDetailByPaycode(String paycode); // 결제 내역 상세 조회
    int countByDstate(String fnum, String dstate); // 특정 배송 상태의 주문 개수 조회
}