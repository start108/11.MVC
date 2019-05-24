<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
	
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
		}

		//==>"�˻�" ,  userId link  Event ���� �� ó��
		 $(function() {
			 
			//==> �˻� Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
			 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
				fncGetList(1);
			});
			
			
			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				
				
				
				var prodNo = $(this).children('#prodNo').text().trim();
					
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
																+"��ǰ�� : "+JSONData.product.prodName+"<br/>"
																+"��ǰ������ : "+JSONData.product.prodDetail+"<br/>"
																+"�������� : "+JSONData.product.manuDate+"<br/>"
																+"���� : "+JSONData.priceformat+"��<br/>"
																+"��ǰ�̹��� : "+JSONData.product.fileName+"<br/>"
																+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
					
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).on("dblclick",function(){
				self.location = "/product/getProduct?prodNo="+$(this).children('#prodNo').text().trim()+"&menu=${param.menu}";
			});
			
			$("input[type=button]").on("click",function(){
				self.location ="/product/getProduct?prodNo="+$("#prodNo").text().trim()+"&menu=${param.menu}";
			});
			
			//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
			$("h7").css("color" , "red");
			
			$(".ct_list_pop:nth-child(n)").on("mouseenter", function(){
				$(this).css({
					"background-color":"yellow",
					"font-weight":"bolder"
				});
			})
			.on("mouseleave", function(){
				var style = {
						backgroundColor: "",//#ddd
						fontWeight:""
				};
				$(this).css(style);
			});
			//==> �Ʒ��� ���� ������ ������ ??
			//$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "yellow");//whitesmoke
		});
	
		 /* Timer 
		 function countdown( elementId, seconds ){
		   var element, endTime, hours, mins, msLeft, time;

		   function updateTimer(){
		     msLeft = endTime - (+new Date);
		     if ( msLeft < 0 ) {
		       console.log('done');
		     } else {
		       time = new Date( msLeft );
		       hours = time.getUTCHours();
		       mins = time.getUTCMinutes();
		       element.innerHTML = (hours ? hours + ':' + ('0' + mins).slice(-2) : mins) + ':' + ('0' + time.getUTCSeconds()).slice(-2);
		       setTimeout( updateTimer, time.getUTCMilliseconds());
		       // if you want this to work when you unfocus the tab and refocus or after you sleep your computer and come back, you need to bind updateTimer to a $(window).focus event^^
		     }
		   }

		   element = document.getElementById( elementId );
		   endTime = (+new Date) + 1000 * seconds;
		   updateTimer();
		 }

		 countdown('countdown', 43200);	 // second base
		 */
		</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					${param.menu.equals("manage")? "��ǰ����":"��ǰ�����ȸ" }
					</td>
					</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				</select>
				
				<input 	type="text" name="searchKeyword"  
					value="${! empty searchKeyword ? searchKeyword : ""}"  
						class="ct_input_g" style="width:200px; height:19px" >
				</td>
				
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
					<a href="javascript:fncGetProductList('1');">�˻�</a>
					////////////////////////////////////////////////////////////////////////////////////////////////// -->
						�˻�
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>	
		<td colspan="11" >	
		��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<!-- <td class="ct_list_b" width="150">��ǰ��</td> -->
		<td class="ct_list_b" width="250">
			��ǰ��<br>
			<h7>(Do you want to have a Product? Click!)</h7>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="230">��ǰ �����(Product Registration Date)</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="170">��ۻ���(Delivery Status)</td><!-- 150 -->
		<td class="ct_line02"></td>
		<td class="ct_list_b" >���(Note)</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
		
		<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
			<!-- 
			<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
			 -->
			 ${product.prodName }
			 <div id="prodNo" style="display:none;">${product.prodNo}</div> 
			</td>
			<td></td>
			<td align="left">${product.regDate}</td><!-- priceformat -->
			<td></td>
			<td align="left">${product.proTranCode}</td>
			<td></td>
			<td align="left">
			<c:if test="${param.menu eq 'manage'}">
			<input type="button" value="����">
			</c:if>
			
			
			</td>		
		</tr>
		<tr>
		<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			
    			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
