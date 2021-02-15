<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://kit.fontawesome.com/b99e675b6e.js"></script> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style type="text/css">
	.tourpastTripWrapper{
		display: flex;
		position: relative;
	}
	
	.tourpastTripWrapper .bookingSidebar{
		position: fixed;
		width: 200px;
		height: 650px;
		background: #4b4276;
		padding: 30px 0;
	}
	.tourpastTripWrapper .bookingSidebar h2{
		color: #fff;
		text-align: center;
		margin-bottom: 30px;
	}
	.tourpastTripWrapper .bookingSidebar ul li{
		padding: 15px;
		border-bottom: 1px solid rgba(0,0,0,0.05);
		border-top: 1px solid rgba(225,225,225,0.05);
		list-style:none;
		padding-left:0px;
	}
	.tourpastTripWrapper .bookingSidebar ul li a{
		color: #bdb8d7;
		display: block;
	}
	.tourpastTripWrapper .bookingSidebar ul li a .fas{
		width: 25px;
	}
	.tourpastTripWrapper .bookingSidebar ul li a .far{
		width: 25px;
	}
	.tourpastTripWrapper .bookingSidebar ul li:hover{
		background: #594f8d;
	}
	.tourpastTripWrapper .bookingSidebar ul li:hover a{
		color:#fff;
	}
	.tourpastTripWrapper .tourpastTripMain{
		width: 100%;
		margin-left: 200px;
		height: 710px;
	}
	.tourpastTripWrapper .tourpastTripMain #tourpastTripWrap{
		height: 600px;
	}
	.tourpastTripWrapper .tourpastTripMain #tourpastTripWrap .tourpastTripList{
		border-bottom: 1px solid rgba(0,0,0,0.05);
		border-top: 1px solid rgba(225,225,225,0.05);
		margin-left: 50px;
	}
	.tourpastTripWrapper .tourpastTripMain .tourpastTripPaging{
		text-align: center;
		
	}
</style>
</head>
<body>

<div class="tourpastTripWrapper">
	<div class="bookingSidebar">
		<h2>지난여행/후기</h2>
		<ul>
			<li><a href="${cp }/accomBookingCheck"><i class="fas fa-hotel"></i>숙소</a></li>
			<li><a href="${cp }/tourBookingCheck"><i class="fas fa-ticket-alt"></i>투어/티켓</a></li>
			<li>
				<a><i class="far fa-lightbulb"></i>지난여행/후기</a>
				<ul>
					<li><a href="${cp }/accompastTrip">숙박</a></li>
					<li><a href="${cp }/tourpastTrip">티켓/투어</a></li>
				</ul>
			</li>
			<li><a href="${cp }/cancleTrip"><i class="fas fa-plane-slash"></i>취소목록</a></li>
		</ul>
	</div>
	<div class="tourpastTripMain">
		<div id="tourpastTripWrap">
			<h2 style="text-align: center;">지난여행/후기</h2>
			<c:forEach var="vo" items="${bookingList }" varStatus="status">
				<div class="tourpastTripList">
					<div style="display: inline-block;">
						<img src="${cp}/resources/gimgs/${image[status.index][0].imgsavename}" 
						style="width: 100px; height: 100px;">
					</div>
					<div style="display: inline-block;">
						<h3><a href="${cp }/tourDetail?${option[status.index].service_number}">${vo.service_name }</a></h3>
						<span>${option[status.index].tour_option }</span><br>
						<span>여행날짜:</span><span>${vo.tour_startdate }~${vo.tour_enddate }</span>
						<br>
						<span>총 결제금액:</span><span>${vo.total_price }</span><span>원</span>
					</div>
				</div>
				<div style="display:inline-block; position: relative; left: 100px;">
					<a href="">리뷰쓰기</a>
				</div>
			</c:forEach>
		</div>
		<div class="tourpastTripPaging">
			<c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
				<c:choose>
					<c:when test="${i==pu.pageNum }">
						<a href="${cp }/tourpastTrip?pageNum=${i}"><span style='color:blue'>[${i }]</span></a>
					</c:when>
					<c:otherwise>
						<a href="${cp }/tourpastTrip?pageNum=${i}"><span style='color:gray'>[${i }]</span></a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</div>
</body>
</html>