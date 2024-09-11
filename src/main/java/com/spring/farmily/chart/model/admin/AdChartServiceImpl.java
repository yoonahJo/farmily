package com.spring.farmily.chart.model.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdChartServiceImpl implements AdChartService {

    @Autowired
    private AdChartDao adChartDao;

    @Override
    public List<Map<String, Object>> getMonthlyUserStats() {
        return adChartDao.getMonthlyUserStats();
    }

	@Override
	public List<Map<String, Object>> getPopularProudcts() {
		// TODO Auto-generated method stub
		return adChartDao.getPopularProudcts();
	}

	@Override
	public List<Map<String, Object>> getGenderRatio() {
		// TODO Auto-generated method stub
		return adChartDao.getGenderRatio();
	}

	@Override
	public List<Map<String, Object>> getAgeGroup() {
		// TODO Auto-generated method stub
		return adChartDao.getAgeGroup();
	}

	@Override
	public List<Map<String, Object>> getHighSales() {
		// TODO Auto-generated method stub
		return adChartDao.getHighSales();
	}

	@Override
	public List<Map<String, Object>> getHighAmount() {
		// TODO Auto-generated method stub
		return adChartDao.getHighAmount();
	}
    @Override
    public List<Map<String, Object>> getFnamePaygunsu() {
        return adChartDao.getFnamePaygunsu();
    }
   
    @Override
    public List<Map<String, Object>> getfnamePayleebundalAmount() {
        return adChartDao.getfnamePayleebundalAmount();
    }
    @Override
    public List<Map<String, Object>> getptypeleebundalpay() {
        return adChartDao.getptypeleebundalpay();
    }

	@Override
	public List<Map<String, Object>> numberOfUser() {
		// TODO Auto-generated method stub
		return adChartDao.numberOfUser();
	}

	@Override
	public List<Map<String, Object>> numberOfProudct() {
		// TODO Auto-generated method stub
		return adChartDao.numberOfProudct();
	}

	@Override
	public List<Map<String, Object>> daySale() {
		// TODO Auto-generated method stub
		return adChartDao.daySale();
	}

	@Override
	public List<Map<String, Object>> sixMonthSale() {
		// TODO Auto-generated method stub
		return adChartDao.sixMonthSale();
	}
    
	@Override
	public int getTodayUserCount() {
	    return adChartDao.getTodayUserCount();
	}

	@Override
	public int getMonthUserCount() {
	    return adChartDao.getMonthUserCount();
	}
	@Override
	public int getTodaySalesAmount() {
	    return adChartDao.getTodaySalesAmount();
	}

	@Override
	public int getMonthSalesAmount() {
	    return adChartDao.getMonthSalesAmount();
	}
	@Override
	public int getTodayOrderCount() {
	    return adChartDao.getTodayOrderCount();
	}

	@Override
	public int getMonthOrderCount() {
	    return adChartDao.getMonthOrderCount();
	}
}