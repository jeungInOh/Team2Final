<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#adultNum{
		-ms-user-select: none;
		-moz-user-select: -moz-none; 
		-webkit-user-select: none; 
		-khtml-user-select: none; 
		user-select:none;
	}
	#changeCount div{
		-ms-user-select: none;
		-moz-user-select: -moz-none; 
		-webkit-user-select: none; 
		-khtml-user-select: none; 
		user-select:none;
	}
	#loading {
		height: 100%;
		left: 0px;
		position: fixed;
		_position:absolute; 
		top: 0px;
		width: 100%;
		filter:alpha(opacity=50);
		-moz-opacity:0.5;
		opacity : 0.5;
	}
	.loading {
		background-color: white;
		z-index: 199;
	}
	#loading_img{
		position:absolute; 
		top:50%;
		left:50%;
		height:35px;
		margin-top:-75px;
		margin-left:-75px;	
		z-index: 200;
	}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>



<div style="width: 1000px; height: 60px; background-color: #E4F7BA;">
<div style="display: inline-block;">
	<input type="text" id="search">
</div>
<div style="display: inline-block;">
	날짜<input type="text" id="d1" readonly="readonly" size="10">~
	<input type="text" id="d2" readonly="readonly" size="10">
</div>
<div style="display: inline-block;">
	<div id="numCount" name="nCount">
	<span id="totCount" name="nCount">1명</span>
	</div>
	<div id="changeCount" name="nCount" style="width: 200px; display: none; background-color: pink;">
		인원<br><br>
		<div name="nCount">성인
			<i class="fas fa-minus-circle fa-2x" name="nCount" id="minCount"
			style="color: #B2EBF4;"></i>
			<span id="adultNum" name="nCount">1명</span>
			<i class="fas fa-plus-circle fa-2x" name="nCount" id="plusCount"
			style="color: #B2EBF4;"></i>
		</div>
	</div>
</div>
<input type="button" value="검색" id="searchAccom">
</div>
<br>
<div id="accomWrap" style="width: 1000px;">
<div id="accomFilter" style="display: inline-block; width: 500px; float: left;">
<div>
종류<br>
<input type="radio" name="gck" value="0" checked="checked" id="defradio">전체<br>
<input type="radio" name="gck" value="2">호텔<br>
<input type="radio" name="gck" value="3">펜션<br>
<input type="radio" name="gck" value="4">기타<br>
</div>
<br>
<div>
편의시설<br>
<input type="checkbox" name="fck" value="수영장">수영장<br>
<input type="checkbox" name="fck" value="바베큐장">바베큐장<br>
<input type="checkbox" name="fck" value="유아시설">유아시설<br>
<input type="checkbox" name="fck" value="카페">카페<br>
<input type="checkbox" name="fck" value="편의점">편의점<br>
<input type="checkbox" name="fck" value="온천">온천<br>
<input type="checkbox" name="fck" value="탁구장">탁구장<br>
<input type="checkbox" name="fck" value="골프장">골프장<br>
<input type="checkbox" name="fck" value="족구장">족구장<br>
<input type="checkbox" name="fck" value="연회장">연회장<br>
</div>
<br>
<div>
서비스<br>
<input type="checkbox" name="cck" value="wifi">wifi<br>
<input type="checkbox" name="cck" value="조식서비스">조식서비스<br>
<input type="checkbox" name="cck" value="무료주차">무료주차<br>
<input type="checkbox" name="cck" value="픽업">픽업<br>
<input type="checkbox" name="cck" value="보드게임">보드게임<br>
<input type="checkbox" name="cck" value="영화관람">영화관람<br>
<input type="checkbox" name="cck" value="금연">금연<br>
<input type="checkbox" name="cck" value="반려동물동반">반려동물동반<br>
</div>
<p>
  <label for="amount">총 숙박 요금</label>
  <input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
</p>
 
<div id="slider-range" style="width: 400px;"></div>

</div>
<div id="accomResult" style="display: inline-block; width: 500px; float: right;">
	<div id="accom">
		
	</div>
</div>
</div>


