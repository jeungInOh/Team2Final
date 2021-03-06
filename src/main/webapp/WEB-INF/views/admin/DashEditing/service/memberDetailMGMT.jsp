<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<style>
	#memberDetailApp{
		margin-top: 50px;
	}
	#memberDetailApp div table{
		width: 100%;
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	}
	#memberDetailApp div table th,td{
		border-bottom: 1px solid #444444;
	    padding: 10px;
	    text-align: center;
	}
	#memberDetailApp div table th{
		background-color: #bbdefb;
		font-size: 0.9em;
	}
	#memberDetailApp div table td{
		background-color: #e3f2fd;
		font-size: 0.9em;
	}
	.panel-heading div{
		border: 1px solid skyblue;
		width: 500px;
		margin-bottom: 1px;
		border-radius: 5px;
		padding-top: 10px;
	}
	.panel-heading div:hover{
		transition-duration:500ms;
		background-color: skyblue;
	}
	.panel-heading a{
		text-decoration: none;
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>


<div id="memberDetailWrap">
<h2>회원관리</h2>
<div id="memberDetailApp">




<div class="container-fluid" style="min-height: calc(100vh - 136px);">
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		<div class="panel panel-default">
			<div class="panel-heading" role="tab">
			<div id="accoBox1">
			<h3 class="accordion-header" id="headingOne">
				<a id="exeBox1" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="false">
				상세정보
				</a>
			</h3>
			</div>
			</div>
			<div id="collapse1" class="panel-collapse collapse" role="tabpanel">
				<div class="panel-body">
					<comp1 ui="${user_id }" id="comp1"></comp1>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab">
			<div id="accoBox2">
			<h3 class="accordion-header" id="headingTwo">
				<a id="exeBox2" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="false">
				구매목록
				</a>
			</h3>
			</div>
			</div>
			<div id="collapse2" class="panel-collapse collapse" role="tabpanel" style="margin-top: 5px; margin-bottom: 5px;">
				<div class="panel-body">
					<comp2 user="${user_id }" id="comp2"></comp2>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab">
			<div id="accoBox3">
			<h3 class="accordion-header" id="headingThree">
				<a id="exeBox3" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="false">
				서비스등록내역
				</a>
			</h3>
			</div>
			</div>
			<div id="collapse3" class="panel-collapse collapse" role="tabpanel"  style="margin-top: 5px; margin-bottom: 5px;">
				<div class="panel-body">
					<comp3 user="${user_id }" id="comp3"></comp3>
				</div>
			</div>
		</div>
	</div>
</div>

</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$("#accoBox1").click(function(){
		$("#exeBox1").get(0).click();
	});
	$("#accoBox2").click(function(){
		$("#exeBox2").get(0).click();
	});
	$("#accoBox3").click(function(){
		$("#exeBox3").get(0).click();
	});
});

var detailComp={
	template:`<div v-bind="post">
		<div>아이디:{{post.user_id}}</div>
		<div>이름:{{post.user_name}}</div>
		<div>이메일:{{post.user_email}}</div>
		<div>주소:{{post.user_addr}}</div>
		<div>연락처:{{post.user_phone}}</div>
		<div>
			<div style="display:inline-block">회원등급:{{post.user_grade}}</div>
		</div>
		<input type="hidden" v-bind:value="post.user_condition" ref="con">
		<div>
			<div v-if="post.user_condition==='1'" style="display:inline-block">
			이메일 인증완료
			<button style="display:inline-block" @click="changeCondition">계정정지/활성화</button>
			</div>
			<div v-if="post.user_condition==='0'" style="display:inline-block">
			이메일 인증 미완료
			</div>
			<div v-if="post.user_condition==='2'" style="display:inline-block">
			계정정지상태
			<button style="display:inline-block" @click="changeCondition">계정정지/활성화</button>
			</div>	
		</div>
		<div>보유포인트:{{post.user_point}}포인트</div>
		</div>`,
	data:function(){
		return{post:[]}
	},
	props:{
		ui:String
	},
	created:function(){
		axios.get('${cp}/memberDetailManagement?user_id='+this.ui).then(function(resp){
			this.post=resp.data;
			console.log(this.post);
		}.bind(this));
	},
	methods:{
		changeCondition:function(){
			axios.get('${cp}/memberDetailCon?user_id='+this.ui+
					'&user_condition='+this.$refs.con.value).then(function(resp){
						this.post=resp.data;
					}.bind(this))
		},
		changeGrade:function(){
			axios.get('${cp}/memberDetailGrd?user_id='+this.ui+
					'&user_grade='+this.$refs.grade.value).then(function(resp){
						this.post=resp.data;
					}.bind(this))
		}
	}
};

