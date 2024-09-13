<!-- employeeMstMntRegister.jsp -->
<%
/**
 * ファイル名：employeeMstMntRegister.jsp
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
      var isCheck = document.forms[0].elements.deleteEmployeeId[index].checked;
      document.forms[0].elements.deleteFlg[index].value = isCheck;
    }
    /**
     * 新規登録画面へ
     */
     function employeeMstMntRegister() {
         with (document.forms[0]) {
             // パスワード
             var passwordVar = password.value;
             //社員名
             var employeeNameVar = employeeName.value;
             // 社員名カナ
             var employeeNameKanaVar = employeeNameKana.value;
             // エラーメッセージ
             var errorMsg = '';
             // 背景色をクリアする
             password.style.backgroundColor = 'white';
             employeeNameKana.style.backgroundColor = 'white';
             if (!checkRequired(passwordVar)) {
                 var strArr = ['パスワード'];
                 errorMsg += getMessage('E-MSG-000001', strArr);
                 password.style.backgroundColor = 'red';
             }
             if (!checkRequired(employeeNameVar)) {
                var strArr = [ '社員名' ];
                errorMsg += getMessage('E-MSG-000001', strArr);
                employeeName.style.backgroundColor = 'red';
             }
             if (!checkRequired(employeeNameKanaVar)) {
            	 var strArr = ['社員名カナ'];
                 errorMsg += getMessage('E-MSG-000001', strArr); //エラーメッセージの変更
                 employeeNameKana.style.backgroundColor = 'red';
                 }
             if(!checkHalfWidthKana(employeeNameKanaVar)){
            	 var strArr = ['社員名カナ'];
                 errorMsg += getMessage('E-MSG-000003', strArr); //エラーメッセージの変更
                 employeeNameKana.style.backgroundColor = 'red';
                 }
             if (errorMsg) {
                 alert(errorMsg);
                 // エラー
                 return false;
             }
         }
         // サブミット
 //2024.08.28井上 doSubmit('/kikin-for-Struts-bug/employeeMstMntRegister.do');からdocument.forms[0].submit();に変更
         document.forms[0].submit();
     }
    </script>
    <title>社員マスタメンテナンス画面</title>
    <link href="/kikin-for-Struts-bug/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table class="full-width">
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smallButton"  onclick="history.back()" />
              </td>
            <td id="headCenter">
              社員マスタメンテナンス画面（新規登録）
            </td>
            <!-- ログアウトボタンの配置を修正 -->
            <td id="headRight">
              <input value="ログアウト" type="button" class="smallButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="businessBody" style="margin-bottom:24px;">
        <html:form action="/employeeMstMntRegister" >
          <div style="width: 650px;text-align: left;  margin: 0 auto;">
            <table class="tableHeader" style="margin-top:24px;">
              <tr>
                <td width="150px" align="center">
                  パスワード
                </td>
                <!-- 社員名とカナの配置を変更 -->
                <td width="200px" align="center">
                  社員名
                </td>
                <td width="200px" align="center">
                  社員名カナ
                </td>
                <td width="100px" align="center">
                  権限
                </td>
              </tr>
            </table>
          </div>
          <div style="overflow: auto; height: 440px; width: 650px; margin: 0 auto; ">
            <table class="tableBody">
              <tr>
                <td width="150px"  align="center">
                  <html:password property="password"  value="" size="10" />
                </td>
                <td width="200px"  align="center">
                  <html:text property="employeeName" value="" size="20" />
                </td>
                <!-- 131行目を追加 -->
                <td width="200px"  align="center">
                  <html:text property="employeeNameKana" value="" size="20" />
               </td>
                <td width="100px" align="center">
                  <html:select property="authorityId">
                    <html:optionsCollection name="employeeMstMntForm"
                                            property="authorityCmbMap"
                                            value="key"
                                            label="value"/>
                  </html:select>
                </td>
              </tr>
            </table>
          </div>
        </html:form>
        
          <div class="warning" style="margin-top:-360px;">
        	<h2>記入に関して(tips)</h2>
        	<ul>
        		<li>パスワードは半角英数で入力してください。(※6文字まで)</li>
        		<li>社員名は全角で入力してください。(※20文字まで)</li>
        		<li>カナは半角で入力してください。(※20文字まで)</li>
        	</ul>
        </div>
        
      </div>
      <div id="footer">
        <table>
          <tr>
            <td id="footLeft">
              　
            </td>
            <td id="footCenter">
              　
            </td>
            <td id="footRight">
              <input value="登録" type="button" class="smallButton"  onclick="employeeMstMntRegister()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>