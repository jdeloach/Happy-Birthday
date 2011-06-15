<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.model.*" %> 
<%@ page import="javax.jdo.*" %>
<%@ page import="java.util.List" %>

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
	PersistenceManager pm = PMF.get().getPersistenceManager();
	List<Birthday> bdays = (List<Birthday>) pm.newQuery(Birthday.class).execute();
%>
<center>
Scheduled Birthday Wishes: <%= bdays.size() %><br /><br />
That's all. This is a pretty blank page.
</center>
<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>