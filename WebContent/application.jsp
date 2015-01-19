<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/org/cometd.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/org/cometd/AckExtension.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/org/cometd/ReloadExtension.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery/jquery-1.8.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery/jquery.cookie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery/jquery.cometd.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery/jquery.cometd-reload.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/privatechatwindow.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/cometchat.js"></script>
<script type="text/javascript">

    var chatWindowArray = [];

    var config = {
    	contextPath : '${pageContext.request.contextPath}'
    };

    function broadcastmessage(loginUserName) {
    	var textInput = document.getElementById("commonchatinput");
    	$.cometChat.broadcastmsg($(textInput).val());
    	$(textInput).val('');
    	$(textInput).focus();
    }

    function getChatWindowByUserPair(loginUserName, peerUserName) {

    	var chatWindow;

    	for (var i = 0; i < chatWindowArray.length; i++) {
    		var windowInfo = chatWindowArray[i];
    		if (windowInfo.loginUserName == loginUserName && windowInfo.peerUserName == peerUserName) {
    			chatWindow = windowInfo.windowObj;
    		}
    	}

    	return chatWindow;
    }

    function createWindow(loginUserName, peerUserName) {

    	var chatWindow = getChatWindowByUserPair(loginUserName, peerUserName);

    	if (chatWindow == null) {
    		chatWindow = new PrivateChatWindow();
    		chatWindow.initWindow({
    			loginUserName : loginUserName,
    			peerUserName : peerUserName,
    			windowArray : chatWindowArray
    		});

    		var chatWindowInfo = {
    			peerUserName : peerUserName,
    			loginUserName : loginUserName,
    			windowObj : chatWindow
    		};

    		chatWindowArray.push(chatWindowInfo);
    	}

    	chatWindow.show();
    	return chatWindow;
    }

    function join(userName) {
    	$.cometChat.join(userName);
    }
</script>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/comet.chat.css" />
</head>
<body>
	<script type="text/javascript">
	var userName = '<%=request.getParameter("username")%>';
	$(document).ready(function () {
		$.cometChat.onLoad({
			memberListContainerID : 'members',
			commonChatId : 'commonchat'
		});
		join(userName);
	});
	</script>
	<div id="members"></div>
	<input placeholder="This is a common chat" id="commonchatinput"></input>
	<button id="sendall" onclick="broadcastmessage('<%=request.getParameter("username")%>')">Send</button>
	<div id="commonchat"></div>
</body>
</html>
