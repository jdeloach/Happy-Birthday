<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.utils.*" %>
<%@ page import="net.jtmcgee.project.happybirthday.model.*" %> 
<%@ page import="com.restfb.*" %>
<%@ page import="com.restfb.types.*" %>
<%@ page import="javax.jdo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restfb.types.User" %>
<%@ page import="com.restfb.exception.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/static/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="static/html/header.html" flush="true"/>
<% if(request.getParameter("message") == null) { 
	try {
	FacebookClient fbClient = new DefaultFacebookClient(Config.ACCESS_TOKEN(request));
	User user = fbClient.fetchObject(request.getParameter("id"), User.class);
	PersistenceManager pm = PMF.get().getPersistenceManager();
	Query query = pm.newQuery(Birthday.class, "uid == '" + request.getParameter("id") + "' && wisherID == '" + session.getAttribute("uid") + "'");
	Birthday bday = ((List<Birthday>) query.execute()).get(0);
%>
<center>
<br />
<form name="edit" action="" method="post">
<fieldset>
<legend>Edit</legend>
<label>For: </label>
<%= user.getName() %><br /><br />
<textarea name="message"><%= bday.getMessage() %></textarea>
<input type="hidden" name="id" value="<%= bday.getUid() %>" />
<br /><br />
<a href="#" onclick="document.edit.submit()" class="myButton">Submit</a>
<a href="delete.jsp?id=<%= user.getId() %>" class="myButton">Delete</a>
</fieldset>
</form>
<br />
</center>
<%  } catch(FacebookOAuthException FBOE) {
	out.println(ErrorMessage.OAuthError());
	} catch(Exception e) {
	out.println(ErrorMessage.GeneralError());
	}
	} else if(request.getParameter("message") != null) {
	    PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(Birthday.class, "uid == '" + request.getParameter("id") + "'");
		Birthday bday = ((List<Birthday>) query.execute()).get(0);
		bday.setMessage(request.getParameter("message"));
		pm.close();
		out.println("Successfully edited.");
	}
%>
<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>