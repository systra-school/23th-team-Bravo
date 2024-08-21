<!-- login.jsp -->
<%@page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>


<html lang="ja">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>
<html:javascript formName="loginForm" />
<title>ログイン画面Login</title>
<link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />

</head>
<body>

	<%
  if(session.getAttribute("error")!=null){
	  
    %>
	<script type="text/javascript">
  	var msg = getMessageCodeOnly('E-MSG-000002');
    alert(msg);
  </script>
	<%
  session.setAttribute("error", null);}%>

	<div id="wrapper">
		<div id="header">
			<table class="full-width">
				<tr>
					<td id="headLeft"></td>
					<td id="headCenter">ログイン</td>
					<td id="headRight"></td>
				</tr>
			</table>
		</div>


		<div id="businessBody">
			<div align="center">
				<div>ID・パスワードを入力してください。</div>
				<html:form action="/login" onsubmit="return validateLoginForm(this)">

					<html:text property="employeeId" size="16" value="sh0001" />
					<br />
					<html:password property="password" size="16" redisplay="false"
						value="sh0002" />
					<br />
					<br />
					<html:submit property="submit" value="ログイン" />
					<html:reset value="リセット" />
				</html:form>
			</div>
		</div>
		<div id="footer">
			<table>
				<tr>
					<td id="footLeft"></td>
					<td id="footCenter"></td>
					<td id="footRight"></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>