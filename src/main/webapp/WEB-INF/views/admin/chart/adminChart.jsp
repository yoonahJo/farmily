<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin :: 통계</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
    
.canvasDiv {
    	height: 300px;
    }
    
.canvasMax {
	max-height: 280px;
}    
    
    
.textStatsMax {
	max-width: 400px;

}

@media (min-width:768px) {
	.textStatsMax {
		max-width: 230px;
	
	}
}

@media (min-width:1024px) {
	.textStatsMax {
		max-width: 300px;
	
	}
}

@media (min-width:1200px) {
	.textStatsMax {
		max-width: 350px;
	
	}
}

@media (min-width:1400px) {
	.textStatsMax {
		max-width: 400px;
	
	}
}

    </style>
</head>
<body class="nanum-gothic-regular">
<%@ include file="/modules/aheader.jsp"%>

<div class="container">
	<br><br>
  
  	<div class="row d-flex flex-column flex-md-row justify-content-center align-items-center mb-5">
	    <div class="textStatsMax col-12 col-md-4  text-center border border-1 rounded-3 px-0 py-3 me-0 me-md-2 me-lg-3 me-xl-4 me-xxl-5">
	        <h5 class="fw-bold mb-3">오늘 회원 가입 수</h5>
	        <p class="fs-3 text-success">${todayUserCount}명</p>
	        <p class="text-secondary">이번 달: ${monthUserCount}명</p>
	    </div>
	    <div class="textStatsMax col-12 col-md-4 text-center border border-1 rounded-3 px-0 py-3 mt-3 mt-md-0">
	        <h5 class="fw-bold mb-3">오늘 매출액</h5>
	        <p class="fs-3 text-success"><fmt:formatNumber value="${todaySalesAmount}" pattern="#,###" />원</p>
	        <p class="text-secondary">이번 달: <fmt:formatNumber value="${monthSalesAmount}" pattern="#,###" />원</p>
	    </div>
	    <div class="textStatsMax col-12 col-md-4 text-center border border-1 rounded-3 px-0 py-3 ms-0 ms-md-2 ms-lg-3 ms-xl-4 ms-xxl-5 mt-3 mt-md-0">
	        <h5 class="fw-bold mb-3">오늘 결제 건수</h5>
	        <p class="fs-3 text-success">${todayOrderCount}건</p>
	        <p class="text-secondary">이번 달: ${monthOrderCount}건</p>
	    </div>
	</div>
  
    <!-- 매출 통계 섹션 -->
    <div class="row">
    	<div class="col-12 col-md-6">
    		<h3 class="fs-2 fw-bold mx-3 mb-4 pb-1 border-1 border-bottom">매출 통계</h3>
	        <ul class="nav nav-tabs" id="myTab" role="tablist">
	        	<li class="nav-item" role="presentation">
			    	<button class="nav-link active fs-4" id="sales-day-tab" data-bs-toggle="tab" data-bs-target="#sales-day-tab-pane" type="button" role="tab" aria-controls="sales-day-tab-pane" aria-selected="true">일매출 통계</button>
			  	</li>
			  	<li class="nav-item" role="presentation">
			    	<button class="nav-link fs-4" id="sales-month-tab" data-bs-toggle="tab" data-bs-target="#sales-month-tab-pane" type="button" role="tab" aria-controls="sales-month-tab-pane" aria-selected="false">월매출 통계</button>
			  	</li>
		  	</ul>
		  	<div class="tab-content row" id="myTabContent">
		  		<div class="tab-pane fade show active col-12" id="sales-day-tab-pane" role="tabpanel" aria-labelledby="sales-day-tab" tabindex="0">
			  		<div class="chartbg p-0 rounded-3">
		            	<div class="canvasDiv">
<!-- 		                	<div class="ms-2 mt-2">일매출 통계</div> -->
		                	<div class="h-100 mt-2">
			                    <canvas class="canvasMax" id="daySaleChart"></canvas>
			                </div>
		            	</div>
		        	</div>
		  		</div>
			 	<div class="tab-pane fade col-12" id="sales-month-tab-pane" role="tabpanel" aria-labelledby="sales-month-tab" tabindex="0">
				 	<div class="chartbg p-0 mt-2 mt-md-0 rounded-3">
			            <div class="canvasDiv">
