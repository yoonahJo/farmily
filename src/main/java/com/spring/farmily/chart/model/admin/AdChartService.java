package com.spring.farmily.chart.model.admin;

import java.util.List;
import java.util.Map;

public interface AdChartService {
    List<Map<String, Object>> getMonthlyUserStats();
    List<Map<String, Object>> getPopularProudcts();
    List<Map<String, Object>> getGenderRatio();
    List<Map<String, Object>> getAgeGroup();
    List<Map<String, Object>> getHighSales();
    List<Map<String, Object>> getHighAmount();
    List<Map<String, Object>> getFnamePaygunsu();
    List<Map<String, Object>> getfnamePayleebundalAmount();
    List<Map<String, Object>> getptypeleebundalpay();
    List<Map<String, Object>> numberOfUser();
    List<Map<String, Object>> numberOfProudct();
    List<Map<String, Object>> daySale();
    List<Map<String, Object>> sixMonthSale();
    int getTodayUserCount();
    int getMonthUserCount();
    int getTodaySalesAmount();
    int getMonthSalesAmount();
    int getTodayOrderCount();
    int getMonthOrderCount();
    
    
}