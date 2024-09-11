package com.spring.farmily.chart.model.farm;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FarmChartDao {

    @Autowired
    private SqlSessionTemplate mybatis;

    // userId로 fnum 조회
    public String getFnumByUserId(String userId) {
        return mybatis.selectOne("chartDao.getFnumByUserId", userId);
    }

    // fnum으로 매출 조회
    public List<Map<String, Object>> getMySales(String fnum) {
        return mybatis.selectList("chartDao.getMySales", fnum);
    }
    public List<Map<String, Object>> getMyDaySales(String fnum) {
        return mybatis.selectList("chartDao.getMyDaySales", fnum);
    }

    public List<Map<String, Object>> getMyCashCow(String fnum) {
        return mybatis.selectList("chartDao.getMyCashCow", fnum);
    }

    public List<Map<String, Object>> getMyProductRanking(String fnum) {
        return mybatis.selectList("chartDao.getMyProductRanking", fnum);
    }
	public List<Map<String, Object>> dailyProductNum(String fnum) {
		return mybatis.selectList("chartDao.dailyProductNum", fnum);
	}
	public List<Map<String, Object>> dailyUserNum(String fnum) {
		return mybatis.selectList("chartDao.dailyUserNum", fnum);
	}
	public List<Map<String, Object>> monthProductNum(String fnum) {
		System.out.println("aaa" + fnum);
		return mybatis.selectList("chartDao.monthProductNum", fnum);
	}
}