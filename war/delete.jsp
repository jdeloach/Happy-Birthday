<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.jtmcgee.project.happybirthday.utils.*" %>
<%@ page import="net.jtmcgee.project.happybirthday.model.*" %> 
<%@ page import="com.restfb.*" %>
<%@ page import="com.restfb.types.*" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.*" %>
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
	  	<% 
	  	try {
	  		// TODO if is the right USER
	  		PersistenceManager pm = PMF.get().getPersistenceManager();
	  		Query query = pm.newQuery(Birthday.class, "uid == '" + request.getParameter("id") + "'");
	  		Birthday bday = ((List<Birthday>) query.execute()).get(0);
	  		pm.deletePersistent(bday);
	  	} catch(IndexOutOfBoundsException ioobe) {
	  		out.println(ErrorMessage.getErrorHTML("No results by that ID. Already deleted?"));
	  	} catch(Exception e) {
	  		out.println(ErrorMessage.getErrorHTML("Failed to delete schedule birthday wish," +
	  				" want to <a href='/bugs.jsp'>report a bug?</a>"));
	  	}
	  	out.println("Successfully deleted that birthday wish.");
	%>	

<jsp:include page="static/html/footer.html" flush="true"/>
</body>
</html>