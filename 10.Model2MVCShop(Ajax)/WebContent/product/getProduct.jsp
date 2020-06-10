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
		<script type="text/javascript">
			//============= "구매"  Event 연결 =============
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-primary" ).on("click" , function() {
					self.location = "/purchase/addPurchase?prod_no=${prod.prodNo}"
				});
			});	
			
			//============= "이전"  Event 연결 =============
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-default" ).on("click" , function() {
					self.location = "javascript:history.go(-1)"
				});
			});	
			
		</script>
		</head>

		<body>

			<!-- ToolBar Start /////////////////////////////////////-->
			<jsp:include page="/layout/toolbar.jsp" />
		   	<!-- ToolBar End /////////////////////////////////////-->
		   	
			<!--  화면구성 div Start /////////////////////////////////////-->
			<div class="container">
			
				<div class="page-header">
			       <h3 class=" text-info">상품상세조회</h3>
			    </div>
			    
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
					<div class="col-xs-7 col-md-4">${prod.prodName}</div>
					<div class="col-xs-1 col-md-5 text-right">${prod.purchaseCount}개 구매</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
					<div class="col-xs-8 col-md-4">${prod.prodDetail}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
					<div class="col-xs-8 col-md-4">${prod.manuDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>가  격</strong></div>
					<div class="col-xs-8 col-md-4">${prod.price}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>수  량</strong></div>
					<div class="col-xs-8 col-md-4">${prod.prodNum}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			  		<c:if test="${prod.fileName != null}">
						<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${prod.fileName}"/></div>
					</c:if>
					<c:if test="${prod.fileName == null}">
						<div class="col-xs-8 col-md-4">이미지 없음</div>
					</c:if>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-md-12 text-right ">
			  			<c:if test="${user.userId !=null }">
			  				<c:if test="${prod.prodNum != 0}">
			  					<button type="button" class="btn btn-primary">구매</button>
			  				</c:if>
			  			</c:if>
			  			<button type="button" class="btn btn-default">이전</button>
			  		</div>
				</div>
			
				<br/>
				
				
				<jsp:include page="../review/listReview.jsp"></jsp:include>
			</div>
		</body>
</html>