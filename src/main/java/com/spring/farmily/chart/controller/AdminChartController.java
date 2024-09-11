package com.spring.farmily.chart.controller;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.farmily.chart.model.admin.AdChartService;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/chart")
public class AdminChartController {

    @Autowired
    private AdChartService adChartService;

    @RequestMapping("/userStats")
    public String getMonthlyUserStats(Model model) {
    	
        List<Map<String, Object>> monthlyUserStats = adChartService.getMonthlyUserStats();
        List<Map<String, Object>> popularProducts = adChartService.getPopularProudcts();
        List<Map<String, Object>> genderRatio = adChartService.getGenderRatio();
        List<Map<String, Object>> ageGroup = adChartService.getAgeGroup();
        List<Map<String, Object>> highSales = adChartService.getHighSales();
        List<Map<String, Object>> highAmount = adChartService.getHighAmount();
        List<Map<String, Object>> fnamePaygunsu = adChartService.getFnamePaygunsu();  
        List<Map<String, Object>> fnamePayleebundalAmount = adChartService.getfnamePayleebundalAmount();
        List<Map<String, Object>> ptypeLeebundalPay = adChartService.getptypeleebundalpay();  // 수정된 변수명
        List<Map<String, Object>> numberOfUser = adChartService.numberOfUser();
        List<Map<String, Object>> numberOfProudct = adChartService.numberOfProudct();
        List<Map<String, Object>> daySale = adChartService.daySale();
        List<Map<String, Object>> sixMonthSale = adChartService.sixMonthSale();
        // 오늘 회원 가입 수와 이번 달 회원 가입 수
        int todayUserCount = adChartService.getTodayUserCount();
        int monthUserCount = adChartService.getMonthUserCount();
        // 오늘 매출액과 이번 달 매출액 
        int todaySalesAmount = adChartService.getTodaySalesAmount();
        int monthSalesAmount = adChartService.getMonthSalesAmount();
        // 오늘 결제 건수와 이번 달 결제 건수 
        int todayOrderCount = adChartService.getTodayOrderCount();
        int monthOrderCount = adChartService.getMonthOrderCount();
        
        
        // 이번 달의 모든 날짜 리스트 생성
        YearMonth currentMonth = YearMonth.now();
        int daysInMonth = currentMonth.lengthOfMonth();
        
        // 모든 일자를 기본값 0으로 초기화 (사용자 통계 및 일매출 데이터)
        List<Map<String, Object>> fullMonthlyStats = new ArrayList<>();
        List<Map<String, Object>> fullDaySaleStats = new ArrayList<>();
        
        for (int day = 1; day <= daysInMonth; day++) {
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("day", day);
            dayData.put("userCount", 0);  // 기본값으로 0 설정
            dayData.put("saleAmount", 0); // 기본값으로 0 설정
            fullMonthlyStats.add(dayData);
            fullDaySaleStats.add(dayData);
        }

        // 가져온 데이터로 해당 일자의 가입자 수를 업데이트
        for (Map<String, Object> stat : monthlyUserStats) {
            int day = ((Number) stat.get("day")).intValue();
            fullMonthlyStats.get(day - 1).put("userCount", stat.get("userCount"));
        }
        
        // 가져온 데이터로 해당 일자의 매출액을 업데이트
        for (Map<String, Object> stat : daySale) {
            int day = ((Number) stat.get("day")).intValue();
            fullDaySaleStats.get(day - 1).put("saleAmount", stat.get("매출액"));
        }
        

        
        

     // JSON 형식으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            String fullMonthlyStatsJson = objectMapper.writeValueAsString(fullMonthlyStats);
            String popularProductsJson = objectMapper.writeValueAsString(popularProducts);
            String genderRatioJson = objectMapper.writeValueAsString(genderRatio);
            String ageGroupJson = objectMapper.writeValueAsString(ageGroup);
            String highSalesJson = objectMapper.writeValueAsString(highSales);
            String highAmountJson = objectMapper.writeValueAsString(highAmount);
            String fnamePaygunsuJson = objectMapper.writeValueAsString(fnamePaygunsu);
            String fnamePayleebundalAmountJson = objectMapper.writeValueAsString(fnamePayleebundalAmount);
            String ptypeLeebundalPayJson = objectMapper.writeValueAsString(ptypeLeebundalPay);
            String numberOfUserPayJson = objectMapper.writeValueAsString(numberOfUser);
            String numberOfProudctJson = objectMapper.writeValueAsString(numberOfProudct);
            String fullDaySaleStatsJson = objectMapper.writeValueAsString(fullDaySaleStats);  // 여기서 fullDaySaleStats를 사용
            String sixMonthSaleJson = objectMapper.writeValueAsString(sixMonthSale);

            model.addAttribute("monthlyUserStats", fullMonthlyStatsJson);
            model.addAttribute("popularProducts", popularProductsJson);
            model.addAttribute("genderRatio", genderRatioJson);
            model.addAttribute("ageGroup", ageGroupJson);
            model.addAttribute("highSales", highSalesJson);
            model.addAttribute("highAmount", highAmountJson);
            model.addAttribute("fnamePaygunsu", fnamePaygunsuJson);
            model.addAttribute("fnamePayleebundalAmount", fnamePayleebundalAmountJson);
            model.addAttribute("ptypeLeebundalPay", ptypeLeebundalPayJson);
            model.addAttribute("numberOfUser", numberOfUserPayJson);
            model.addAttribute("numberOfProudct", numberOfProudctJson);
            model.addAttribute("daySale", fullDaySaleStatsJson);  // daySale 대신 fullDaySaleStats를 사용
            model.addAttribute("sixMonthSale", sixMonthSaleJson);
            model.addAttribute("todayUserCount", todayUserCount);
            model.addAttribute("monthUserCount", monthUserCount);
            model.addAttribute("todaySalesAmount", todaySalesAmount);
            model.addAttribute("monthSalesAmount", monthSalesAmount);
            model.addAttribute("todayOrderCount", todayOrderCount);
            model.addAttribute("monthOrderCount", monthOrderCount);
            
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        
        

        return "admin/chart/adminChart";
    }
}