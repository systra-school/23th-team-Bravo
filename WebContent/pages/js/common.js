/**
 * ファイル名：check.js
 * 共通処理
 *
 * 変更履歴
 * 1.0  2010/09/10 Kazuya.Naraki
 */

/**
 *  ログアウトボタンサブミット
 */
function logout() {
    document.forms[0].action = "/kikin-for-Struts-bug/logout.do";
    document.forms[0].submit();
}

/**
 *  戻るボタンサブミット
 */
function doSubmit(action) {
	//2024.09.02 井上 actionから"/kikin-for-Struts-bug/menu.do"に変更
    document.forms[0].action = "/kikin-for-Struts-bug/menu.do";
    document.forms[0].submit();
}