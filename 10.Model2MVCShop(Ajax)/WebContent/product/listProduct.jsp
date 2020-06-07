<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>��ǰ �����ȸ</title>
<style type="text/css">

	.hidden{
		visibility: hidden;
		display: none;
	}
	
</style>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScript �̿�  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
	   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	$(function() {
		$( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			fncGetUserList(1);
		});
		
		//$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			
			//////////////////////////// �߰� , ����� �κ� ///////////////////////////////////
			//self.location ="/user/getUser?userId="+$(this).text().trim();
			////////////////////////////////////////////////////////////////////////////////////////////
			var prodNo = $(this).text().trim().substring(0,5);
			var menu = "${param.menu}";
			
			//alert(prodNum);
			
			$.ajax( 
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							
							var displayValue = "<h3>"
									+"��ǰ�� : "+JSONData.prodName+"<br/>"
									+"��ǰ �̹��� : <img src='/images/uploadFiles/"+JSONData.fileName+"'><br/>"
									+"��ǰ ������ : "+JSONData.prodDetail+"<br/>"
									+"�������� : "+JSONData.manuDate+"<br/>"
									+"���� : "+JSONData.price+"<br/>"
									+"���� : "+JSONData.prodNum+"<br/>"
									+"������� : "+JSONData.regDate+"<br/>"
									+"</h3>";
							
							if (menu!="search") {
								
								displayValue+='<h3><a href="/product/getProduct?prodNo='
										+prodNo
										+'&menu=manage">����</a></h3>';
							} else if(menu=="search" && JSONData.prodNum!=0) {
								displayValue+='<h3><a href="/product/getProduct?prodNo='
										+prodNo
										+'&menu=search'
										+'">����ȸ</a>';
							}
							
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
				////////////////////////////////////////////////////////////////////////////////////////////
			
		});
		
		//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		//¦���� ȸ��
		$(".ct_list_pop:nth-child(4n+2)" ).css("background-color" , "whitesmoke");
	});	
	
	
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<c:if test="${param.menu=='manage'}">��ǰ����</c:if>
					<c:if test="${param.menu=='search'}">��ǰ �����ȸ</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<c:if test="${param.menu=='manage'}">
					<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				</c:if>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
			</select>
			<input 	type="text" name="searchKeyword"  value="${! empty search.searchKeyword ? search.searchKeyword : ""}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetUserList('1');">�˻�</a> -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="5">
		��ü  ${ resultPage.totalCount } �Ǽ�,	���� ${ resultPage.currentPage} ������
		</td>
		<td colspan="5" align="right">
			<c:if test="${search.orderColumn==null}">
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=prod_name&order=1">��ǰ�� ��</a>
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=price&order=1">���� ��</a>
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=purchaseCount&order=1">�Ǹŷ� ��</a>
			</c:if>
			<c:if test="${search.orderColumn!=null}">
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=prod_name&order=${param.orderColumn=='prod_name' && param.order=='1' ? "2" : "1" }">
					��ǰ��
					<c:choose>
						<c:when test="${ param.orderColumn=='prod_name' && param.order=='1'}">��</c:when>
						<c:otherwise>��</c:otherwise>
					</c:choose>
				</a>
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=price&order=${param.orderColumn=='price' && param.order=='1' ? "2" : "1" }">
				����
				<c:choose>
						<c:when test="${ param.orderColumn=='price' && param.order=='1'}">��</c:when>
						<c:otherwise>��</c:otherwise>
					</c:choose>
				</a>
				<a href="/product/listProduct?menu=${param.menu}&orderColumn=purchaseCount&order=${param.orderColumn=='purchaseCount' && param.order=='1' ? "2" : "1" }">
				�Ǹŷ�
				<c:choose>
						<c:when test="${ param.orderColumn=='purchaseCount' && param.order=='1'}">��</c:when>
						<c:otherwise>��</c:otherwise>
					</c:choose>
				</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<c:if test="${param.menu=='manage'}">
			<td class="ct_list_b" >�����</td>
			<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b">�������</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
	<c:forEach var="prod" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
				<p class="hidden">${prod.prodNo}</p>
				${prod.prodName}
			</td>
			<td></td>
			<td align="left">${prod.price}</td>
			<td></td>
			<c:if test="${param.menu=='manage'}">
				<td align="left">${prod.regDate}</td>
				<td></td>
			</c:if>	
			<td align="left">
				<c:if test="${param.menu=='manage'}">
						<a href="/purchase/listSale?prodNo=${prod.prodNo}">��۰���</a>
				</c:if>
				<c:if test="${param.menu=='search'}">
					<c:choose>
						<c:when test="${prod.prodNum==0}">
							������
						</c:when>
						<c:otherwise>
							${prod.prodNum}�� ����
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
		</tr>		
		<tr>
			<!-- //////////////////////////// �߰� , ����� �κ� /////////////////////////////
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			////////////////////////////////////////////////////////////////////////////////////////////  -->
			<td id="${prod.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<c:if test="${resultPage.currentPage <= resultPage.pageUnit }">�� ����</c:if>
			<c:if test="${resultPage.currentPage > resultPage.pageUnit }">
				<a href="javascript:fncGetProdList('${resultPage.currentPage-1}')">�� ����</a>
			</c:if>
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<a href="javascript:fncGetProdList('${i}');">${i}</a>
			</c:forEach>
			<c:if test="${resultPage.endUnitPage>=resultPage.maxPage}">���� ��</c:if>
			<c:if test="${resultPage.endUnitPage<resultPage.maxPage}">
				<a href="javascript:fncGetProdList('${resultPage.endUnitPage+1}')">���� ��</a>
			</c:if>
    	</td>
	</tr>
</table> --%>
<!--  ������ Navigator �� -->
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
</div>

</body>
</html>