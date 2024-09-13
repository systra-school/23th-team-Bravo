<!-- workDateRequestInput.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.shk.WorkDateRequestInputForm"%>

<%
/**
 * ファイル名：workDateRequestInput.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 * 2.0  2024/04/25 Atsuko.Yoshioka
 */
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="constant.RequestSessionNameConstant"%>
<%@page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<bean:size id="dateBeanListSize" name="workDateRequestInputForm"  property="dateBeanList"/>
<bean:define id="color" value="" type="java.lang.String"/>
<bean:define id="showLength" value= "userId" type="java.lang.String"/>
<bean:define id="shiftId" value="" type="java.lang.String"/>

<html lang="ja">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>
    <script type="text/javascript" >
	/**
     * 登録
     */
    function submitRegister() {
        // サブミット
        //20240902 副島 登録ボタンをサブミットできるようにする
    	//doSubmit('/kikin-for-Struts-bug/workDateRequestInputRegister.do');
        document.forms[0].submit();
    }
    /**
     * 検索
     */    
    function submitSearch(action) {
        document.forms[0].action = "/kikin-for-Struts-bug/workDateRequestInputSearch.do";
        document.forms[0].submit();
    }
    <!-- 2024/09/02/宮平/functionの書き換え -->
    /**
     * サブウィンドウを開く
     */
    function openWindow(){
    	<!-- 20240828 副島 サブウィンドウの展開先がtomcatになってたのでkikin-for-Struts-bugに修正 -->
        <!--window.open("https://tomcat.apache.org/?param=", "windowBPopup", "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=520px, height=650px");-->
        window.open("/kikin-for-Struts-bug/shiftPattern.do?param=", "windowBPopup", "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=520px, height=650px");

    }
    function openSearch(){
   		<!-- 20240826 副島 workDateCheckSubInitをworkDateRequestCheckInitに修正 -->
    	<!--window.open("/kikin-for-Struts-bug/workDateCheckSubInit.do", "searchPopup", "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=1000px, height=600px")-->
    	window.open("/kikin-for-Struts-bug/workDateRequestCheckInit.do", "searchPopup", "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=1000px, height=600px")
    }
    
    var str = user_Id;
    var result = str.substring(2,5);
    var userId = result - 0;
    
    </script>
    <title>出勤希望入力画面</title>
    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%String user_id = (String)session.getAttribute("session_cmn_login_user_id");  %>
	
	<div id = "wrapper">
		<div id = "header">
			<table class="full-width">
          		<tr>
            		<td id="headLeft">
              			<input value="戻る" type="button" class="smallButton"  onclick="doSubmit('/kikin-for-strus-bug/menu.do')" />
            		</td>
            		<td id="headCenter">
              			出勤希望入力
            		</td>
            		<td id="headRight">
              			<input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
            		</td>
          		</tr>
        	</table>
      	</div>
      	<div id="businessBody" style="overflow: hidden; margin-top:24px;">
      	<%-- 20240828 副島 m<div style="margin-right:20%;">argin-leftをmargin-rightに変更--%>
        <div style="margin: 0 auto; width: 80%;">
        
          <html:form action="/workDateRequestInputRegister" ><!-- 2024/09/06/尾崎/登録処理の修正 -->
            表示年月：
            <html:select name="workDateRequestInputForm" property="yearMonth" onchange="submitSearch('/kikin-for-Struts-bug/workDateRequestInputSearch.do')">
            <!-- 2024/09/02/宮平/submitSearch()をsubmitSearch('/kikin-for-Struts-bug/workDateRequestInputSearch.do')に書き換え -->
            	<html:optionsCollection name="workDateRequestInputForm"
                                    property="yearMonthCmbMap"
                                    value="key"
                                    label="value"/>
            </html:select>
            <div>
              <table class="widthTable">
                <tr>
                  <td width="150px" valign="top">
                    <table class="tableBody">
                      <tr class="tableHeader">
                        <td width="150px" align="center">
                          &nbsp;
                        </td>
                      </tr>
                      <tr class="tableHeader">
                        <td width="150px" nowrap = "nowrap" align="center">
                        社員名
                        </td>
                        </tr>
                      <logic:iterate length="<%=showLength %>" id="workDateRequestInputBeanList" name="workDateRequestInputForm" property="workDateRequestInputBeanList">
                       <logic:equal name="workDateRequestInputBeanList" property = "employeeId"  value="<%=user_id%>">
                      <tr class="tableBody">
                          <td width="150px" align="center" class="tableBody">
                            <bean:write property="employeeName" name="workDateRequestInputBeanList"/><br>
                          </td>
                        </tr>
                        </logic:equal>
                       </logic:iterate>
                    </table>
                  </td>
                  <td>
                    <div style="overflow-x: auto;overflow-y: hidden; width:1067px;height: 100%; text-align:center;">
                      <table class="tableBody">
                        <tr class="tableHeader">
 						  <% for(int i = 1;i <= dateBeanListSize;i++ ) { %>
                        	 <td width="40px" align="center" valign="middle">
                          		<%= i %> 
                          	 </td>
                      	  <% } %>
                        </tr>
                        <tr class="tableHeader">
                          <logic:iterate id="dateBeanList" name="workDateRequestInputForm" property="dateBeanList">
                          <bean:define id="weekDayEnum" name="dateBeanList" property="weekDayEnum"/>
                          <bean:define id="publicHolidayFlg" name="dateBeanList" property="publicHolidayFlg"/>
                              <%
                              if (DayOfWeek.SATURDAY.equals(weekDayEnum)) {
                                  color = "fontBlue";
                              } else if (DayOfWeek.SUNDAY.equals(weekDayEnum) || ((boolean)publicHolidayFlg)) {
                                  color = "fontRed";
                              } else {
                                  color = "fontBlack";
                              }
                              %>

                              <td width="40px" align="center" valign="middle" class="<%=color %>">
                                <bean:write property="weekDay" name="dateBeanList"/>
                              </td>
                          </logic:iterate>
                        </tr>
                        <logic:iterate offset="offset"  length="<%=showLength %>" id="workDateRequestInputBeanList" name="workDateRequestInputForm" property="workDateRequestInputBeanList">
                         <logic:equal name="workDateRequestInputBeanList" property = "employeeId"  value="<%=user_id%>">
                         <tr class="tableBody">
                         	<% for(int i = 1; i <= dateBeanListSize; i++) {%>
                            <td width="40px" align="center" valign="middle">
                            	<%if(i < 10){
                            			shiftId = "shiftId0" + i;
    							}else{
    									shiftId = "shiftId" + i;
    							} %>
                            	<html:select property="<%=shiftId %>" name="workDateRequestInputBeanList" indexed="true">
                            		<html:optionsCollection name="workDateRequestInputForm" property="shiftCmbMap" value="key" label="value"/>
                            	</html:select>
                          	</td>
                          	<% } %>
                          </tr>
                           </logic:equal>
                        </logic:iterate>
                      </table>
                    </div>
                  </td>
                </tr>
              </table>
            </div>
		 </html:form>
		 
        </div>
        <div id="wrapper" style="margin-top:50px;">
      <!-- <div id="header">
        <table class="full-width">
          <tr>
            <td id="headLeft">
            </td>
            <td id="headCenter">
              シフト凡例
            </td>
            <td id="headRight">
            </td>
          </tr>
        </table>
      </div>-->
      <div id="businessBody"style="overflow: hidden;">
        <html:form>
          <%-- 凡例 --%>
          <div id="pattern" style="width:470px; margin: 0 auto;">
            <div>
              <table class="tableHeader">
                <tr>
                  <td width="100px" align="center">
                    シフト名
                  </td>
                  <td width="150px" align="center">
                    シンボル
                  </td>
                  <td width="150px" align="center">
                    時間
                  </td>
                  <td width="50px" align="center">
                    休憩
                  </td>
                </tr>
              </table>
            </div>
            <div style="height:450px;overflow:auto">
              <table class="tableBody">
                <logic:iterate id="shiftPatternBeanList" name="workDateRequestInputForm"  property="shiftPatternBeanList" indexId="idx">
                  <tr>
                    <td width="100px" align="center">
                      <bean:write property="shiftName" name="shiftPatternBeanList"/>
                    </td>
                    <td width="150px" align="center">
                      <bean:write property="symbol" name="shiftPatternBeanList"/>
                    </td>
                    <td width="150px" align="center">
                      <bean:write property="timeZone" name="shiftPatternBeanList" filter="false"/>
                    </td>
                    <td width="50px" align="center">
                      <bean:write property="breakTime" name="shiftPatternBeanList"/>
                    </td>
                  </tr>
                </logic:iterate>
              </table>
            </div>
          </div>
        </html:form>
      </div>
      
      
       </div>
	
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
    	        <input value="出勤希望日参照" type="button" class="longButton"  onclick="openSearch()" />
            	<input value="登録" type="button" class="smallButton"  onclick="submitRegister()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
    
  </body>
</html>