<!-- menu.jsp -->
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<bean:define id="employeeName" name="<%=RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO %>" 
		scope="session" type="java.lang.String"  property="employeeName" />
<html lang="ja">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
	<link rel="icon" href="/kikin-for-Struts-bug/pages/img/favicon.ico">
    <html:javascript formName="loginForm" />
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>

    <title>メニュー画面</title>
    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table class="full-width">
          <tr>
            <td id="headLeft">
              　
            </td>
            <td id="headCenter">
            <logic:equal name="<%=RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO %>"
                         property="authorityId"
                         value="<%=CommonConstant.Authority.ADMIN.getId() %>">
                　　管理者：
            </logic:equal>

            <logic:equal name="<%=RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO %>"
                         property="authorityId"
                         value="<%=CommonConstant.Authority.USER.getId() %>">
                　　一般社員：
            </logic:equal>
            
            		    <%-- 追加機能 ログイン中の名前表示 --%>
            <bean:write name="employeeName"/> 様がログイン！

            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="businessBody">
        <logic:equal name="<%=RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO %>"
                     property="authorityId"
                     value="<%=CommonConstant.Authority.ADMIN.getId() %>">
          <div  style="margin-left:7.5%;"><!-- 2024/09/07/尾崎/7.5%に変更 -->
          <div class="menuBlock">
            <html:form action="/monthlyShiftCheckInit">
              <input type="submit" value="月別シフト確認" class="bigButton" />
            </html:form>
            <html:form action="/dailyShiftInit">
              <input type="submit" value="日別シフト確認" class="bigButton" />
            </html:form>

          </div>

          <div class="menuBlock">
            <html:form action="/workRecordCheckInit">
              <input type="submit" value="勤務実績確認" class="bigButton" />
            </html:form>
            <html:form action="/workRecordInputInit">
              <input type="submit" value="勤務実績入力" class="bigButton" />
            </html:form>
          </div>

          <div class="menuBlock">
            <html:form action="/workDateRequestCheckInit">
              <input type="submit" value="出勤希望日確認" class="bigButton" />
            </html:form>
            <html:form action="/monthlyShiftInputInit">
              <input type="submit" value="月別シフト入力" class="bigButton" />
            </html:form>
          </div>

          <div class="menuBlock">
            <html:form action="/employeeMstMnt">
              <input type="submit" value="社員マスタメンテナンス" class="bigButton" />
            </html:form>
            
            <html:form action="/shiftMstMnt">
              <input type="submit" value="シフトマスタメンテナンス" class="bigButton" />
            </html:form>
            <html:form action="/baseShiftInit"><!-- 2024/09/07/尾崎/場所を移動 -->
              <input type="submit" value="基本シフト登録" class="bigButton" />
            </html:form>
           <!-- 出勤希望日入力を消去 -->
            
            
          </div>
          </div>
        </logic:equal>

        <logic:equal name="<%=RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO %>"
                     property="authorityId"
                     value="<%=CommonConstant.Authority.USER.getId() %>">
          
          <div  style="margin-left:7.5%;">
          <div class="menuBlock">
            <html:form action="/monthlyShiftCheckInit">
              <input type="submit" value="月別シフト確認" class="bigButton" />
            </html:form>
            <html:form action="/dailyShiftInit">
              <input type="submit" value="日別シフト確認" class="bigButton" />
            </html:form>
          </div>
          
          <div class="menuBlock">
            <html:form action="/workRecordInputInit">
              <input type="submit" value="勤務実績入力" class="bigButton" />
            </html:form>
          </div>
		  
		  
          <div class="menuBlock">
            <html:form action="/workDateRequestInputInit">
              <input type="submit" value="出勤希望日入力" class="bigButton" />
            </html:form>
          </div>

          <div class="menuBlock">
            <html:form action="/baseShiftCheckInit">
              <input type="submit" value="基本シフト確認" class="bigButton" />
            </html:form>
          </div>
          
          <%-- 20240902 副島 シフトマスタメンテナンスボタンを外す --%>
           <%-- <html:form action="/shiftMstMnt">
              <input type="submit" value="シフトマスタメンテナンス" class="bigButton" />
            </html:form> --%>
          
          </div>
           </logic:equal>
        </div>
        
                  <div class="warning" style="margin-top:-320px;">
        	<h2>お知らせ</h2>
        	<ul>
        		<li>2024/09/17：勤怠管理システムをローンチ</li>
        		<li>2024/09/13：勤務実績確認、勤務実績入力に合計実労働時間を表示</li>
        		<li>2024/09/11：管理者、一般のメニュー画面にログインユーザー名を表示</li>
        		<li>2024/09/09：メンテナンス、バグ修正、テスト確認</li>
        	</ul>
        </div>
        
               
	             <div id="footer">
	        <table>
	          <tr>
	            <td id="footLeft">
	              　
	            </td>
	            
	            <td id="footCenter">
	              <p class="copyRight">&copy; Copyright Miyahira,Soejima,Inoue,Ozaki SystraIT 23rd Team B.</p>
	            </td>
	            <td id="footRight">
	              　
	            </td>
	          </tr>
	        </table>
	      </div>
      </div>
      

  </body>
</html>