var buyComp={
		template:`<div>
		<table>
		<tr>
			<th>서비스이름</th>
			<th>시작날짜</th>
			<th>끝날짜</th>
			<th>결제상태</th>
			<th>결제금액(포인트제외)</th>
			<th>포인트사용금액</th>
			<th>사용쿠폰</th>
			<th>결제방식</th>
		</tr>
		<tr v-for="a in alist">
			<td>{{a.service_name}}</td>
			<td>{{a.accom_startdate}}</td>
			<td>{{a.accom_enddate}}</td>
			<td>{{a.payment_condition}}</td>
			<td>{{a.total_price}}</td>
			<td>{{a.point_useamount}}</td>
			<td>{{a.coupon_usecondition}}</td>
			<td>{{a.payment_method}}</td>
		</tr>
		</table>
		<br>
		<table>
		<tr>
			<th>서비스이름</th>
			<th>예약자명</th>
			<th>예약자연락처</th>
			<th>결제날짜</th>
			<th>유효기간</th>
			<th>결제상태</th>
			<th>결제금액(포인트제외)</th>
			<th>포인트사용금액</th>
			<th>사용쿠폰</th>
			<th>결제방식</th>
		</tr>
		<tr v-for="t in tlist">
			<td>{{t.service_name}}</td>
			<td>{{t.bookername}}</td>
			<td>{{t.bookerphone}}</td>
			<td>{{t.accom_startdate}}</td>
			<td>{{t.accom_enddate}}</td>
			<td>{{t.payment_condition}}</td>
			<td>{{t.total_price}}</td>
			<td>{{t.point_useamount}}</td>
			<td>{{t.coupon_usecondition}}</td>
			<td>{{t.payment_method}}</td>
		</tr>
		</table>
		</div>`,
		data:function(){
			return {
				alist:[],
				tlist:[]
			}
		},
		props:{
			user:String
		},
		created:function(){
			axios.get('${cp}/memberDetailBuylist?user_id='+this.user).then(function(resp){
				this.alist=resp.data.alist;
				this.tlist=resp.data.tlist;
				console.log(resp.data.alist);
				console.log(resp.data.tlist);
			}.bind(this));
		}
};

var serviceSignup={
		template:`<div>
			<h2>숙소등록목록</h2>
			<table>
				<tr>
					<th>숙소명</th>
					<th>주소</th>
				</tr>
				<tr v-for="a in alist">
					<td>{{a.accom_name}}</td>
					<td>{{a.accom_addr}}</td>
				</tr>
			</table>
			<h2 style='margin-top:5px;'>투어등록목록</h2>
			<table>
				<tr>
					<th>숙소명</th>
					<th>주소</th>
					<th>투어유형</th>
				</tr>
				<tr v-for="t in tlist">
					<td>{{t.tour_name}}</td>
					<td>{{t.tour_addr}}</td>
					<td>{{t.tour_type}}</td>
				</tr>
			</table>
		</div>`,
		data:function(){
			return{
				alist:[],
				tlist:[]
			}
		},
		props:{
			user:String
		},
		created:function(){
			axios.get('${cp}/memberDetailSignup?user_id='+this.user).then(function(resp){
				this.alist=resp.data.alist;
				this.tlist=resp.data.tlist;
				console.log(resp.data.alist);
				console.log(resp.data.tlist);
			}.bind(this));
		}
}

new Vue({
	el:'#memberDetailApp',
	components:{
		"comp1":detailComp,
		"comp2":buyComp,
		"comp3":serviceSignup
	}
});

</script>
