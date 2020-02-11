<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="baglanti.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
<title>Çıkış</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
<div id="page">
	
	<div id="cikis"> 
	<%
		if (session.isNew()==true)
			response.sendRedirect(response.encodeRedirectURL("login.jsp"));
			session.invalidate();
			//out.print( "<span><p align="center"> Ana Sayfaya Yönlendiriliyorsunuz..</p></span>");
			response.sendRedirect("index.jsp");
                     conn.close();   
	%>
	</div>
	
</div>

</body>
</html>