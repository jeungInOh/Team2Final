<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="Content-type" content="text/html;" charset="UTF-8">
<title>Simple Chat</title>
<style>
	#adminchat_wrapper{
		width:100%;
		margin:auto;
/* 		align-content: center; */
	}
	#functionBox{
		width:400px;
		margin:auto;
		border:2px dashed black;
		clear:left;
		padding:10px;
		background-color: #E1E1E1;
		border-radius: 25px 25px 25px 25px;
	}
	#functionBox input{
		border-radius: 25px 25px 25px 25px;	
		padding-left:10px;
		width:160px;
	}
	#functionBox textarea{
		padding:10px;
		border-radius: 25px 25px 25px 25px;	
		height:200px;
		width:350px;
	}
	input:focus, textarea:focus, select:focus, button:focus{
    	outline: none;
    }
	.messagewindow{
		width: 300px;
		height: 400px; 
		display:flex;  /*flex direction 사용하기 위함 */
 	    flex-direction: column-reverse; /*스크롤 하단 고정 */
	    overflow-y:auto;  /* 내용이 설정된 height을 넘기면 자동으로 스크롤 생성 */
		float: left;
		margin : 20px;
		word-break:break-all;
		padding:15px;
		border-radius: 25px 25px 25px 25px;
		color:black;
	}   
	
	.messagewindow::-webkit-scrollbar {
	   	width: 8px;
	   	height: 100px;
	}
			 
	.messagewindow::-webkit-scrollbar-thumb {
	    background-color: #2f3542;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	}
	.messagewindow::-webkit-scrollbar-track {
	    background-color: grey;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	    height:100px;
	}

	.fromM{/* 내 메세지 div */
		max-width:80%;
		margin:5px;
		margin-left:20%;
		word-break:break-all;
		padding:5px;
		border-radius:25px 25px 25px 25px;
	}
	.mMSG{/* 내용에 입힐 CSS */
		clear:both;
		float:right;
		text-align: left;
	}
	
 	.fromC{ /* 내가 아닌 메세지 div  */ 
		max-width:80%;
 		text-align: left;
		margin-right:60px;
		font-weight: 500;
		word-break:break-all;
		padding:5px;
		margin:5px;
		margin-left:-2px;
		margin-bottom:5px;
		clear:both;
		float:left;
	}
	.cTag{
		margin:0;
		font-weight: 700;
		text-align:left;
		padding-left:5px;
		margin-bottom:-8px;
	}
	

	.chatBtn:not(:disabled){
		border-radius: 25px 25px 25px 25px;
		background-color:#4E61FF;
		color:white;
	}
	.chatBtn:disabled{
		border-radius: 25px 25px 25px 25px;
		
	}
	.chatBtn:hover:not(:disabled){
		box-shadow: 1px 1px 2px 2px gray;
	}
	
	#who{
		margin-top:10px;
		border-radius: 25px 25px 25px 25px;
		padding:5px;
	}
