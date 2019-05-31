<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
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
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
		}
		
		
		
		
		//============= userId 에 회원정보보기  Event  처리(Click) =============	
		 $(function() {
		
		$( "button.btn.btn-info:contains('최신 상품')" ).on("click" , function() {
			$("#currentRegDate").val("0");
			fncGetList("1");
		});
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)" ).on("click",function(){//dblclick
				self.location = "/product/getProduct?prodNo="+$(this).children('#prodNo').text().trim()+"&menu=${param.search}";
			});
			
			$("input[type=button]").on("click",function(){
				self.location ="/product/getProduct?prodNo="+$("#prodNo").text().trim()+"&menu=${param.menu}";
			});
						
			//==> userId LINK Event End User 에게 보일수 있도록 
			$( "td:nth-child(n)" ).css("color" , "black");//.ct_list_pop:nth-child(n)
			$("h7").css("color" , "red");
			
			$("tr:nth-child(n)").on("mouseenter", function(){
				$(this).css({
					"background-color":"#808080",
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
		
		
		//============= userId 에 회원정보보기  Event  처리 (double Click)=============
		 $(function() {
			 
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("span[class='glyphicon glyphicon-search']").on("click" , function() {

				var prodNo = $(this).attr("id").trim();
				
				
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

									var displayValue = "<h6>"//3
															+"상품명 : "+JSONData.product.prodName+"<br/>"
															+"상품상세정보 : "+JSONData.product.prodDetail+"<br/>"
															+"제조일자 : "+JSONData.product.manuDate+"<br/>"
															+"가격 : "+JSONData.priceformat+"원<br/>"
															+"상품이미지 : "+JSONData.product.fileName+"<br/>"
															+"</h6>";
									$("h6").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}
						});
				
						////////////////////////////////////////////////////////////////////////////////////////////
					
			});
			
			$("a[href='#']:contains('가격 전체')").on("click",function(){
				
				$("#priceDetail").val("0");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('10만원 이하')").on("click",function(){
				
				$("#priceDetail").val("1");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('10만원~20만원')").on("click",function(){
				
				$("#priceDetail").val("2");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('20만원~30만원')").on("click",function(){
				
				$("#priceDetail").val("3");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('30만원~40만원')").on("click",function(){
	
				$("#priceDetail").val("4");
				fncGetList("1");
	
			});

			$("a[href='#']:contains('50만원 이상')").on("click",function(){
	
				$("#priceDetail").val("5");
				fncGetList("1");
	
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
	
		<div class="page-header text-info">
	       <h3>${param.menu.equals("manage")? "상품관리":"상품목록조회" }</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <!-- <button type="button" class="btn btn-default">높은 가격순</button>
		    <button type="button" class="btn btn-default">낮은 가격순</button>
		    <button type="button" class="btn btn-default">수량 조회</button> -->
		    
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    	
			    	      <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="btn btn-default" aria-expanded="false">
	        				<span class="btn btn-default">맞춤 가격</span>
	        			
	                     </a>
	                     <ul class="dropdown-menu">
	                     	 <li><a href="#">가격 전체</a></li>
	                         <li><a href="#">10만원 이하</a></li>   
	                       	 <li><a href="#">20만원~30만원</a></li>
	                       	 <li><a href="#">30만원~40만원</a></li>
	                       	 <li><a href="#">40만원~50만원</a></li>
	                       	 <li><a href="#">50만원 이상</a></li>
	          
	                     </ul>
	            	
			    	<button type="button" class="btn btn-info">최신 상품</button>
			    		
			    	
			    	
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				 
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  <input type="hidden" id="priceDetail" name="priceDetail" value="${! empty search.priceDetail ? search.priceDetail : '' }"/>
				  <input type="hidden" id="currentRegDate" name="currentRegDate" value="${! empty search.currentRegDate ? search.currentRegDate : '' }"/>
				  
				  <!-- Field의 name과 폼 태그 안 input name을 같이하면 request 될 때 value를 바인딩 해서 보내줌 -->
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">상품등록일</th>
            <th align="left">배송상태</th>
            <th align="left">간략정보</th>
            <th align="left">비고</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 상품정보 확인"> ${product.prodName}
			  <div id="prodNo" style="display:none;">${product.prodNo}</div></td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">${product.proTranCode}</td>
			  <td align="left">
			  <span class="glyphicon glyphicon-search" id="${product.prodNo}"></span>
			  </td> 
			<td></td>
			<td align="left">
			<c:if test="${param.menu eq 'manage'}">
			<input type="button" class="btn btn-warning" value="수정">
			</c:if>
			</td>
			</tr>
          <tr>
		</tr>
          </c:forEach>
			<!--<c:choose>
			<c:when test="${product.proTranCode eq '1  ' }">배송하기</c:when>
			<c:when test="${product.proTranCode eq '2  ' }">배송중</c:when>
			<c:when test="${product.proTranCode eq '3  ' }">물건도착</c:when>
			<c:when test="${product.proTranCode eq '4  ' }">판매완료</c:when>
			</c:choose>-->
          

        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>