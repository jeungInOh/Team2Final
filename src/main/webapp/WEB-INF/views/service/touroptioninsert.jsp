<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<form action="${cp }/touroptioninsert" method="post" enctype="multipart/form-data" onsubmit="return check()">
		<input type="hidden" name="service_number" value="${service_number }">
		투어 가격 <input type="number" name="tour_price"><br><br>
		투어 옵션 <input type="text" name="tour_option"><br><br> 
		투어 수량 <input type="number" name="tour_amount"><br><br>
		할인율<br>
		<select name="discount" id="discount">
			<option value="0" selected="selected">0%</option>
			<option value="5">5%</option>
			<option value="10">10%</option>
			<option value="15">15%</option>
			<option value="20">20%</option>
			<option value="25">25%</option>
			<option value="30">30%</option>
			<option value="35">35%</option>
			<option value="40">40%</option>
			<option value="45">45%</option>
			<option value="50">50%</option>
		</select><br><br>
		<br>
		<input type="submit" value="전송">
	</form>
	<script>
		function check(){
			let tour_price=document.getElementsByName("tour_price")[0].value;
			let tour_option_index=document.getElementsByName("tour_option_index")[0].value;
			let tour_option=document.getElementsByName("tour_option")[0].value;
			let tour_amount=document.getElementsByName("tour_amount")[0].value;
			if(tour_price.replaceAll(" ","")==""){
				alert("투어 가격을 입력하세요.");
				return false;
			}
			if(tour_option_index.replaceAll(" ","")==""){
				alert("투어 옵션 번호를 입력하세요.");
				return false;
			}
			if(tour_option.replaceAll(" ","")==""){
				alert("투어 옵션을 입력하세요.");
				return false;
			}
			if(tour_amount.replaceAll(" ","")==""){
				alert("투어 수량을 입력하세요.");
				return false;
			}
			return true;
		}
	</script>
</div>