</style>
</head>
<body>
	<div id="adminchat_wrapper">
		<div style="display: inline-block;">
			<!-- 관리자 접속 채팅 창 -->
			<div id="messages1" class="messagewindow"  style="background-color: #CEF279;">
			<h1>1번 Customer</h1>	
			</div>
			
			<div id="messages2" class="messagewindow"  style="background-color: #D6C7ED;">
			<h1>2번 Customer</h1>	
			</div>
			
			<div id="messages3" class="messagewindow"  style="background-color: pink;">
			<h1>3번 Customer</h1>	
			</div>
			
			<div id="messages4" class="messagewindow"  style="background-color: #B2EBF4;">
			<h1>4번 Customer</h1>	
			</div>
		</div><br>
		<div>
			<div id="functionBox">
				<button type="button" class="chatBtn" id="connect" onclick="openAll(event)">대화방 참여</button>
				<button type="button" class="chatBtn" id="disconnect" onclick="closeSocket(event)" disabled="disabled">대화방 나가기</button>
				<br><br>
				현재 대화 상대 : <input type="text" id="currentChat" placeholder="Whom To Speak" disabled="disabled"><br> <!--  현재 누구랑 대화 중인지 설정 --> 
				상대 : 
				<select id="who" onchange="changeTo(this.value);" disabled="disabled">
					<option>선택해주세요</option>
					<option value="customer1">customer1</option>
					<option value="customer2">customer2</option>
					<option value="customer3">customer3</option>
					<option value="customer4">customer4</option>
				</select><br>
				<br>
				<input type="text" id="sender" value="admin" style="display:none;">
				<textarea id="messageinput" style="resize:none;" ></textarea><br>
				<button type="button" class="chatBtn" id="sendit" onclick="send()">메세지전송</button>
				<button type="button" class="chatBtn" onclick="javascript:clearText()">대화내용 지우기</button>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	
	var ws;
	var ws1;
	var ws2;
	var ws3;
	var ws4;
	
	function changeTo(val){ //누구와 대화할지 바꾸는 메소드 
		console.log(val);
		document.getElementById("currentChat").value=val;
		
		if(val=='customer1'){
			ws = ws1;
		}else if(val=='customer2'){
			ws = ws2;
		}else if(val=='customer3'){
			ws = ws3;
		}else if(val=='customer4'){
			ws = ws4;
		}
	}
	
	
	function openSocket1(){
		
		writeResponse1("SYSTEM접속중...");
		if(ws1!= undefined && ws.readyState != WebSocket.CLOSED){
			writeResponse1("SYSTEMws WebSocket is already opended");
			return;
		}
		
		//웹 소켓 만드는 코드
		ws1 = new WebSocket("ws://localhost:9090/tour/echo1.do");
		
		ws1.onopen = function(event){
			if(event.data== undefined){
				console.log("오픈되면 오는 메세지!! : "+event.data);
				ws1.send("MANAGER가 접속하셨습니다.,MANAGER");
				return;
			}
			console.log("오픈되면 오는 메세지!! : "+event.data);
			writerResponse1(event.data);
		};
		ws1.onmessage = function(event){
			console.log('writeResponse');
			console.log('ws1에서 받아온 메세지 :' + event.data);
			writeResponse1(event.data);
		}
		ws1.onclose=function(event){
			writeResponse1("SYSTEM대화 종료");
		}
	}
	
	
	function openSocket2(){
		
		writeResponse2("SYSTEM접속중...");
	
		if(ws2!= undefined && ws.readyState != WebSocket.CLOSED){
			writeResponse2("SYSTEMws WebSocket is already opended");
			return;
		}
		
		//웹 소켓 만드는 코드
		ws2 = new WebSocket("ws://localhost:9090/tour/echo2.do");

		ws2.onopen = function(event){
			if(event.data== undefined){
				ws2.send("MANAGER가 접속하셨습니다.,MANAGER");
				return;
			}
			writerResponse2(event.data);
			
		};
		ws2.onmessage = function(event){
			console.log('writeResponse');
			console.log('ws2에서 받아온 메세지 :' + event.data);
			writeResponse2(event.data);
			
		}
		ws2.onclose=function(event){
			writeResponse2("SYSTEM대화 종료");
		}
		////////
	
	}
	function openSocket3(){
		
		writeResponse3("SYSTEM접속중...");
	
		if(ws3!= undefined && ws.readyState != WebSocket.CLOSED){
			writeResponse3("SYSTEMws WebSocket is already opended");
			return;
		}
		
		//웹 소켓 만드는 코드
		ws3 = new WebSocket("ws://localhost:9090/tour/echo3.do");

		ws3.onopen = function(event){
			if(event.data== undefined){
				ws3.send("MANAGER가 접속하셨습니다.,MANAGER");
				return;
			}
			writerResponse3(event.data);
			
		};
		ws3.onmessage = function(event){
			console.log('writeResponse');
			console.log('ws2에서 받아온 메세지 :' + event.data);
			writeResponse3(event.data);
		}
		ws3.onclose=function(event){
			writeResponse3("SYSTEM대화 종료");
		}
		////////
	
	}
	function openSocket4(){
		
		writeResponse4("SYSTEM접속중...");
	
		if(ws4!= undefined && ws.readyState != WebSocket.CLOSED){
			writeResponse4("SYSTEMws WebSocket is already opended");
			return;
		}
		
		//웹 소켓 만드는 코드
		ws4 = new WebSocket("ws://localhost:9090/tour/echo4.do");

		ws4.onopen = function(event){
			if(event.data== undefined){
				ws4.send("MANAGER가 접속하셨습니다.,MANAGER");
				return;
			}
			writerResponse4(event.data);
			
		};
		ws4.onmessage = function(event){
			console.log('writeResponse');
			console.log('ws4에서 받아온 메세지 :' + event.data);
			writeResponse4(event.data);
		}
		ws4.onclose=function(event){
			writeResponse4("SYSTEM대화 종료");
		}
		////////
	
	}
			
	//////////////////////
	
	//보내기만 하면 내가 서버여서 알아서 처리해서 뿌려줌
	
	function send(){
		var text = document.getElementById("messageinput").value;
		if(text==""){
			return;
		}
		text= text+","+document.getElementById("sender").value;
		console.log("text는 "+text);
		
		var who = document.getElementById("who").value;
		if(who=='customer1'){
			ws = ws1;
		}else if(who=='customer2'){
			ws = ws2;
		}else if(who=='customer3'){
			ws = ws3;
		}else if(who=='customer4'){
			ws = ws4;
		}
		ws.send(text);
		text="";
		document.getElementById("messageinput").value="";
	}
	
	document.getElementById("messageinput").addEventListener("keyup", function(e) {
		if(e.keyCode==13){
		    if (!event.shiftKey){
				e.preventDefault();//엔터는 원래는 줄바꿈인데 막고 전송으로!(필요시)
				send();
            }
		}
	}, false);
	
	
	///////////////////////
	function openAll(e){ //한번에 열기
		e.target.disabled=true; //대화방 참여 버튼 비활성화
		openSocket1();
		openSocket2();
		openSocket3();
		openSocket4();
		document.getElementById("disconnect").disabled=false;
		document.getElementById("who").disabled=false;
	}
	
	function closeSocket(e){ //한번에 닫기
		e.target.disabled=true;
		document.getElementById("connect").disabled=false;
		ws1.close();
		ws2.close();
		ws3.close();
		ws4.close();
// 		window.location.href="${cp}/";
		document.getElementById("who").disabled=true;
	}
	
	function writeResponse1(text){
		if(text.includes("#$#")){ //내가 보낸 메세지라는 표시
			var ntext = text.replace("#$#", "");
			messages1.innerHTML = "<div class='fromM'><span class='mMSG'>"+ ntext +"</span></div>"+messages1.innerHTML;
		}else if(text.includes("SYSTEM")){ //시스템이 보내는 메세지
			var ntext= text.replace("SYSTEM","");
			messages1.innerHTML = "<div class='fromC'><span>"+ntext+"</span></div><p class= 'cTag'>SYSTEM</p>"+messages1.innerHTML;
		}else{
			messages1.innerHTML = "<div class='fromC'><span>"+text+"</span></div><p class='cTag'>CUSTOMER1</p>"+messages1.innerHTML;
		}
	}
	function writeResponse2(text){
		if(text.includes("#$#")){ //내가 보낸 메세지라는 표시
			var ntext = text.replace("#$#", "");
			messages2.innerHTML = "<div class='fromM'><span class='mMSG'>"+ntext+"</span></div>"+messages2.innerHTML;
		}else if(text.includes("SYSTEM")){ //시스템이 보내는 메세지
			var ntext= text.replace("SYSTEM","");
			messages2.innerHTML = "<div class='fromC'><span>"+ntext+"</span></div><p class='cTag'>SYSTEM</p>"+messages2.innerHTML;
		}else{
			messages2.innerHTML = "<div class='fromC'><span>"+text+"</span></div><p class='cTag'>CUSTOMER2</p>"+messages2.innerHTML;
		}
	}
	function writeResponse3(text){
		if(text.includes("#$#")){ //내가 보낸 메세지라는 표시
			var ntext = text.replace("#$#", "");
			messages3.innerHTML = "<div class='fromM'><span class='mMSG'>"+ntext+"</span></div>"+messages3.innerHTML;
		}else if(text.includes("SYSTEM")){ //시스템이 보내는 메세지
			var ntext= text.replace("SYSTEM","");
			messages3.innerHTML = "<div class='fromC'><span>"+ntext+"</span></div><p class='cTag'>SYSTEM</p>"+messages3.innerHTML;
		}else{
			messages3.innerHTML = "<div class='fromC'><span>"+text+"</span></div><p class='cTag'>CUSTOMER3</p>"+messages3.innerHTML;
		}
	}
	function writeResponse4(text){
		if(text.includes("#$#")){ //내가 보낸 메세지라는 표시
			var ntext = text.replace("#$#", "");
			messages4.innerHTML = "<div class='fromM'><span class='mMSG'>"+ntext+"</span></div>"+messages4.innerHTML;
		}else if(text.includes("SYSTEM")){ //시스템이 보내는 메세지
			var ntext= text.replace("SYSTEM","");
			messages4.innerHTML = "<div class='fromC'><span>"+ntext+"</span></div><p class ='cTag'>SYSTEM</p>"+messages4.innerHTML;
		}else{
			messages4.innerHTML = "<div class='fromC'><span>"+text+"</span></div><p class='cTag'>CUSTOMER4</p>"+messages4.innerHTML;
		}
	}
	
	
	
	function clearText(){ //현재 선택된 채팅창만 지우기
		var currentChat = document.getElementById("currentChat").value;
		
		if(currentChat=='customer1'){
			document.getElementById("messages1").innerHTML="";
		}else if(currentChat=='customer2'){
			document.getElementById("messages2").innerHTML="";
		}else if(currentChat=='customer3'){
			document.getElementById("messages3").innerHTML="";
		}else if(currentChat=='customer4'){
			document.getElementById("messages4").innerHTML="";
		}
	}


</script>
</body>
</html>