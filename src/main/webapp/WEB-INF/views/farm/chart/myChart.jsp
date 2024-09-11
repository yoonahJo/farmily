<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmer ::  통계</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        

        .chart-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
        }

        .chart-box {
            flex: 1;
            min-width: 250px;
            max-width: 500px;
            text-align: center;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;  /* 차트의 높이를 조절 */
            display: block;
        }

        .shipping-status {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
             flex-wrap: wrap; /* 모바일에서 줄바꿈 허용 */
        }

        .shipping-status .card {
            flex: 1;
            margin-right: 15px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            display: flex; 
 		   	flex-direction: column; 
  			justify-content: center; 
  			align-items: center; 
  			min-width: 150px; /* 최소 카드 너비 설정 (모바일에서 너무 작아지는 것을 방지) */
        }

        .shipping-status .card-body {
            padding: 20px;
            text-align: center;
        }

        .shipping-status .card-body h5 {
            margin-bottom: 15px;
            font-weight: bold;
        }

        .shipping-status .card-body .status-count {
            font-size: 24px;
            color: #4CAF50;
        }
        .page-title {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        .page-title2 {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
    </style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />

<div class="container my-5"> 

<h2 class="page-title">농부차트</h2>
    <!-- 배송 현황 표시 -->
    <div class="shipping-status">
        <div class="card">
            <div class="card-body">
                <h5>배송준비중</h5>
                <p class="status-count">${preparingCount}건</p>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <h5>배송중</h5>
                <p class="status-count">${shippingCount}건</p>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <h5>결제완료</h5>
                <p class="status-count">${preparingCount+shippingCount+completedCount}건</p>
            </div>
        </div>
    </div>

<h2 class="page-title2 mt-5" id="dateTitle"></h2>

<!-- 매출 통계 -->
<div class="section-box">
    
    <div class="chart-container">
        <div class="chart-box">
    <h5>일별 매출</h5>
    <canvas id="myDaySales"></canvas>
</div>
        <div class="chart-box">
            <h5>월별 매출</h5>
            <canvas id="mySales"></canvas>
        </div>
    </div>
</div>



<!-- 상품 매출 및 판매량 순위 통계 -->
<div class="section-box mt-4">
    <div class="chart-container">
        <div class="chart-box">
    <h5>상품 매출 순위</h5>
    <canvas id="myCashCow"></canvas>
</div>
<div class="chart-box">
    <h5>상품 판매량 순위</h5>
    <canvas id="myProductRanking"></canvas>
</div>
    </div>
</div>


</div>
<script>
const year = new Date().getFullYear();
//현재 달 이름 가져오기
const currentMonth = new Date().toLocaleString('ko-KR', { month: 'long' });

document.getElementById('dateTitle').innerText = year + '년 ' + currentMonth;


    

    // JSON 데이터 파싱
    const mySales = JSON.parse('${mySales}');
    const myDaySales = JSON.parse('${myDaySales}');
    const myCashCow = JSON.parse('${myCashCow}');
    const myProductRanking = JSON.parse('${myProductRanking}');
	
    const dailyProductNum = JSON.parse('${dailyProductNum}');
    const dailyUserNum = JSON.parse('${dailyUserNum}');
    const monthProductNum = JSON.parse('${monthProductNum}');
    
    console.log('dailyUserNum:', dailyUserNum);
 // 월 매출 차트
    const mySalesLabels = mySales.map(item => item.month);
    const mySalesData = mySales.map(item => item.total_sales);

    const mySalesCtx = document.getElementById('mySales').getContext('2d');
    new Chart(mySalesCtx, {
        type: 'bar',
        data: {
            labels: mySalesLabels,
            datasets: [{
                label: '매출액',
                data: mySalesData,
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응 
            pointHitRadius: 20,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + ' 원'; // 값에 '원' 단위 추가
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    enabled: true,   // 툴팁을 활성화
                    mode: 'nearest', // 툴팁이 가장 가까운 데이터 포인트에 반응
                    intersect: false // 교차점을 기준으로 툴팁 표시 여부
                }
            },
            hover: {
                mode: 'nearest',  // 호버 시 가장 가까운 포인트에 대한 툴팁 표시
                intersect: false  // 포인트 교차점에서만 툴팁이 보이지 않도록 설정
            }
        }
    });


    // 일 매출 차트 
    const fullmyDaySales = JSON.parse('${myDaySales}');

    const myDaySalesLabels = fullmyDaySales.map(item => item.day + "일");
    const myDaySalesData = fullmyDaySales.map(item => item.myDaySales);

    const myDaySalesCtx = document.getElementById('myDaySales').getContext('2d');
    new Chart(myDaySalesCtx, {
        type: 'bar',
        data: {
            labels: myDaySalesLabels,
            datasets: [{
                label: '매출액',
                data: myDaySalesData,
                backgroundColor: 'rgba(54, 162, 235, 0.5)', 
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응 
            pointHitRadius: 20,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + ' 원'; // 값에 '원' 단위 추가
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    enabled: true,   // 툴팁을 활성화
                    mode: 'nearest', // 툴팁이 가장 가까운 데이터 포인트에 반응
                    intersect: false // 교차점을 기준으로 툴팁 표시 여부
                }
            },
            hover: {
                mode: 'nearest',  // 호버 시 가장 가까운 포인트에 대한 툴팁 표시
                intersect: false  // 포인트 교차점에서만 툴팁이 보이지 않도록 설정
            }
        }
    });

    // 상품 매출 순위 차트
    const myCashCowLabels = myCashCow.map(item => item.product_code);
    const myCashCowData = myCashCow.map(item => item.total_sales);

    const myCashCowCtx = document.getElementById('myCashCow').getContext('2d');
    new Chart(myCashCowCtx, {
        type: 'bar',
        data: {
            labels: myCashCowLabels,
            datasets: [{
                label: '매출액',
                data: myCashCowData,
                backgroundColor: 'rgba(75, 192, 192, 0.5)', // 통일된 차트 색상
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응 
            pointHitRadius: 20,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + ' 원'; // 값에 '원' 단위 추가
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    enabled: true,   // 툴팁을 활성화
                    mode: 'nearest', // 툴팁이 가장 가까운 데이터 포인트에 반응
                    intersect: false // 교차점을 기준으로 툴팁 표시 여부
                }
            },
            hover: {
                mode: 'nearest',  // 호버 시 가장 가까운 포인트에 대한 툴팁 표시
                intersect: false  // 포인트 교차점에서만 툴팁이 보이지 않도록 설정
            }
        }
    });

    // 상품 판매량 순위 차트 데이터
    const myProductRankingLabels = myProductRanking.map(item => item.product_code);
    const myProductRankingData = myProductRanking.map(item => item.total_quantity);

    const myProductRankingCtx = document.getElementById('myProductRanking').getContext('2d');
    new Chart(myProductRankingCtx, {
        type: 'line',  // 차트 유형을 'line'으로 설정
        data: {
            labels: myProductRankingLabels,
            datasets: [{
                label: '판매량',
                data: myProductRankingData,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',  // 배경색을 약하게 설정
                borderColor: 'rgba(255, 99, 132, 1)',  // 경계선 색
                borderWidth: 2,  // 경계선 두께
                fill: false,  // 라인 아래에 색상이 채워지지 않게 함
                tension: 0.2  // 라인을 부드럽게 연결
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응 
            pointHitRadius: 20,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + ' 개'; // 값에 '원' 단위 추가
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    enabled: true,   // 툴팁을 활성화
                    mode: 'nearest', // 툴팁이 가장 가까운 데이터 포인트에 반응
                    intersect: false // 교차점을 기준으로 툴팁 표시 여부
                }
            },
            hover: {
                mode: 'nearest',  // 호버 시 가장 가까운 포인트에 대한 툴팁 표시
                intersect: false  // 포인트 교차점에서만 툴팁이 보이지 않도록 설정
            }
        }
    });
    
    // 하루 상품 구매 개수 차트 
    const productNumLabels = dailyProductNum.map(pay => pay.name);
    const productNumData = dailyProductNum.map(pay => pay.quantity);

    const productNumCtx = document.getElementById('dailyNumChart').getContext('2d');
    new Chart(productNumCtx, {
        type: 'doughnut',
        data: {
            labels: productNumLabels,
            datasets: [{
                label: '상품별 하루 구매 수',
                data: productNumData,
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(255, 255, 224, 0.5)',
                    'rgba(153, 102, 255, 0.2)'
                ],
                borderWidth: 1
            }]
        },
        options: {
        	responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            pointHitRadius: 20,
        }
    });

    // 하루 상품 구매자수 차트 
    const dailyUserNumLabels = dailyUserNum.map(pay => pay.name);
    const dailyUserNumData = dailyUserNum.map(pay => pay.user_count);

    const dailyUserNumCtx = document.getElementById('dailyUserChart').getContext('2d');
    new Chart(dailyUserNumCtx, {
        type: 'bar',
        data: {
            labels: dailyUserNumLabels,
            datasets: [{
                label: '일일 구매자 수',
                data: dailyUserNumData,
                backgroundColor: 'rgba(255, 218, 185, 0.5)',
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
                },
                x: {
                    title: {
                        display: true,
                        
                    }
                }
            }
        }
    });

    // 한달간 구매건수 차트 
    const monthProductNumLabels = monthProductNum.map(stat => stat.day + "일");
    const monthProductNumData = monthProductNum.map(stat => stat.payCount);

    const monthProductNumCtx = document.getElementById('monthProductNumChart').getContext('2d');
    new Chart(monthProductNumCtx, {
        type: 'line',
        data: {
            labels: monthProductNumLabels,
            datasets: [{
                label: '하루 구매건수',
                data: monthProductNumData,
                borderColor: 'rgba(150, 150, 225, 1)',
                borderWidth: 3,
                tension: 0.2
            }]
        },
        options: {
        	responsive: true,
            maintainAspectRatio: false,  // 비율을 고정하지 않음
            devicePixelRatio: 2,         // 고해상도 화면에 대응
            pointHitRadius: 20,
            scales: {
                y: {
                    beginAtZero: true
                },
                x: {
                    title: {
                        display: true,
                        
                    }
                }
            }
        }
    });
</script>

<%@ include file="/modules/footer.jsp"%>
</body>
</html>
