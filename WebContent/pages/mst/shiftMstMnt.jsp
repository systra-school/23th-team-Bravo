<!-- shiftMstMnt.jsp -->
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.mst.ShiftMstMntBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mst.ShiftMstMntForm"%>
<%
/**
 * ファイル名：shiftMstMnt.jsp
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

<bean:size id="beanListSize" name="shiftMstMntForm" property="shiftMstMntBeanList"/>
<html lang="ja">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin-for-Struts-bug/pages/js/message.js"></script>
    <script type="text/javascript">
    /**
     * チェックボックスがチェックされたら true、されていなければ false
     * param index 対象行番号
     */
     function checkDeleteFlg(index) {
         var deleteShiftId = document.forms[0].elements.deleteShiftId;
         var isCheck = false;

         if (deleteShiftId.length > 1) {
             isCheck = document.forms[0].elements.deleteShiftId[index].checked;
         } else {
             isCheck = deleteShiftId.checked;
         }

         document.forms[0].elements.namedItem('shiftMstMntBeanList['+ index +'].deleteFlg').value = isCheck;
     }

    /**
     * 新規登録画面へ
     */
    function shiftMstMntRegisterInit() {
    	document.forms[0].action = "/kikin-for-Struts-bug/shiftMstMntRegisterInit.do";
        document.forms[0].submit();
    }

    /**
     * 更新処理を行う
     */
    function shiftMstMntUpdate() {

        // 一覧のサイズ
        var listSize = <%= beanListSize %>;

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
                var startTime = namedItem('shiftMstMntBeanList['+ i +'].startTime').value;
                // 終了時間を取得する。
                var endTime = namedItem('shiftMstMntBeanList['+ i +'].endTime').value;
                // 休憩時間を取得する。
                var breakTime = namedItem('shiftMstMntBeanList['+ i +'].breakTime').value;

                // 背景色をクリアする
                namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].breakTime').style.backgroundColor = 'white';

                // 時間チェック
                if (!startTimeErrMsg) {
                    if (!checkTime(startTime)) {
                        var strArr = ['開始時間'];
                        startTimeErrMsg = getMessage('E-MSG-000004', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'red';
                    }
                }
                if (!endTimeErrMsg) {
                    if (!checkTime(endTime)) {
                        var strArr = ['終了時間'];
                        endTimeErrMsg = getMessage('E-MSG-000004', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'red';
                    }
                }
                if (!breakTimeErrMsg) {
                    if (!checkHalfWidthKana(breakTime)) {
                        var strArr = ['休憩時間'];
                        breakTimeErrMsg = getMessage('E-MSG-000006', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].breakTime').style.backgroundColor = 'blue';
                    }
                }

                // from - to のチェック
                if (!checkTimeCompare(startTime, endTime)) {
                  if (checkTime(startTime) && checkTime(endTime)) {
                      fromToErrMsg = getMessageCodeOnly('E-MSG-000005');
                      namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'red';
                      namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'red';
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

        document.forms[0].submit();
    }
    </script>

    <title>シフトマスタメンテナンス画面</title>

    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table class="full-width">
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smallButton"  onclick="doSubmit('/kikin-for-Struts-bug/menu.do')" />
            </td>
            <td id="headCenter">
              シフトマスタメンテナンス
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="businessBody">
        <html:form  action="/shiftMstMntUpdate">
          <div style="width: 600px; margin: 0 auto;">
            <table class="tableHeader">
              <tr>
                <td width="100px" align="center">
                  シフト名
                </td>
                <td width="70px" align="center">
                  シンボル
                </td>
                <td width="230px" align="center">
                  時間
                </td>
                <td width="100px" align="center">
                  休憩
                </td>
                <td width="70px" align="center">
                  削除
                </td>
              </tr>
            </table>
          </div>
          <div style="overflow: auto; height: 80%; width: 600px; margin: 0 auto;">
            <table class="tableBody">
              <logic:iterate indexId="idx" id="shiftMstMntBeanList" name="shiftMstMntForm"  property="shiftMstMntBeanList">
              <bean:define id="shiftId" name= "shiftMstMntBeanList" property="shiftId" type="java.lang.String"/>
                <tr>
                  <td width="100px"  align="center">
                    <html:text property="shiftName" name="shiftMstMntBeanList" size="5" maxlength="10" indexed="true"/>
                    <html:hidden property="shiftId" name="shiftMstMntBeanList" indexed="true"/>
                  </td>
                  <td width="70px"  align="center">
                    <html:text property="symbol" name="shiftMstMntBeanList"  size="1" maxlength="2" indexed="true"/>
                  </td>
                  <td width="230px"  align="center">
                    <table class="full-width">
                      <tr>
                        <td align="center" class="non-border">
                          <html:text property="endTime" name="shiftMstMntBeanList"  size="5" maxlength="5" indexed="true"/>
                        </td>
                        <td align="center" class="non-border">
                            &#xFF5E;
                        </td>
                        <td align="center" class="non-border">
                          <html:text property="startTime" name="shiftMstMntBeanList"  size="5" maxlength="5" indexed="true"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                    <html:text property="breakTime" name="shiftMstMntBeanList"  size="5" maxlength="5" indexed="true"/>
                 
                  <td width="70px"  align="center">
                    <html:hidden property="deleteShiftId" name="shiftMstMntBeanList"  value="<%= shiftId %>"  onchange='<%="checkDeleteFlg(" + idx + ")" %>'></html:hidden>
                    <html:hidden property="deleteFlg" name="shiftMstMntBeanList" value="false" indexed="true"/>
                  </td>
                </tr>
              </logic:iterate>
            </table>
          </div>
        </html:form>
      </div>
      <div id="footer">
        <table>
          <tr>
            <td id="footLeft">
              　
            </td>
            <td id="footCenter">
              　
            </td>
            <td id="footRight">
              <input value="新規登録" type="button" class="smallButton"  onclick="shiftMstMntRegisterInit()" />
              <input value="更新" type="button" class="smallButton"  onclick="shiftMstMntUpdate()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>