<!-- 			            	<div class="ms-2 mt-2">월매출 통계</div> -->
			                <div class="h-100 mt-2">
			                    <canvas class="canvasMax" id="sixMonthSaleChart"></canvas>
			                </div>
			            </div>
			        </div>
			  	</div>
			</div>
   		</div>
    	<div class="col-12 col-md-6">
    		<h3 class="fs-2 fw-bold mx-3 mb-4 pb-1 border-1 border-bottom">회원 통계</h3>
    		<ul class="nav nav-tabs" id="myTab" role="tablist">
	        	<li class="nav-item" role="presentation">
			    	<button class="nav-link active fs-4" id="member-gender-tab" data-bs-toggle="tab" data-bs-target="#member-gender-tab-pane" type="button" role="tab" aria-controls="member-gender-pane" aria-selected="true">회원 성별 비율</button>
			  	</li>
			  	<li class="nav-item" role="presentation">
			    	<button class="nav-link fs-4" id="mber-age-tab" data-bs-toggle="tab" data-bs-target="#member-age-tab-pane" type="button" role="tab" aria-controls="member-age-tab-pane" aria-selected="false">연령대 분포</button>
			  	</li>
		  	</ul>
		  	<div class="tab-content row" id="myTabContent">
		  		<div class="tab-pane fade show active col-12" id="member-gender-tab-pane" role="tabpanel" aria-labelledby="member-gender-tab" tabindex="0">
		  			<div class="chartbg p-0 rounded-3">
			            <div class="canvasDiv">
			                <div class="h-100 mt-2">
			                    <canvas class="canvasMax" id="genderRatioChart"></canvas>
			                </div>
			            </div>
			        </div>
		  		</div>
		  		<div class="tab-pane fade col-12" id="member-age-tab-pane" role="tabpanel" aria-labelledby="mber-age-tab" tabindex="0">
		  			<div class="chartbg p-0 rounded-3">
			            <div class="canvasDiv">
			                <div class="h-100 mt-2">
			                    <canvas class="canvasMax" id="ageGroupChart"></canvas>
			                </div>
			            </div>
			        </div>
		  		</div>
		  	</div>
    	</div>
    </div>


    <!-- 상품 통계 섹션 -->
    <div class="">
    	<div class="row mt-5 mx-0 mx-md-3 mx-lg-0">
    		<div class="col-12 col-md-6 border-md-1 border-md-end border-md-end-1 p-0">
    			<h3 class="fs-2 fw-bold mx-0 mx-md-3 mb-4 pb-1 border-1 border-bottom">상품 통계</h3>
		        <div class="row d-flex justify-content-center p-md-0">
		        	<div class="row d-flex justify-content-start p-0">
		        		<div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">총 매출 Top 5</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="highSalesChart"></canvas>
				                </div>
				            </div>
				        </div>
				        <div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3 mt-3 mt-lg-0">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">총 판매량 Top 5</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="highAmountChart"></canvas>
				                </div>
				            </div>
				        </div>
		        	</div>
		        	<div class="row d-flex justify-content-start p-0 mt-5">
		        		<div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">예약 상품 순위 Top 5</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="popularProductsChart"></canvas>
				                </div>
				            </div>
				        </div>
				        <div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3 mt-3 mt-lg-0">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">상품 타입별 판매량</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="ptypeLeebundalPayChart"></canvas>
				                </div>
				            </div>
				        </div>
		        	</div>
		        </div>
    		</div>
    		<div class="col-12 col-md-6 mt-5 mt-md-0">
    			<h3 class="fs-2 fw-bold mx-0 mx-md-3 mb-4 pb-1 border-1 border-bottom">농장 통계</h3>
		        <div class="row d-flex justify-content-center p-0">
		        	<div class="row d-flex justify-content-start p-0">
		        		<div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">농장별 결제 건수</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="fnamePaygunsuChart"></canvas>
				                </div>
				            </div>
				        </div>
				        <div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3 mt-3 mt-lg-0">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">농장별 총매출</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="fnamePayleebundalAmountChart"></canvas>
				                </div>
				            </div>
				        </div>
		        	</div>
		        	<div class="row d-flex justify-content-start p-0 mt-5">
		        		<div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">농장별 회원 이용 수</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="numberOfUserChart"></canvas>
				                </div>
				            </div>
				        </div>
				        <div class="chartbg col-12 col-md-11 col-lg-5 p-0 mx-0 mx-md-1 rounded-3 mt-3 mt-lg-0">
				            <div class="canvasDiv">
				                <div class="ms-2 mt-2 fs-4 text-center">농장별 상품 종류 수</div>
				                <div class="canvasDiv">
				                    <canvas class="canvasMax" id="numberOfProudctChart"></canvas>
				                </div>
				            </div>
				        </div>
		        	</div>
		        </div>
    		</div>
    	</div>
    </div>
	<br><br>
