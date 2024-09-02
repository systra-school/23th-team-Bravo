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
function logout(action) {//2024.09.02 尾崎 actionを追加
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

 /**
  * 検索
  */
function submitSearch(action) {
	document.forms[0].action = "/kikin-for-Struts-bug/workRecordInputSearch.do";
    document.forms[0].submit();
}
//2024/09/02/宮平/検索サブミットの追加
