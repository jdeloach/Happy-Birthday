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
	out.println("<h3><a href=\"" + Facebook.getLoginRedirectURL() + "\">Login with Facebook</a></h3>");
}
%>
Yo dawg. This is the Happy Birthday FB App! I don't know about you but I am too lazy/bored/tired to stay
up till 12:00 A.M. to wish someone a Happy Birthday, however, I wish I could. This app basicalyl enables
you to cheat. Instead of staying up, just configure the app to wish the right person a message on their 
birthday (your message), and when the clock strikes 12, they will be wished a Happy Birthday from you.
<br />
<strong>Note:</strong> I wouldn't recomend using this all the time, else the awesomeness of a 12 A.M.
"Happy Birthday" goes away.
<ul>
<li>As always, please <a href="bugs.jsp">report bugs</a>! That's the only way software improves.</li>
<li><a href="contact.jsp">Give suggestions!</a></li>
<li>"like" us on Facebook</li>
<li>Follow <a href="http://twitter.com/jtmcgee">@jtmcgee</a> on Twitter</li>
<li>Software Dev's, Fork us on <a href="http://github.com/jdeloach/Happy-Birthday">GitHub</a>.</li>
</ul>
<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>