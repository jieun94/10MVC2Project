<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<!-- 참조 : http://getbootstrap.com/css/   참조 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
		
		<!-- Bootstrap Dropdown Hover CSS -->
	   	<link href="/css/animate.min.css" rel="stylesheet">
	   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	    <!-- Bootstrap Dropdown Hover JS -->
	   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	   
	   
	   	<!-- jQuery UI toolTip 사용 CSS-->
	  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	 	<!-- jQuery UI toolTip 사용 JS-->
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<!--  ///////////////////////// CSS ////////////////////////// -->
		<style>
		  body {
	            padding-top : 50px;
	        }
	    </style>
	    
	    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	</head>

	<body>

		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/layout/toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
	   	
		<!--  화면구성 div Start /////////////////////////////////////-->
		<div class="container">
		
			<div class="page-header">
		       <h3 class=" text-info">상품구매</h3>
		       <h5 class="text-muted">다음과 같이 구매가 되었습니다.</h5>
		    </div>
	
			<div class="row">
		  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
			</div>
		
		</div>
	
	<form name="updatePurchase" action="/purchase/updatePurchase?tranNo=${purchase.tranNo}" method="post">
	
	다음과 같이 구매가 되었습니다.
	
	<table border=1>
		<tr>
			<td>물품번호</td>
			<td>${purchase.purchaseProd.prodNo}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매자아이디</td>
			<td>${purchase.buyer.userId}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매방법</td>
			<td>${purchase.paymentOption}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매수량</td>
			<td>${purchase.tranNum}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매자이름</td>
			<td>${purchase.receiverName}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매자연락처</td>
			<td>${purchase.receiverPhone}</td>
			<td></td>
		</tr>
		<tr>
			<td>구매자주소</td>
			<td>${purchase.divyAddr}</td>
			<td></td>
		</tr>
			<tr>
			<td>구매요청사항</td>
			<td>${purchase.divyRequest}</td>
			<td></td>
		</tr>
		<tr>
			<td>배송희망일자</td>
			<td>${purchase.divyDate}</td>
			<td></td>
		</tr>
	</table>
	</form>
	
	</body>
</html>