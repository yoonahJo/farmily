package com.spring.farmily.chart.model.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AdChartDao {

    @Autowired
    private SqlSessionTemplate mybatis;

    public List<Map<String, Object>> getMonthlyUserStats() {
        return mybatis.selectList("chartDao.getMonthlyUserStats");
    }
    public List<Map<String, Object>> getPopularProudcts() {
    	return mybatis.selectList("chartDao.getPopularProudcts");
    }
    public List<Map<String, Object>> getGenderRatio() {
    	return mybatis.selectList("chartDao.getGenderRatio");
    }
    public List<Map<String, Object>> getAgeGroup() {
    	return mybatis.selectList("chartDao.getAgeGroup");
    }
    public List<Map<String, Object>> getHighSales() {
    	return mybatis.selectList("chartDao.getHighSales");
    }
    public List<Map<String, Object>> getHighAmount() {
    	return mybatis.selectList("chartDao.getHighAmount");
    }
    public List<Map<String, Object>> getFnamePaygunsu() {
        return mybatis.selectList("chartDao.fnamePaygunsu");
    }
    public List<Map<String, Object>> getfnamePayleebundalAmount() {
        return mybatis.selectList("chartDao.fnamePayleebundalAmount");
    }
    public List<Map<String, Object>> getptypeleebundalpay() {
        return mybatis.selectList("chartDao.ptypeleebundalpay");
    }
    public List<Map<String, Object>> numberOfUser() {
        return mybatis.selectList("chartDao.numberOfUser");
    }
    public List<Map<String, Object>> numberOfProudct() {
        return mybatis.selectList("chartDao.numberOfProudct");
    }
    public List<Map<String, Object>> daySale() {
        return mybatis.selectList("chartDao.daySale");
    }
    public List<Map<String, Object>> sixMonthSale() {
        return mybatis.selectList("chartDao.sixMonthSale");
    }
    public int getTodayUserCount() {
        return mybatis.selectOne("chartDao.getTodayUserCount");
    }

    public int getMonthUserCount() {
        return mybatis.selectOne("chartDao.getMonthUserCount");
    }
    public int getTodaySalesAmount() {
        return mybatis.selectOne("chartDao.getTodaySalesAmount");
    }

    public int getMonthSalesAmount() {
        return mybatis.selectOne("chartDao.getMonthSalesAmount");
    }
    public int getTodayOrderCount() {
        return mybatis.selectOne("chartDao.getTodayOrderCount");
    }

    public int getMonthOrderCount() {
        return mybatis.selectOne("chartDao.getMonthOrderCount");
    }
    
}