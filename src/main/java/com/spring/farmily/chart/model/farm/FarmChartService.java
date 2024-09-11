package com.spring.farmily.chart.model.farm;

import java.util.List;
import java.util.Map;

public interface FarmChartService {
    String getFnumByUserId(String userId);  // userId로 fnum 조회
    List<Map<String, Object>> getMySales(String fnum);
    List<Map<String, Object>> getMyDaySales(String fnum);
    List<Map<String, Object>> getMyCashCow(String fnum);
    List<Map<String, Object>> getMyProductRanking(String fnum);
	List<Map<String, Object>> dailyProductNum(String fnum);
	List<Map<String, Object>> dailyUserNum(String fnum);
	List<Map<String, Object>> monthProductNum(String fnum);
}