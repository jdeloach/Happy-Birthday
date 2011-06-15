<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.utils.*" %>
<%@ page import="net.jtmcgee.project.happybirthday.model.*" %> 
<%@ page import="com.restfb.*" %>
<%@ page import="com.restfb.types.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restfb.exception.FacebookOAuthException" %>
<%@ page import="com.restfb.DefaultFacebookClient" %>
<%@ page import="com.restfb.FacebookClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/static/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
try {
if(request.getParameter("added").equals("true")) {
	%>
<div id="fb-root"></div>
   <script src="http://connect.facebook.net/en_US/all.js">
   </script>
   <script>
     FB.init({ 
       appId:'210869075618877', cookie:true, 
       status:true, xfbml:true 
     });

     FB.ui({ method: 'apprequests', 
       message: 'Hey! I just scheduled a Happy Birthday post on my friends wall for midnight, you should do it too.'});
   </script>
   <%
} } catch (Exception e) {}
%>
<jsp:include page="static/html/header.html" flush="true"/>

	  	<% try {	%>
	  	<table class="schedule">
			<tr class="header">
				<th width="200px;"><label>Name</label></th>
				<th width="200px;"><label>Birthday</label></th>
				<th width="50px;"><label>Edit</label></th>
				<th width="50px;"><label>Delete</label></th>
			</tr>
		<%
			List<Birthday> birthdays = (List<Birthday>) PMF.get().getPersistenceManager().newQuery(Birthday.class, "wisherID == '" + session.getAttribute("uid") + "'").execute();
		  	for(int i = 0; i < birthdays.size(); i++) {
		  	String val;
		  	if(i%2 != 0) { val = "odd"; } else { val = "even"; } %>
			<tr class="<%= val %>">
				<td><%= birthdays.get(i).getUser(request).getName() %></td>
				<td><%= birthdays.get(i).getDate() %><% if(birthdays.get(i).getAge() != 0) out.println(", " + birthdays.get(i).getAge() + " years old"); %></td>
				<td><a href="edit.jsp?id=<%= birthdays.get(i).getUser(request).getId() %>" class="myButton">edit</a></td>
				<td><a href="delete.jsp?id=<%= birthdays.get(i).getUser(request).getId() %>" class="myButton">delete</a></td>
			</tr>
			<% } %>
		  	</table>
	  	<% } catch(FacebookOAuthException FBOE) {
	  		out.println("</table>");
	  		out.println(ErrorMessage.OAuthError());
	  	} catch(Exception e) {
	  		out.println("</table>");
	  		out.println(ErrorMessage.GeneralError());
	  	}
	  	%>
		

<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>