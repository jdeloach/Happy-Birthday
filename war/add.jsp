<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.utils.*" %> 
<%@ page import="com.restfb.*" %>
<%@ page import="com.restfb.types.*" %>
<%@ page import="com.restfb.exception.FacebookOAuthException" %>
<%@ page import="java.util.Random" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/static/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="static/html/header.html" flush="true"/>
<% if(request.getParameter("s") == null && request.getParameter("p") == null) { %>
<center>
<br />
<form name="search" action="" method="get">
<label for="s">Name: </label>
<input type="text" name="s" id="s" value="" />
<a href="#" onclick="document.search.submit()" class="myButton">Search</a>
</form>
<br />
</center>
<% } else if(request.getParameter("p") == null) {
	try {
		FacebookClient fbClient = new DefaultFacebookClient(Config.ACCESS_TOKEN(request));
		Connection<User> results = fbClient.fetchConnection("me/friends", User.class);
		String[] colors = {"red", "blue", "green", "orange", "brown"};
		Random rand = new Random();
		out.println("<center>");
		for(int i = 0; i < results.getData().size(); i++) {
			// TODO rm those who do not list B-Days
			if(results.getData().get(i).getName().toUpperCase().indexOf(request.getParameter("s").toUpperCase()) > -1)
				out.println("<a href=\"/add.jsp?p=" + results.getData().get(i).getId() +
						"\" style=\"color:" + colors[rand.nextInt(colors.length)] + "\">" + results.getData().get(i).getName() + "</a><br />");
		}
		out.println("</center>");
	} catch(FacebookOAuthException FBOE) {
  		out.println(ErrorMessage.OAuthError());
  	} catch(Exception e) {
  		out.println(ErrorMessage.GeneralError());
  	}

} else {
	try {
			FacebookClient fbClient = new DefaultFacebookClient(Config.ACCESS_TOKEN(request));
			User user = fbClient.fetchObject(request.getParameter("p"), User.class);
			%>
			<form name="add" action="/addBirthday" method="post">
			<center>
			<fieldset>
			<legend>Add</legend>
			<%= "You will be wishing " + user.getName() + " a Happy Birthday at 12:00 A.M. for their birthday, " + user.getBirthday() %>
			<br /><br />
			<input type="hidden" name="id" id="id" value="<% out.print(request.getParameter("p")); %>">
			<textarea id="message" name="message">Happy Birthday, <%= user.getName() %>!</textarea>
			<br /><br />
			<a href="#" onclick="document.add.submit()" class="myButton">Add</a>
			</fieldset>
			</center>
			</form>
			<%
	} catch(FacebookOAuthException FBOE) {
		out.println(ErrorMessage.OAuthError());
	} catch(Exception e) {
		out.println(ErrorMessage.GeneralError());
	}
}
%>
<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>