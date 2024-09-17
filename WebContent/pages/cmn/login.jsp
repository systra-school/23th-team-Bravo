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
<link rel="icon" href="/kikin-for-Struts-bug/pages/img/favicon.ico">
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
			<div id="slotMachine" style="display: flex; justify-content: center; align-items: center; background-color: #f0f0f0; font-family: Arial, sans-serif;">
        <div class="reel" id="reel1">1</div>
        <div class="reel" id="reel2">2</div>
        <div class="reel" id="reel3">3</div>
        <button id="spinButton">止める！</button>
        <div id="result"></div>
        <!-- 勝利時に表示する画像 -->
        <img id="winImage" src="https://example.com/winning-image.png" alt="You Win!" width="200">
    </div>
    
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', () => {
            const symbols = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
            let intervals = [];
            let stoppedReels = 0;
            let reelIndices = [0, 0, 0]; // 各リールの現在のシンボルのインデックス

            function startReel(reelId, reelIndex) {
                return setInterval(() => {
                    // 次のシンボルに移動
                    reelIndices[reelIndex] = (reelIndices[reelIndex] + 1) % symbols.length;
                    const nextSymbol = symbols[reelIndices[reelIndex]];
                    document.getElementById(reelId).textContent = nextSymbol;
                }, 300); // リールの回転速度
            }

            function startAllReels() {
                intervals[0] = startReel('reel1', 0);
                intervals[1] = startReel('reel2', 1);
                intervals[2] = startReel('reel3', 2);
                stoppedReels = 0;
            }

            function stopReel() {
                if (stoppedReels < intervals.length) {
                    clearInterval(intervals[stoppedReels]);
                    stoppedReels++;
                    if (stoppedReels === intervals.length) {
                        checkResult();
                    }
                }
            }

            function checkResult() {
                const reel1 = document.getElementById('reel1').textContent;
                const reel2 = document.getElementById('reel2').textContent;
                const reel3 = document.getElementById('reel3').textContent;

                if (reel1 === "7" && reel2 === "7" && reel3 === "7") {
                    document.getElementById('result').textContent = 'Jackpot! You Win!';
                    document.getElementById('winImage').style.display = 'block';
                } else {
                    document.getElementById('result').textContent = '７を狙え！！！';
                }
                document.getElementById('spinButton').textContent = 'もう一回！';
            }

            document.getElementById('spinButton').addEventListener('click', () => {
                if (stoppedReels < intervals.length) {
                    stopReel();
                } else {
                    startAllReels();
                    document.getElementById('winImage').style.display = 'none';
                    document.getElementById('result').textContent = '';
                    document.getElementById('spinButton').textContent = 'Stop!';
                }
            });

            startAllReels();
        });
    </script>
    
		</div>
		
		
    
		<div id="footer">
			<table>
				<tr>
					<td id="footLeft"></td>
					<td id="footCenter">
					      <p class="copyRight">&copy; Copyright Miyahira,Soejima,Inoue,Ozaki SystraIT 23rd Team B.</p>
					</td>
					<td id="footRight"></td>
					
					<html:link action="/miya">裏世界</html:link>
					
				</tr>
			</table>
		</div>
	</div>
</body>
</html>