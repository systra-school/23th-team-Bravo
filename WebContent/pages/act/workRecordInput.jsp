<!-- workRecordInput.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%
/**
 * ファイル名：workRecordInput.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<bean:define id="color" value="" type="java.lang.String"/>
<bean:size id="workRecordListSize" name="workRecordInputForm"  property="workRecordInputList"/>
<bean:size id="dateBeanListSize" name="workRecordInputForm"  property="dateBeanList"/>
<html lang="ja">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
	<link rel="icon" href="/kikin-for-Struts-bug/pages/img/favicon.ico">
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>
    <script type="text/javascript" >
    
	/**
	 * 登録へ
	 */
	    function register() {

	        // 一覧のサイズ
	        var listSize = <%= workRecordListSize %>;

	        // 開始時間エラーメッセージ
	        var startTimeErrMsg = '';
	        // 終了時間エラーメッセージ
	        var endTimeErrMsg = '';
	        // 休憩時間エラーメッセージ
	        var breakTimeErrMsg = '';
	        // From - To エラーメッセージ
	        var fromToErrMsg = '';
	        // エラーメッセージ
	        var errorMsg = '';


	        with(document.forms[0].elements) {

	            for (var i = 0; i < listSize; i++) {

	                // 開始時間を取得する。
	                var startTime = namedItem('workRecordInputList['+ i +'].startTime').value;
	                // 終了時間を取得する。
	                var endTime = namedItem('workRecordInputList['+ i +'].endTime').value;
	                // 休憩時間を取得する。
	                var breakTime = namedItem('workRecordInputList['+ i +'].breakTime').value;

	                // 背景色をクリアする
	                namedItem('workRecordInputList['+ i +'].startTime').style.backgroundColor = 'white';
	                namedItem('workRecordInputList['+ i +'].endTime').style.backgroundColor = 'white';
	                namedItem('workRecordInputList['+ i +'].breakTime').style.backgroundColor = 'white';

	                if(startTime == "" && endTime == "" && breakTime == ""){
	                	continue;
	                }
	                
	                // 時間チェック
	                if (!startTimeErrMsg) {
	                    if (!checkTime(startTime)) {
	                        var strArr = ['開始時間'];
	                        startTimeErrMsg = getMessage('E-MSG-000004', strArr);
	                        namedItem('workRecordInputList['+ i +'].startTime').style.backgroundColor = 'red';
	                    }
	                }
	                if (!endTimeErrMsg) {
	                    if (!checkTime(endTime)) {
	                        var strArr = ['終了時間'];
	                        endTimeErrMsg = getMessage('E-MSG-000004', strArr);
	                        namedItem('workRecordInputList['+ i +'].endTime').style.backgroundColor = 'red';
	                    }
	                }
	                if (!breakTimeErrMsg) {
	                    if (!checkTime(breakTime)) {
	                        var strArr = ['休憩時間'];
	                        breakTimeErrMsg = getMessage('E-MSG-000004', strArr);
	                        namedItem('workRecordInputList['+ i +'].breakTime').style.backgroundColor = 'red';
	                    }
	                }

	                // from - to のチェック
	                if (!checkTimeCompare(startTime, endTime)) {
	                  if (checkTime(startTime) && checkTime(endTime)) {
	                      fromToErrMsg = getMessageCodeOnly('E-MSG-000005');
	                      namedItem('workRecordInputList['+ i +'].startTime').style.backgroundColor = 'red';
	                      namedItem('workRecordInputList['+ i +'].endTime').style.backgroundColor = 'red';
	                  }
	                }

	            }
	        }

	        // エラーメッセージ
	        errorMsg = startTimeErrMsg + endTimeErrMsg + breakTimeErrMsg + fromToErrMsg;

	        if (errorMsg) {
	            alert(errorMsg);
	            // エラー
	            return false;
	        }
	        
	      //2024.09.02井上 doSubmit('/kikin-for-Struts-bug/workRecordInputRegister.do');からdocument.forms[0].submit();に変更
	        document.forms[0].submit();
	    }
	
	    /**
	     * 検索
	     */    
	    function submitSearch(action) {
	        document.forms[0].action = "/kikin-for-Struts-bug/workRecordInputSearch.do";
	        document.forms[0].submit();
	    }
        <!-- 2024/09/02/宮平/functionの書き換え -->
	    
    </script>
    
    <title>勤務実績入力画面</title>

    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
     <style>
      #businessBody {
        display: flex;
        justify-content: center;
        margin:20px 0; 
      }
      .tableContainer {
        width: 1080px;
      }
      .tableHeader, .tableBody {
        margin: 0 auto;
      }
    </style>
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
              勤務実績入力
            </td>
            <td id="headRight">
                <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
              </td>
          </tr>
        </table>
      </div>
      <div id="businessBody" style="height:500px;">
        <html:form action="/workRecordInputRegister" ><!-- 2024/09/04/尾崎/actionを変更 -->
          <div style="width: 100%;">
            <div style="float: left; width: 804px; text-align: left; margin-left:100px;">
              表示年月：
              <html:select name="workRecordInputForm" property="yearMonth" onchange="submitSearch('/kikin-for-Struts-bug/workRecordInputSearch.do')">
              <!-- 2024/09/02/宮平/submitSearch()をsubmitSearch('/kikin-for-Struts-bug/workRecordInputSearch.do')に書き換え -->
              <html:optionsCollection name="workRecordInputForm"
                                      property="yearMonthCmbMap"
                                      value="key"
                                      label="value"/>
              </html:select>
            </div>
            <div style="float: left; width: 284px; text-align: left;">
              社員ID&nbsp;<bean:write name="workRecordInputForm" property="employeeId"/>
              ：社員名&nbsp;<bean:write name="workRecordInputForm" property="employeeName"/>
