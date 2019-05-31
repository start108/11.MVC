<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
		}
		
		
		
		
		//============= userId �� ȸ����������  Event  ó��(Click) =============	
		 $(function() {
		
		$( "button.btn.btn-info:contains('�ֽ� ��ǰ')" ).on("click" , function() {
			$("#currentRegDate").val("0");
			fncGetList("1");
		});
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)" ).on("click",function(){//dblclick
				self.location = "/product/getProduct?prodNo="+$(this).children('#prodNo').text().trim()+"&menu=${param.search}";
			});
			
			$("input[type=button]").on("click",function(){
				self.location ="/product/getProduct?prodNo="+$("#prodNo").text().trim()+"&menu=${param.menu}";
			});
						
			//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
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
			//==> �Ʒ��� ���� ������ ������ ??
			//$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "yellow");//whitesmoke
		});	
		
		
		//============= userId �� ȸ����������  Event  ó�� (double Click)=============
		 $(function() {
			 
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
															+"��ǰ�� : "+JSONData.product.prodName+"<br/>"
															+"��ǰ������ : "+JSONData.product.prodDetail+"<br/>"
															+"�������� : "+JSONData.product.manuDate+"<br/>"
															+"���� : "+JSONData.priceformat+"��<br/>"
															+"��ǰ�̹��� : "+JSONData.product.fileName+"<br/>"
															+"</h6>";
									$("h6").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}
						});
				
						////////////////////////////////////////////////////////////////////////////////////////////
					
			});
			
			$("a[href='#']:contains('���� ��ü')").on("click",function(){
				
				$("#priceDetail").val("0");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('10���� ����')").on("click",function(){
				
				$("#priceDetail").val("1");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('10����~20����')").on("click",function(){
				
				$("#priceDetail").val("2");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('20����~30����')").on("click",function(){
				
				$("#priceDetail").val("3");
				fncGetList("1");
				
			});
			
			$("a[href='#']:contains('30����~40����')").on("click",function(){
	
				$("#priceDetail").val("4");
				fncGetList("1");
	
			});

			$("a[href='#']:contains('50���� �̻�')").on("click",function(){
	
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${param.menu.equals("manage")? "��ǰ����":"��ǰ�����ȸ" }</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <!-- <button type="button" class="btn btn-default">���� ���ݼ�</button>
		    <button type="button" class="btn btn-default">���� ���ݼ�</button>
		    <button type="button" class="btn btn-default">���� ��ȸ</button> -->
		    
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    	
			    	      <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="btn btn-default" aria-expanded="false">
	        				<span class="btn btn-default">���� ����</span>
	        			
	                     </a>
	                     <ul class="dropdown-menu">
	                     	 <li><a href="#">���� ��ü</a></li>
	                         <li><a href="#">10���� ����</a></li>   
	                       	 <li><a href="#">20����~30����</a></li>
	                       	 <li><a href="#">30����~40����</a></li>
	                       	 <li><a href="#">40����~50����</a></li>
	                       	 <li><a href="#">50���� �̻�</a></li>
	          
	                     </ul>
	            	
			    	<button type="button" class="btn btn-info">�ֽ� ��ǰ</button>
			    		
			    	
			    	
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				 
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  <input type="hidden" id="priceDetail" name="priceDetail" value="${! empty search.priceDetail ? search.priceDetail : '' }"/>
				  <input type="hidden" id="currentRegDate" name="currentRegDate" value="${! empty search.currentRegDate ? search.currentRegDate : '' }"/>
				  
				  <!-- Field�� name�� �� �±� �� input name�� �����ϸ� request �� �� value�� ���ε� �ؼ� ������ -->
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">��ǰ�����</th>
            <th align="left">��ۻ���</th>
            <th align="left">��������</th>
            <th align="left">���</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��"> ${product.prodName}
			  <div id="prodNo" style="display:none;">${product.prodNo}</div></td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">${product.proTranCode}</td>
			  <td align="left">
			  <span class="glyphicon glyphicon-search" id="${product.prodNo}"></span>
			  </td> 
			<td></td>
			<td align="left">
			<c:if test="${param.menu eq 'manage'}">
			<input type="button" class="btn btn-warning" value="����">
			</c:if>
			</td>
			</tr>
          <tr>
		</tr>
          </c:forEach>
			<!--<c:choose>
			<c:when test="${product.proTranCode eq '1  ' }">����ϱ�</c:when>
			<c:when test="${product.proTranCode eq '2  ' }">�����</c:when>
			<c:when test="${product.proTranCode eq '3  ' }">���ǵ���</c:when>
			<c:when test="${product.proTranCode eq '4  ' }">�ǸſϷ�</c:when>
			</c:choose>-->
          

        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>