<script type="text/javascript">
var acnt=1; //어른 인원수
var totcnt=1; //총 인원수


	$(document).ready(function(){
		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${cp}/resources/gimgs/viewLoading.gif" />').appendTo(document.body).hide();
		$(window)	
		.ajaxStart(function(){
		loading.show();
		})
		.ajaxStop(function(){
		loading.hide();
		});

		
		$("#d1").datepicker('setDate','today');
		$("#d2").datepicker('setDate','+1D');
		var count=$("#totCount").text().replace(/[^0-9]/g,"");
		var startDate=$("#d1").val();
		var endDate=$("#d2").val();
		var param={
				"count" : count,
				"startDate" : startDate,
				"endDate" : endDate
		}
		getfirst(param);
		
	});
	$("#searchAccom").click(function(){
		$("input[type='checkbox']").prop("checked",false);
		$("#defradio").prop("checked",true);
		var count=$("#totCount").text().replace(/[^0-9]/g,"");
		var startDate=$("#d1").val();
		var endDate=$("#d2").val();
		console.log(count);
		console.log(startDate);
		console.log(endDate);
		var param={
				"count" : count,
				"startDate" : startDate,
				"endDate" : endDate
		}
		console.log(param);
		getfirst(param);
		
	});
	
	function getfirst(param){
		$.getJSON('${cp}/accomSelect_list',param, function(data) {
			var wMinprice=10000000;
			var wMaxprice=0;
			var count=$("#totCount").text().replace(/[^0-9]/g,"");
			var startDate=$("#d1").val();
			var endDate=$("#d2").val();
			var facility=[]; //시설 배열
			var conven=[]; //편의서비스 배열
			var category=[]; //카테고리 배열
			$("#accom").empty();
			for(let i=0;i<data.list.length;i++){
				var accomNum=data.list[i].accom_service_number;
				var accomName=data.list[i].accom_name;
				var minprice=data.price[i].MINP;
				var maxprice=data.price[i].MAXP;
				console.log(accomName);
				console.log(minprice);
				var content="<a href='${cp}/accomDetail?accomNum="+accomNum+"&startDate="+startDate+"&endDate="+endDate+"&count="+count+"'>"+
			"<section>"+
				"<img src='${cp}/resources/images/1.png'>"+
				"<h5>"+accomName+"</h5>"+
				"<p>숙소정보</p>"+
				"<p>1박 총 "+minprice*count+"원</p>"+
				"<p style='font-size: 0.7em;'>1인당 "+minprice+"원</p>"+
			"</section>"+
			"</a>";
				$("#accom").append(content);
				if(wMinprice>minprice){
					wMinprice=minprice;
				}
				if(wMaxprice<maxprice){
					wMaxprice=maxprice;
				}
			}
			var sliderMaxprice=wMaxprice;
			
			//함수 중복 실행 방지를 위해 언바인드 후 다시 바인드(1번만 실행)
			$("input[type='checkbox']").unbind("click").bind("click",function(){
				facility=[];
				conven=[];
				category=0;
				
				 $("input[name='fck']:checked").each(function(i){ //시설에 체크된 리스트 저장
		             facility.push($(this).val());
		         });
				 $("input[name='cck']:checked").each(function(i){ //편의서비스에 체크된 리스트 저장
		             conven.push($(this).val());
		         });
		         category=$("input[name='gck']:checked").val();
				 var param= {
						 "startDate" : startDate,
						 "endDate" : endDate,
						 "count" : count,
						 "facility" : facility,
						 "conven" : conven,
						 "category" : category,
						 "maxprice" : sliderMaxprice
				 }
				 console.log(param);
				 getfilter(param);
				 
			});
			
			$("input[type='radio']").unbind("click").bind("click",function(){
				facility=[];
				conven=[];
				category=0;
				
				 $("input[name='fck']:checked").each(function(i){ //시설에 체크된 리스트 저장
		             facility.push($(this).val());
		         });
				 $("input[name='cck']:checked").each(function(i){ //편의서비스에 체크된 리스트 저장
		             conven.push($(this).val());
		         });
		         category=$("input[name='gck']:checked").val();
				 var param= {
						 "startDate" : startDate,
						 "endDate" : endDate,
						 "count" : count,
						 "facility" : facility,
						 "conven" : conven,
						 "category" : category,
						 "maxprice" : sliderMaxprice
				 }
				 console.log(param);
				 getfilter(param);
				 
			});
			
			$( "#slider-range" ).slider({ //가격 슬라이더
			      range: "min",
			      min: wMinprice*count,
			      max: wMaxprice*count,
			      value: wMaxprice*count,
			      step : 4000,
			      slide: function( event, ui ) {
			        $( "#amount" ).val(" ~ " + ui.value + "원" );
			      },
			      stop:function(value,ui){
			    	  sliderMaxprice=parseInt(ui.value/count);
			    	  var param= {
								 "startDate" : startDate,
								 "endDate" : endDate,
								 "count" : count,
								 "facility" : facility,
								 "conven" : conven,
								 "category" : category,
								 "maxprice" : sliderMaxprice
						 }
			    	  console.log(param);
			    	  getfilter(param);
			      }
			    });
			$( "#amount" ).val(" ~ " + $( "#slider-range" ).slider("value")+"원" );
		});
	}
	
	function getfilter(param){
// 		$.getJSON('${cp}/accomSelect_list',param, function(data) {
// 			for(let i=0;i<data.list.length;i++){
// 				var accomName=data.list[i].accom_name;
// 				var minprice=data.price[i].MINP;
// 				var maxprice=data.price[i].MAXP;
// 				console.log(accomName);
// 				console.log(minprice);
// 			}
// 		});
		$.ajax({
			  url: '${cp}/accomSelect_list',
			  dataType: 'json',
			  data: param,
			  success: function(data) {
				  $("#accom").empty();
				  var count=$("#totCount").text().replace(/[^0-9]/g,"");
				  var startDate=$("#d1").val();
					var endDate=$("#d2").val();
				  for(let i=0;i<data.list.length;i++){
					  	var accomNum=data.list[i].accom_service_number;
						var accomName=data.list[i].accom_name;
						var minprice=data.price[i].MINP;
						var maxprice=data.price[i].MAXP;
						console.log(accomName);
						console.log(minprice);
						var content="<a href='${cp}/accomDetail?accomNum="+accomNum+"&startDate="+startDate+"&endDate="+endDate+"&count="+count+"'>"+
						"<section>"+
							"<img src='${cp}/resources/images/1.png'>"+
							"<h5>"+accomName+"</h5>"+
							"<p>숙소정보</p>"+
							"<p>1박 총 "+minprice*count+"원</p>"+
							"<p style='font-size: 0.7em;'>1인당 "+minprice+"원</p>"+
						"</section>"+
						"</a>";
						$("#accom").append(content);
					}
			  },
			  error: function(XMLHttpRequest, textStatus, errorThrown) {
			    console.log(textStatus, errorThrown);
			    $("#accom").empty();
			    var content="<a href=''>"+
				"<section>"+
					"<img src='${cp}/resources/images/3.png'>"+
					"<h3>검색결과가 없습니다...</h3>"
				"</section>"+
				"</a>";
				$("#accom").append(content);
			  }
		});
	}
	
	$("#plusCount").click(function(){
		if(!(acnt>=14)){
			acnt++;
			totcnt++;
		}
		$("#adultNum").text(acnt+"명");
		$("#totCount").text(totcnt+"명");
	});
	$("#minCount").click(function(){
		if(!(acnt<=1)){
			acnt--;
			totcnt--;
		}
		$("#adultNum").text(acnt+"명");
		$("#totCount").text(totcnt+"명");
	});
	$("#numCount").click(function(){
		$("#changeCount").slideToggle(200);
	});
	$('html').click(function(e){
		if(!$(e.target).is("[name='nCount']")){
			$("#changeCount").slideUp(200);
		}
	});
	$("#d1").datepicker({
		dateFormat:'yy-mm-dd',
		dayNamesMin:['일','월','화','수','목','금','토'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		yearSuffix:"년",
		showMonthAfterYear:true,
		minDate:0,
		maxDate:"2M",
		showAnim:"toggle",
		onClose: function(selectedDate) {
			var nextDay=new Date(selectedDate);
			nextDay.setDate(nextDay.getDate()+1);
			var nextTwo=new Date(selectedDate);
			nextTwo.setDate(nextTwo.getDate()+14);
			$("#d2").datepicker("option","minDate",nextDay);
			$("#d2").datepicker("option","maxDate",nextTwo);
		}
	});
	$("#d2").datepicker({
		dateFormat:'yy-mm-dd',
		dayNamesMin:['일','월','화','수','목','금','토'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		yearSuffix:"년",
		showMonthAfterYear:true,
		minDate:0,
		showAnim:"toggle"
	});
	
	
</script>
</body>
</html>