<!-- monthlyShiftCheck.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mth.MonthlyShiftCheckForm"%>
<%
/**
 * ファイル名：monthlyShiftCheck.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 * 2.0  2024/05/15 Sho.Kiyota
 */
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<bean:size id="dateBeanListSize" name="monthlyShiftCheckForm" property="dateBeanList"/>
<bean:size id="listSize" name="monthlyShiftCheckForm" property="monthlyShiftCheckBeanList"/>
<bean:define id="showLength" value="16" type="java.lang.String"/>
<bean:define id="offset" name="monthlyShiftCheckForm" property="offset" />
<bean:define id="color" value="" type="java.lang.String"/>
<bean:define id="countPage" name="monthlyShiftCheckForm" property="countPage" type="java.lang.Integer"/>
<bean:define id="maxPage" name="monthlyShiftCheckForm" property="maxPage" type="java.lang.Integer"/>
<bean:define id="symbol" value="" type="java.lang.String"/>

<%
final int heightSize = 22;

int intShowLength = Integer.parseInt(showLength);

// 表示しているリストサイズの調整
if (countPage.intValue() == maxPage.intValue()) {
    listSize = listSize % intShowLength;
}

if (listSize > intShowLength) {
    listSize = intShowLength;
}

%>
<html lang="ja">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
	<link rel="icon" href="/kikin-for-Struts-bug/pages/img/favicon.ico">
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>
    <script type="text/javascript">

    /**
     * 印刷
     */
    function submitPrint(action) {
        document.forms[0].action = "/kikin-for-Struts-bug/monthlyShiftCheckPrint.do";
        document.forms[0].submit();
    }
    <!-- 2024/09/02/宮平/functionの書き換え -->
    
    /**
     * 検索
     */
    function submitSearch(action) {
        document.forms[0].action = "/kikin-for-Struts-bug/monthlyShiftCheckSearch.do";
        document.forms[0].submit();
    }
    <!-- 2024/09/02/宮平/functionの書き換え -->
    
    /**
     * サブウィンドウを開く
     */
    function openWindow(){
        window.open("/kikin-for-Struts-bug/shiftPattern.do?param=", "windowBPopup", "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=520px, height=650px");
    }

    </script>
    <title>月別シフト確認画面</title>

    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table class="full-width">
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smallButton"  onclick="doSubmit('/kikin-for-strus-bug/menu.do')" />
            </td>
            <td id="headCenter">
              月別シフト確認
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="businessBody" style="overflow: hidden;">
        <html:form action="/workDateRequestCheckInit" >
          <div>
            <div id="resize" class="full-width" style="margin-left:9%;">
              <div style="float: left; width: 804px; text-align: left; margin-left:13%;">
	              表示年月：
	              <bean:define id="sessionYearMonth" name="monthlyShiftCheckForm" property="yearMonth" type="String"/>
	              <html:select property="yearMonth" name="monthlyShiftCheckForm"  onchange="submitSearch('/kikin-for-Struts-bug/monthlyShiftCheckSearch.do')">
	              <!-- 2024/09/02/宮平/submitSearch()をsubmitSearch('/kikin-for-Struts-bug/monthlyShiftCheckSearch.do')に書き換え -->
	              <html:optionsCollection name="monthlyShiftCheckForm"
	                                      property="yearMonthCmbMap"
	                                      value="key"
	                                      label="value"/>
	              </html:select>
              </div>
              <div style="float: left; width: 244px; text-align: left;">
	              【<html:link href="/kikin-for-Struts-bug/monthlyShiftCheckPage.do?paging=back">前へ</html:link> /
	              <html:link href="/kikin-for-Struts-bug/monthlyShiftCheckPage.do?paging=next">次へ</html:link>】<!-- 2024/09/06/尾崎/推移先変更 -->
	              <bean:write name="monthlyShiftCheckForm" property="countPage"/>/
	              <bean:write name="monthlyShiftCheckForm" property="maxPage"/>
              </div>
            <table class="widthTable" >
              <tr>
                <td width="150px" valign="top">
                  <table class="tableHeader">
                    <tr height="<%=heightSize %>px">
                      <td width="150px" align="center">
                        &nbsp;
                      </td>
                    </tr>
                    <tr height="<%=heightSize %>px">
                      <td width="150px" align="center">
                      社員名
                      </td>
                    </tr>
                    <logic:iterate offset="offset" length="<%=showLength %>"  id="monthlyShiftCheckBeanList" name="monthlyShiftCheckForm" property="monthlyShiftCheckBeanList">
                      <tr  class="tableBody"  height="<%=heightSize %>px">
                        <td width="150px" align="center">
                          <bean:write property="employeeName" name="monthlyShiftCheckBeanList"/><br>
                        </td>
                      </tr>
                    </logic:iterate>
                  </table>
                </td>
                <td valign="top">
                  <div style="overflow-x: auto;overflow-y: hidden; width:985px;height: auto; text-align:center;">
                    <table class="tableHeader">
                      <tr height="<%=heightSize %>px">
                      <% for (int i = 1; i <= dateBeanListSize; i++) { %>
                        <td width="40px" align="center">
                        <%= i %>
                        </td>
                          <% } %>
                      </tr>

                      <tr height="<%=heightSize %>px">
                      <logic:iterate id="dateBeanList" name="monthlyShiftCheckForm" property="dateBeanList">
                      	 <bean:define id="weekDay" name="dateBeanList" property="weekDay"/>
						 <bean:define id="publicHolidayFlg" name="dateBeanList" property="publicHolidayFlg"/>
						  
		                 <%
		                 if (DayOfWeek.SATURDAY.getWeekdayShort().equals(weekDay)) {
		                     color = "fontBlue";
		                 } else if (DayOfWeek.SUNDAY.getWeekdayShort().equals(weekDay) || ((boolean)publicHolidayFlg)) {
		                     color = "fontRed";
		                 } else {
		                     color = "fontBlack";
		                 }
		                 %>
                          <td width="40px" align="center" class="<%=color %>">
                            <bean:write property="weekDay" name="dateBeanList"/><br>
                          </td>
                      </logic:iterate>
                      </tr>
                      <logic:iterate offset="offset"  length="<%=showLength %>" id="monthlyShiftCheckBeanList" name="monthlyShiftCheckForm" property="monthlyShiftCheckBeanList">
                        <tr class="tableBody">                                                
                        <% for(int i = 1; i <= dateBeanListSize; i++) {%>
                          <td width="40px" align="center" valign="middle" class="tableBody">  
                          <%if(i<10){
                              symbol = "symbol0" + i;
                              }else{
                              symbol = "symbol" + i;
                              } %>
                             <bean:write name="monthlyShiftCheckBeanList" property="<%=symbol %>"  /><br>
                          </td>
                          <% } %>                                                         
                       </tr>
                      </logic:iterate>
                    </table>
                  </div>
                </td>
              </tr>
            </table>
            </div>
          </div>
        </html:form>
      </div>
      <div id="footer">
        <table>
          <tr>
            <td id="footLeft">
              <input value="凡例表示" type="button" class="longButton"  onclick="openWindow()" /><!-- 2024/08/26/尾崎Windowのスペルミス -->
              <input value="印刷" type="button" class="smallButton"  onclick="submitPrint('/kikin-for-Struts-bug/monthlyShiftCheckPrint.do')" /><!-- 2024/08/26/尾崎Printのスペルミス -->
	          <!-- 2024/09/02/宮平/submitSearch()をsubmitSearch('/kikin-for-Struts-bug/monthlyShiftCheckPrint.do')に書き換え -->
            </td>
            <td id="footCenter" style="text-align: center;">
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