<!--               ：社員名&nbsp;残念エラーです -->
            </div>
          </div>
          <div  id="data">
            <div style="margin-left: 18px ">
            <!-- 2024/08/26/宮平/style="margin-left: 18px "を追加 -->
            <table class="tableHeader">
              <tr>
                <td width="80px" align="center">
                  日付
                </td>
                <td width="50px" align="center">
                  曜日
                </td>
                <td width="100px" align="center">
                  シフト
                </td>
                <td width="100px" align="center">
                  開始時刻
                </td>
                <td width="100px" align="center">
                  終了時刻
                </td>
                <td width="100px" align="center">
                  休憩
                </td>
                <td width="100px" align="center">
                  実働時間
                </td>
                <td width="100px" align="center">
                  時間外
                </td>
                <td width="100px" align="center">
                  休日
                </td>
                <td width="220px" align="center">
                  備考
                </td>
              </tr>
            </table>
          </div>
            
            
            <div style="height:450px;  margin-left: 18px ">
            	
            	<table class="tableBody">
            	<logic:iterate id="workRecordInputList" name="workRecordInputForm" property="workRecordInputList" indexId="idx">
              
                <tr>
                  <html:hidden name="workRecordInputList" property="employeeId" />
                  <td width="80px" align="center">
                    <bean:write name="workRecordInputList" property="workDayDisp" /><br>
                  </td>
                  <bean:define id="weekDay" name="workRecordInputList" property="weekDay"/>
				  <bean:define id="publicHolidayFlg" name="workRecordInputList" property="publicHolidayFlg"/>
				  
                  <%
                  if (DayOfWeek.SATURDAY.getWeekdayShort().equals(weekDay)) {
                      color = "fontBlue";
                  } else if (DayOfWeek.SUNDAY.getWeekdayShort().equals(weekDay) || ((boolean)publicHolidayFlg)) {
                      color = "fontRed";
                  } else {
                      color = "fontBlack";
                  }
                  %>

                  <td width="50px" align="center" class="<%=color %>">
                    <bean:write name="workRecordInputList" property="weekDay" /><br>
                  </td>
                  <td width="100px" align="center">
                    <bean:write name="workRecordInputList" property="symbol" /><br>
                  </td>
                  <td width="100px" align="center">
                    <!-- 2024/08/23/尾崎/bean:writeをhtml:textに修正,startTimeに変更 -->
                    <html:text style="text-align:center" size="5" maxlength="5" name="workRecordInputList" property="startTime" indexed="true"></html:text><br>
                  </td>
                  <td width="100px" align="center">
                    <html:text style="text-align:center" size="5" maxlength="5" name="workRecordInputList" property="endTime" indexed="true"></html:text><br>
                  </td>
                  <td width="100px" align="center">
                    <html:text style="text-align:center" size="5" maxlength="5" name="workRecordInputList" property="breakTime" indexed="true"></html:text><br>
                  </td>
                  <td width="100px" align="center">
                    <bean:write name="workRecordInputList" property="actualWorkTime" /><br><!-- 2024/09/05/尾崎/actualWorkTimeに変更 -->
                  </td>
                  <td width="100px" align="center">
                    <bean:write name="workRecordInputList" property="overTime" /><br>
                  </td>
                  <td width="100px" align="center">
                    <bean:write name="workRecordInputList" property="holidayTime" /><br>
                    <!-- 2024/08/26/宮平/property="holidayTime"を追加 -->
                  </td>
                  <td width="220px" align="left">
                    <html:text style="text-align:left" size="26" name="workRecordInputList" property="remark" indexed="true">備考がいっぱい</html:text><br>
                  </td>
                </tr>
             
            </logic:iterate>
            </table>
          </div>
          </div>
        </html:form>
      </div>
      
      <table class="tableBody" style="margin-top: 5px;">
            <tr>
            <td width="510px" align="center">
                    合計実労働時間
                  </td>
            <td width="100px" align="center">
                    <bean:write name="workRecordInputForm" property="totalActualWorkTime" />
                  </td>
            </tr>
            </table>
      <div id="footer" style="height: 30px;">
        <table>
          <tr>
              <td id="footLeft">
                　
              </td>
              <td id="footCenter">
	              <p class="copyRight">&copy; Copyright Miyahira,Soejima,Inoue,Ozaki SystraIT 23rd Team B.</p>
              </td>
              <td id="footRight">
                <input value="登録"  type="button" class="smallButton"  onclick="register()" />
              </td>
          </tr>
        </table>
    </div>
    </div>
  </body>
</html>