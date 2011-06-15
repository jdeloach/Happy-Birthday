<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page buffer="16kb" %>
    <%@ page import="net.jtmcgee.project.happybirthday.utils.*" %>
    <%@ page import="com.restfb.DefaultFacebookClient" %>
	<%@ page import="com.restfb.FacebookClient" %>
	<%@ page import="com.restfb.types.User" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/static/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="static/html/header.html" flush="true"/>
<%
try {
	if(request.getParameter("token") != null) {
		session.setAttribute("access_token", request.getParameter("token"));
	    FacebookClient fbClient = new DefaultFacebookClient(request.getParameter("token"));
		session.setAttribute("uid", fbClient.fetchObject("me", User.class).getId());
	} else if(((String) session.getAttribute("access_token")).equals("")) {
		response.sendRedirect(Facebook.getLoginRedirectURL());
	    FacebookClient fbClient = new DefaultFacebookClient(request.getParameter("token"));
		session.setAttribute("uid", fbClient.fetchObject("me", User.class).getId());
	}
} catch (Exception e) {
//	response.sendRedirect(Facebook.getLoginRedirectURL());
	out.println("<center><h2><a href=\"" + Facebook.getLoginRedirectURL() + "\" style=\"color: darkblue;\">Please login with Facebook</a></h2></center>");
}
%>
This is the Happy Birthday FB App!
This enables you to wish someone a Happy Birthday at 12:00 A.M. without actually being there. Whatever the reason maybe, this app can solve it.
Instead of staying up, focusing on just this, just configure the app to wish the right person a message on their 
birthday (your message), and when the clock strikes 12, they will be wished a Happy Birthday from you.
<br />
<strong>Note:</strong> I wouldn't recommend using this all the time, else the awesomeness of a 12 A.M.
"Happy Birthday" goes away.
<br />
<div style="float: left">
<br />
<ul>
<li><a href="/add.jsp" style="color: red;">Get started!</a></li>
<li>As always, please <a href="bugs.jsp" style="color: green;">report bugs</a>! That's the only way software improves.</li>
<li><a href="contact.jsp" style="color: blue;">Give suggestions!</a></li>
<li>Follow <a href="http://twitter.com/jtmcgee" style="color: orange;">@jtmcgee</a> on Twitter</li>
<li>Software Dev's, Fork us on <a href="http://github.com/jdeloach/Happy-Birthday" style="color: teal;">GitHub</a>.</li>
</ul>
<br />
</div>
<div style="float: right">
<img src="/static/images/Happy_Birthday_Balloons.gif" height="240px" width="180px">
</div>
<center>
<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script>
<fb:like-box href="https://www.facebook.com/apps/application.php?id=210869075618877" width="292" show_faces="false" border_color="" stream="false" header="false"></fb:like-box>
</center>
<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>