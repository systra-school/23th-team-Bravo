<!-- error.jsp -->
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="business.logic.utils.CommonUtils" %>
<html>
<head lang="ja">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
<title>エラー</title>
<link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="errorHeader">
    <table>
      <tr>
          <td id="headLeft">
          </td>
          <td id="headCenter">
          
            はいっ！ざんねん！エラーです！この文言も間違っているのでコメントに書いてる文言に修正してね！
            <%--上記部分は「エラー画面」に修正しよう！ --%>
            
          </td>
          <td id="headRight">
            <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
          </td>
      </tr>
    </table>
</div>
<div id="errorBusinessBody">
  <html:form>
    <div align="center">
    <%
      out.println("例外処理JSPプログラム");
      // 発生した exception を表示する。
      out.println("<BR><BR>" + CommonUtils.HTMLEscape(exception.toString()) + "<BR><BR>");

      // トレースを表示する。
      for (StackTraceElement element : exception.getStackTrace()) {
          out.println(element + "<BR>");
      }
    %>
    </div>
  </html:form>
</div>
<div id="errorFooter"></div>
</body>

</html>