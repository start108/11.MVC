<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		//=====기존Code 주석 처리 후  jQuery 변경 ======//
	
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
		}

		//==>"검색" ,  userId link  Event 연결 및 처리
		 $(function() {
			 
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
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
																+"상품명 : "+JSONData.product.prodName+"<br/>"
																+"상품상세정보 : "+JSONData.product.prodDetail+"<br/>"
																+"제조일자 : "+JSONData.product.manuDate+"<br/>"
																+"가격 : "+JSONData.priceformat+"원<br/>"
																+"상품이미지 : "+JSONData.product.fileName+"<br/>"
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
			
			//==> userId LINK Event End User 에게 보일수 있도록 
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
			//==> 아래와 같이 정의한 이유는 ??
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
					${param.menu.equals("manage")? "상품관리":"상품목록조회" }
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
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
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
					<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
					<a href="javascript:fncGetProductList('1');">검색</a>
					////////////////////////////////////////////////////////////////////////////////////////////////// -->
						검색
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
		전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<!-- <td class="ct_list_b" width="150">상품명</td> -->
		<td class="ct_list_b" width="250">
			상품명<br>
			<h7>(Do you want to have a Product? Click!)</h7>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="230">상품 등록일(Product Registration Date)</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="170">배송상태(Delivery Status)</td><!-- 150 -->
		<td class="ct_line02"></td>
		<td class="ct_list_b" >비고(Note)</td>	
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
			<input type="button" value="수정">
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
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
