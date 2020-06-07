<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>상품평 조회</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		<style type="text/css">

			.hidden{
				visibility: hidden;
				display: none;
			}
			
		</style>
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	
	</head>
	<body bgcolor="#ffffff" text="#000000">
		<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td width="15" height="37">
					<img src="/images/ct_ttl_img01.gif" width="15" height="37">
				</td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">
							상품평
							</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif" width="12" height="37">
				</td>
			</tr>
		</table>
		
		<form name="detailform">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td class="ct_list_b" width="15%">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="60%">제목</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="25%">작성자</td>
				<td class="ct_line02"></td>	
			</tr>
			<tr>
				<td colspan="6" bgcolor="808285" height="1"></td>
			</tr>
			<c:set var="i" value="0"/>
			<c:forEach var="review" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${ i }</td>
					<td></td>
					<td align="left">
						<p class="hidden">${review.reviewNo}</p>
						${review.reviewName}
					</td>
					<td></td>
					<td align="left">${review.reviewBuyer.userName}</td>
					<td></td>
				</tr>		
				<%-- <tr>
					<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
					aJax displyaValue
					////////////////////////////////////////////////////////////////////////////////////////////  -->
					<td id="${review.reviewNo}" colspan="6" bgcolor="D6D7D6" height="1"></td>
				</tr> --%>
			</c:forEach>
		</table>
		<!-- PageNavigation Start... -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
			<tr>
				<td align="center">
				   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			
					<jsp:include page="../common/pageNavigator.jsp"/>	
					
		    	</td>
			</tr>
		</table>
		<!-- PageNavigation End... -->
		</form>
		
	</body>
</html>