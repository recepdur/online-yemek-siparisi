<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %> 
<%@include file="baglanti.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Online Yemek Siparişi</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />

    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='index.jsp';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="index.jsp" style="text-decoration:none;"><span>Anasayfa </span></a>|
                    <a href="musteri_giris.jsp" style="text-decoration:none;"><span>Müsteri Girişi </span></a>|
                    <a href="lokanta_giris.jsp" style="text-decoration:none;"><span>Lokanta Girişi </span></a>
                </div>

            </div>
            <div id="mainpage">

                <div class='cssmenu'>
                    <ul>	
                        <li class='has-sub '><a href='index.jsp'><span></br></span></a> </li>
                    </ul>
                </div>
                <div id="leftside"> </div>
                <div id="content"> </div>	
                <div class="clearboth"></div> <!-- Float Temizleyici-->		
            </div>

            <div id="footer">          
                <p>
                    <a href="yonetici_giris.jsp" style="text-decoration:none;"><span>Admin:</span></a> &copy; <a href="http://dev.cs.hacettepe.edu.tr/~b20926305/cv/" style="text-decoration:none;"> <span>Recep Dur</span></a> - <a href="#" style="text-decoration:none;"><span>Yahya Yalçın</span> </a>
                </p>
            </div>

        </div>
    </body>
</html>