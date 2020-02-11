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
                        
                        <form id="form1" name="form1" method="post" action="musteri_odeme.jsp">                       
                                <table border="0">    
                                    <tr><td></br></td></tr>
                                    <tr><td></br></td></tr>
                                    <tr><td></td><td><h4>Sipariş Miktarını Giriniz</h4></td></tr>
                                    <tr><td></br></td></tr>
                                    
                                    <%
                                       if(request.getParameter("siparis_id") != null)
                                       { 
                                            Statement stmt = conn.createStatement();        
                                            String siparis_id = request.getParameter("siparis_id");
                                            
                                            ResultSet rs_siparis_onay = stmt.executeQuery("SELECT * FROM siparis WHERE siparis_id='"+siparis_id+"' AND sepet_durum='"+"false"+"'AND siparis_durum='"+"false"+"'");
                                            rs_siparis_onay.next(); 
                                            out.print("<tr><td>Siparis ID</td><td><input readonly=\"yes\" type=\"text\" name=\"siparis_id\" value="+rs_siparis_onay.getString("siparis_id")+"> </input></td></tr>");
                                            out.print("<tr><td>Siparis Miktarı</td><td><input type=\"text\" name=\"siparis_miktar\" value="+rs_siparis_onay.getString("siparis_miktar")+"> </input></td></tr>");
                                            out.print("<tr><td>Ödeme Türü Seçin</td><td><select name=\"odeme_turu\"> <option value=\"kredi_karti\">Kredi Kartı</option>  <option value=\"kapida_odeme\">Kapıda Ödeme</option></select></td></tr>");
                                            out.print("<tr><td><input type=\"submit\" value=\"Devam Et\" /></td></tr>");
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
                 <a href="yonetici_giris.jsp" style="text-decoration:none;"><span>Admin:</span></a>   &copy; By <a href="http://dev.cs.hacettepe.edu.tr/~b20926305/cv/" style="text-decoration:none;"> <span>Recep Dur</span></a> - <a href="#" style="text-decoration:none;"><span>Yahya Yalçın</span> </a>

                </p>
            </div>

        </div>
    </body>
</html>
                              