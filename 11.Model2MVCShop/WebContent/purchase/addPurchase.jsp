<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html><head><title>���� �Ϸ�</title></head>

<body>
	������ ���� ���Ű� �Ǿ����ϴ�.

	<table border=1>
		<tr>
			<td>��ǰ��ȣ</td>
			<td>${purchase.purchaseProd.prodNo}</td>
		</tr>
		<tr>
			<td>�����ھ��̵�</td>
			<td>${purchase.buyer.userId}</td>
		</tr>
		<tr>
			<td>���Ź��</td>
			<td><c:if test="${purchase.paymentOption==100}">���ݱ���</c:if>
				<c:if test="${purchase.paymentOption==101}">�ſ뱸��</c:if></td>
		</tr>
		<tr>
			<td>�������̸�</td>
			<td>${purchase.receiverName}</td>
		</tr>
		<tr>
			<td>�����ڿ���ó</td>
			<td>${purchase.receiverPhone}</td>
		</tr>
		<tr>
			<td>�������ּ�</td>
			<td>${purchase.divyAddr}</td>
		</tr>
			<tr>
			<td>���ſ�û����</td>
			<td>${purchase.divyRequest}</td>
		</tr>
		<tr>
			<td>����������</td>
			<td>${purchase.divyDate}</td>
		</tr>
	</table>
</body>

</html>