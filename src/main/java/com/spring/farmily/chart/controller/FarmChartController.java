package com.spring.farmily.chart.controller;

import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.farmily.chart.model.farm.FarmChartService;
import com.spring.farmily.pay.model.farm.PayFarmService;

@Controller
@RequestMapping("/farm/chart")
public class FarmChartController {

    @Autowired
    private FarmChartService farmChartService;
    @Autowired
    private PayFarmService payFarmService;
    
    @RequestMapping("/myChart")
    public String getMyChart(Model model, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = (String) session.getAttribute("id");
        if (userId == null) {
            return "redirect:/user/login";
        }

        // userId로 fnum을 조회
        String fnum = farmChartService.getFnumByUserId(userId);

        // fnum을 이용해 차트 데이터 조회
        List<Map<String, Object>> mySales = farmChartService.getMySales(fnum);
        List<Map<String, Object>> myDaySales = farmChartService.getMyDaySales(fnum);
        List<Map<String, Object>> myCashCow = farmChartService.getMyCashCow(fnum);
        List<Map<String, Object>> myProductRanking = farmChartService.getMyProductRanking(fnum);

        List<Map<String, Object>> dailyProductNum = farmChartService.dailyProductNum(fnum);
        List<Map<String, Object>> dailyUserNum = farmChartService.dailyUserNum(fnum);
        List<Map<String, Object>> monthProductNum = farmChartService.monthProductNum(fnum);

        // 주문 상태별 카운트 계산
        int preparingCount = payFarmService.countByDstate(fnum, "배송준비중");
        int shippingCount = payFarmService.countByDstate(fnum, "배송중");
        int completedCount = payFarmService.countByDstate(fnum, "배송완료");

        // 이번 달의 모든 날짜 리스트 생성
        YearMonth currentMonth = YearMonth.now();
        int daysInMonth = currentMonth.lengthOfMonth();

        // 모든 일자를 기본값 0으로 초기화
        List<Map<String, Object>> fullMonthlyStats = new ArrayList<>();
        List<Map<String, Object>> fullmyDaySales = new ArrayList<>();

        for (int day = 1; day <= daysInMonth; day++) {
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("day", day);
            dayData.put("payCount", 0); // 기본값으로 0 설정
            dayData.put("myDaySales", 0);
            fullMonthlyStats.add(dayData);
            fullmyDaySales.add(dayData);
        }

        // 가져온 데이터로 해당 일자의 가입자 수를 업데이트
        for (Map<String, Object> stat : monthProductNum) {
            int day = ((Number) stat.get("day")).intValue();
            fullMonthlyStats.get(day - 1).put("payCount", stat.get("payCount"));
        }

        for (Map<String, Object> stat : myDaySales) {
            int day = ((Number) stat.get("day")).intValue();
            fullmyDaySales.get(day - 1).put("myDaySales", stat.get("daily_sales"));
        }

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            String mySalesJson = objectMapper.writeValueAsString(mySales);
            String myDaySalesJson = objectMapper.writeValueAsString(fullmyDaySales); // 변경된 부분
            String myCashCowJson = objectMapper.writeValueAsString(myCashCow);
            String myProductRankingJson = objectMapper.writeValueAsString(myProductRanking);

            model.addAttribute("mySales", mySalesJson);
            model.addAttribute("myDaySales", myDaySalesJson); // 변경된 부분
            model.addAttribute("myCashCow", myCashCowJson);
            model.addAttribute("myProductRanking", myProductRankingJson);
            model.addAttribute("preparingCount", preparingCount);
            model.addAttribute("shippingCount", shippingCount);
            model.addAttribute("completedCount", completedCount);

            String dailyProductNumJson = objectMapper.writeValueAsString(dailyProductNum);
            model.addAttribute("dailyProductNum", dailyProductNumJson);

            String dailyUserNumJson = objectMapper.writeValueAsString(dailyUserNum);
            model.addAttribute("dailyUserNum", dailyUserNumJson);

            String fullMonthlyStatsJson = objectMapper.writeValueAsString(fullMonthlyStats);
            model.addAttribute("monthProductNum", fullMonthlyStatsJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return "farm/chart/myChart";
    }
}