<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.utils.ErrorMessage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error: 404</title>
<link href="/static/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../static/html/header.html" flush="true"/>
<%= ErrorMessage.getErrorHTML("<h2>Error 404: Page Not Found</h2><br />" +
		"You can either go <a href=\"/\">home</a>, or if you believe this is our fault, please, " + 
		"do not hesitate to <a href=\"/bugs.jsp\">report it.</a>") %>
<jsp:include page="../static/html/footer.html" flush="true"/>
</body>
</html>