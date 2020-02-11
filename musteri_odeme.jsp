<%@page import="java.text.*"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>

<%
    String login = (String) session.getAttribute("musteri_login");
    String musteri = (String) session.getAttribute("musteri_id");
    if (login != "true") {
        response.sendRedirect("index.jsp");
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Müşteri Sayfası</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='#';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="musteri_index.jsp" style="text-decoration:none;"><span>Anasayfa </span></a>|
                    <a href="musteri_sepet.jsp" style="text-decoration:none;"><span> Sepetim </span></a>|
                    <a href="cikis.jsp" style="text-decoration:none;"><span> Çıkış </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div id="headermenu" class='cssmenu' >
                    <ul>
                        <li class='has-sub '><a name="kategori"><span></br></span></a> </li>         
                    </ul>
                </div>

                <div id="content">	
                    <div id="buyukkutu">
                        <h4><br>Ödeme Ekranı</h4>

                        <form id="form1" name="form1" method="post" action="musteri_index.jsp">
                            <table border="0">

                                <%
                                 if(request.getParameter("siparis_id")!=null && request.getParameter("siparis_miktar")!=null && request.getParameter("odeme_turu")!=null)
                                 {    
                                      String siparis_id = request.getParameter("siparis_id");
                                      String siparis_miktar = request.getParameter("siparis_miktar");
                                      String odeme_turu = request.getParameter("odeme_turu");
                                      
                                     if(!odeme_turu.equals(""))
                                     {
                                         Statement stmt = conn.createStatement();
                                        if(odeme_turu.equals("kapida_odeme"))
                                        {
                                              stmt.executeUpdate("INSERT INTO musteri_odeme(odeme_turu,musteri_ıd) VALUES ('"+"Kapıda Ödeme"+"','"+musteri+"')");            
                                              stmt.executeUpdate("UPDATE siparis SET sepet_durum='"+"true"+"', siparis_miktar='"+siparis_miktar+"' WHERE siparis_id='"+siparis_id+"'");            
                                              response.sendRedirect("musteri_sepet.jsp");
                                        }else  if(odeme_turu.equals("kredi_karti"))
                                        {
                                              stmt.executeUpdate("INSERT INTO musteri_odeme(odeme_turu,musteri_ıd) VALUES ('"+"Kredi Kartı"+"','"+musteri+"')");            
                                              stmt.executeUpdate("UPDATE siparis SET sepet_durum='"+"true"+"', siparis_miktar='"+siparis_miktar+"' WHERE siparis_id='"+siparis_id+"'");            
                                              response.sendRedirect("musteri_sepet.jsp");
                                        }                                         
                                     }
                                 } 
                                %>                              
                      
                            </table>
                        </form>

                    </div>		
                    <div class="clearboth"></div> <!-- Float Temizleyici-->	
                </div>


                <div class="clearboth"></div> <!-- Float Temizleyici-->		
            </div>

            <div id="footer">
                <p>
               <a href="yonetici_giris.jsp" style="text-decoration:none;"><span>Admin:</span></a>  &copy; By <a href="http://dev.cs.hacettepe.edu.tr/~b20926305/cv/" style="text-decoration:none;"> <span>Recep Dur</span></a> - <a href="#" style="text-decoration:none;"><span>Yahya Yalçın</span> </a>

                </p>
            </div>

        </div>
    </body>
</html>
                                
