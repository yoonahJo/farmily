package com.spring.farmily.chart.model.farm;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FarmChartServiceImpl implements FarmChartService {

    @Autowired
    private FarmChartDao farmChartDao;

    @Override
    public String getFnumByUserId(String userId) {
        // userId로 fnum을 조회
        return farmChartDao.getFnumByUserId(userId);
    }
    

    @Override
    public List<Map<String, Object>> getMySales(String fnum) {
        return farmChartDao.getMySales(fnum);
    }
    @Override
    public List<Map<String, Object>> getMyDaySales(String fnum) {
        return farmChartDao.getMyDaySales(fnum);
    }

    @Override
    public List<Map<String, Object>> getMyCashCow(String fnum) {
        return farmChartDao.getMyCashCow(fnum);
    }

    @Override
    public List<Map<String, Object>> getMyProductRanking(String fnum) {
        return farmChartDao.getMyProductRanking(fnum);
    }
	@Override
	public List<Map<String, Object>> dailyProductNum(String fnum) {
		return farmChartDao.dailyProductNum(fnum);
	}

	@Override
	public List<Map<String, Object>> dailyUserNum(String fnum) {
		return farmChartDao.dailyUserNum(fnum);
	}

	@Override
	public List<Map<String, Object>> monthProductNum(String fnum) {
		return farmChartDao.monthProductNum(fnum);
	}
}