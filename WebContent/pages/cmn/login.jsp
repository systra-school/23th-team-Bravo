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
				<div class="loginForm">ID・パスワードを入力してください。
				<html:form action="/login" onsubmit="return validateLoginForm(this)">

					<label class="userName">ユーザー名</label>
					<html:text property="employeeId" size="16" value="" /><!-- 2024/09/09/尾崎/初期値を消去 -->
					<br />
					<label class="passWord">パスワード</label>
					<html:password property="password" size="16" redisplay="false" />
					<br />
					<br />
					<html:submit property="submit" value="ログイン" />
					<html:reset value="リセット" />
				</html:form>
				</div>
			</div>
		</div>
		<div id="footer">
			<table>
				<tr>
					<td id="footLeft"></td>
					<td id="footCenter">&copy; Copyright Miyahira,Soejima,Inoue,Ozaki SystraIT 23rd Team B.</td>
					<td id="footRight"></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>