</div>

<script>
    

    // 서버에서 전달된 JSON 데이터를 파싱하여 JavaScript 객체로 변환
    const monthlyUserStats = JSON.parse('${monthlyUserStats}');
    const genderRatio = JSON.parse('${genderRatio}');
    const ageGroup = JSON.parse('${ageGroup}');
    const totalSales = JSON.parse('${highSales}');
    const totalAmount = JSON.parse('${highAmount}');
    const popularProducts = JSON.parse('${popularProducts}');
    const fnamePaygunsu = JSON.parse('${fnamePaygunsu}');
    const fnamePayleebundalAmount = JSON.parse('${fnamePayleebundalAmount}');
    const ptypeLeebundalPay = JSON.parse('${ptypeLeebundalPay}');
    const numberOfUser = JSON.parse('${numberOfUser}');
    const numberOfProudct = JSON.parse('${numberOfProudct}');
    const fullDaySaleStats = JSON.parse('${daySale}');
    const sixMonthSale = JSON.parse('${sixMonthSale}');
    
    console.log('monthlyUserStats:', JSON.parse('${monthlyUserStats}'));
    console.log('genderRatio:', JSON.parse('${genderRatio}'));
    

    // 회원가입 현황 차트 
    

    // 회원 남녀 성비 차트  (파이 차트)
    const genderCtx = document.getElementById('genderRatioChart').getContext('2d');
    new Chart(genderCtx, {
        type: 'pie',
        data: {
            labels: genderRatio.map(gender => gender.gender),
            datasets: [{
                label: '성별 비율',
                data: genderRatio.map(gender => gender.gender_count),
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
          
            plugins: {
                legend: {
                    position: 'top',
                },
                datalabels: {
                    formatter: (value, context) => {
                        let sum = 0;
                        const dataArr = context.chart.data.datasets[0].data;
                        dataArr.forEach(data => {
                            sum += data;
                        });
                        return (value * 100 / sum).toFixed(2) + "%";
                    },
                    color: '#fff',
                    font: {
                        weight: 'bold'
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });

    // 연령대 분포 차트 
    const ageCtx = document.getElementById('ageGroupChart').getContext('2d');
    new Chart(ageCtx, {
        type: 'bar',
        data: {
            labels: ageGroup.map(age => age.age_group),
            datasets: [{
                label: '연령 분포',
                data: ageGroup.map(age => age.count),
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 총 매출 Top 5 차트 
    const highSalesCtx = document.getElementById('highSalesChart').getContext('2d');
    new Chart(highSalesCtx, {
        type: 'bar',
        data: {
            labels: totalSales.map(product => product.name),
            datasets: [{
                label: '총 매출(₩)',
                data: totalSales.map(product => product.sales),
                backgroundColor: 'rgba(162, 249, 32, 0.2)',
                borderColor: 'rgba(162, 249, 32, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
            	 x: {
                     display: false // x축 데이터명 숨기기
                 },
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 총 판매량 Top 5 차트 
    const highAmountCtx = document.getElementById('highAmountChart').getContext('2d');
    new Chart(highAmountCtx, {
        type: 'bar',
        data: {
            labels: totalAmount.map(product => product.name),
            datasets: [{
                label: '총 판매량(개)',
                data: totalAmount.map(product => product.quantity),
                backgroundColor: 'rgba(244, 249, 97, 0.2)',
                borderColor: 'rgba(244, 249, 97, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
            	 x: {
                     display: false // x축 데이터명 숨기기
                 },
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 예약 상품 순위 Top 5 차트 
    const popularProductsCtx = document.getElementById('popularProductsChart').getContext('2d');
    new Chart(popularProductsCtx, {
        type: 'bar',
        data: {
            labels: popularProducts.map(product => product.pname),
            datasets: [{
                label: '예약 수',
                data: popularProducts.map(product => product.reserve_count),
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
            	 x: {
                     display: false // x축 데이터명 숨기기
                 },
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 상품 타입별 판매량 차트 
    const ptypeCtx = document.getElementById('ptypeLeebundalPayChart').getContext('2d');
    new Chart(ptypeCtx, {
        type: 'pie',
        data: {
            labels: ptypeLeebundalPay.map(item => item.상품타입),
            datasets: [{
                label: '판매량',
                data: ptypeLeebundalPay.map(item => item.판매량),
                backgroundColor: [
                    'rgba(84, 196, 27, 0.4)',
                    'rgba(245, 145, 5, 0.4)'
                ],
                borderColor: [
                    'rgba(84, 196, 27, 0.4)',
                    'rgba(245, 145, 5, 0.4)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
          
            plugins: {
                legend: {
                    position: 'top',
                },
                datalabels: {
                    formatter: (value, context) => {
                        let sum = 0;
                        const dataArr = context.chart.data.datasets[0].data;
                        dataArr.forEach(data => {
                            sum += data;
                        });
                        return (value * 100 / sum).toFixed(2) + "%";
                    },
                    color: '#fff',
                    font: {
                        weight: 'bold'
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });

    // 농장별 결제 건수 차트 
    const fnameCtx = document.getElementById('fnamePaygunsuChart').getContext('2d');
    new Chart(fnameCtx, {
        type: 'bar',
        data: {
            labels: fnamePaygunsu.map(farm => farm.농장명),
            datasets: [{
                label: '결제 건수',
                data: fnamePaygunsu.map(farm => farm.결제건수),
                backgroundColor: 'rgba(255, 159, 64, 0.2)',
                borderColor: 'rgba(255, 159, 64, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 농장별 이번달 매출 차트
    const fnameSalesCtx = document.getElementById('fnamePayleebundalAmountChart').getContext('2d');
    new Chart(fnameSalesCtx, {
        type: 'bar',
        data: {
            labels: fnamePayleebundalAmount.map(item => item.농장명),
            datasets: [{
                label: '매출액',
                data: fnamePayleebundalAmount.map(item => item.매출액),
                backgroundColor: 'rgba(255, 159, 64, 0.2)',
                borderColor: 'rgba(255, 159, 64, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 농장별 회원 이용 수 차트
    const usernumCtx = document.getElementById('numberOfUserChart').getContext('2d');
    new Chart(usernumCtx, {
        type: 'bar',
        data: {
            labels: numberOfUser.map(item => item.농장명),
            datasets: [{
                label: '고객수',
                data: numberOfUser.map(item => item.고객수),
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // 농장별 상품 종류 수 차트
    const productnumCtx = document.getElementById('numberOfProudctChart').getContext('2d');
    new Chart(productnumCtx, {
        type: 'bar',
        data: {
            labels: numberOfProudct.map(item => item.농장명),
            datasets: [{
                label: '상품 종류 수',
                data: numberOfProudct.map(item => item.상품종류수),
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    // 일매출 통계 차트 설정
    const daySaleCtx = document.getElementById('daySaleChart').getContext('2d');
    new Chart(daySaleCtx, {
        type: 'bar',
        data: {
            labels: monthlyUserStats.map(stat => stat.day + "일"),
            datasets: [{
                label: '일매출액',
                data: monthlyUserStats.map(stat => stat.saleAmount),
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    // 월매출 차트
    const sixMonthSaleCtx = document.getElementById('sixMonthSaleChart').getContext('2d');
    new Chart(sixMonthSaleCtx, {
        type: 'bar',
        data: {
            labels: sixMonthSale.map(item => new Date(item.month + "-01").getMonth() + 1 + "월"),  // X축: 월만 표시
            datasets: [{
                label: '월 매출액 (₩)',
                data: sixMonthSale.map(item => item.매출액),  // Y축: 매출액
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            scales: {
                
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '매출액 (₩)'  // Y축 제목
                    }
                }
            }
        }
    });
</script>
<%@ include file="/modules/footer.jsp"%>
</body>
</html>
