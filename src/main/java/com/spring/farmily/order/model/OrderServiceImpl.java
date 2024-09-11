package com.spring.farmily.order.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

		    
		    @Service("orderService")
		    public class OrderServiceImpl implements OrderService {
		        @Autowired
		        private OrderDao orderDao;
		        
		        @Override
		        public List<OrderProductVO> getOrderInfo(List<OrderProductVO> orders) {
		            List<OrderProductVO> result = new ArrayList<>();
		            
		            // 모든 OrderProductVO에 대해 정보를 조회합니다.
		            for (OrderProductVO ord : orders) {
		                // code로 정보를 얻기 위해 리스트를 가져옵니다.
		                List<OrderProductVO> orderInfos = orderDao.getOrderInfo(ord.getPcode());
		                
		                // 결과가 있는 경우 모든 정보를 result 리스트에 추가합니다.
		                for (OrderProductVO orderInfo : orderInfos) {
		                    orderInfo.setPcount(ord.getPcount());  // 원래의 pcount 값을 설정합니다.
		                    orderInfo.initSaleTotal();  // totalprice를 계산합니다.
		                    result.add(orderInfo);  // 결과 리스트에 추가합니다.
		                }
		            }
		            
		            return result;
		   }
		        
		        @Override
		        public List<OrderProductVO> getRcodeInfo(List<OrderProductVO> orders) {
		            List<OrderProductVO> result = new ArrayList<>();
		            
		            // 모든 OrderProductVO에 대해 정보를 조회합니다.
		            for (OrderProductVO ord : orders) {
		                // Rcode로 정보를 얻기 위해 리스트를 가져옵니다.
		                List<OrderProductVO> orderInfos = orderDao.getRcodeInfo(ord.getRcode());
		                
		                // 결과가 있는 경우 모든 정보를 result 리스트에 추가합니다.
		                for (OrderProductVO orderInfo : orderInfos) {
		                    result.add(orderInfo);  // 결과 리스트에 추가합니다.
		                }
		            }
		            
		            return result;
		   }
		}