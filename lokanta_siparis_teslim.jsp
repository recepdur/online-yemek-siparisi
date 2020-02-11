<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>
<%
    String login = (String) session.getAttribute("lokanta_login");
    String lokanta = (String) session.getAttribute("lokanta_id");
    if (login != "true") {
        response.sendRedirect("index.jsp");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Siparişler</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="javascript.js"></script>
    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='lokanta_index.jsp';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="lokanta_index.jsp" style="text-decoration:none;"><span>Yönetim </span></a>|
                    <a href="cikis.jsp" style="text-decoration:none;"><span> Çıkış </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div class='cssmenu'>
                    <ul>	
                        <li class='has-sub '><a href='lokanta_siparis.jsp'><span>Siparisler</span></a> </li>
                        <li class='has-sub '><a href='lokanta_yemek_ekle.jsp'><span>Yemek Ekle</span></a> </li>
                        <li class='has-sub '><a href='lokanta_stok.jsp'><span>Stok Düzenle</span></a> </li>
                    </ul>
                </div>

                <div id="content">			
                    <div id="buyukkutu">
                        <form id="form1" name="form1" method="post" action="lokanta_siparis_teslim.jsp">
                            <h4 align="center" > Siparişi Teslim Eden Bilgilerini Giriniz </h4><br>
                                <table border="0">
                                    <tr><td></br></td></tr> 
                                      <tr><td width="200"><h4>Sipariş ID:</h4></td><td><input readonly="yes" type="text" name="siparis_id" value="<%out.print(request.getParameter("siparis_id"));%>"> </input></td></tr>
                                      <tr><td width="200"><h4>Teslim Edenin Adı:</h4></td> <td><input type="text" name="teslim_ad"></input></td></tr>
                                      <tr><td width="200"><h4>Teslim Edenin Soyadı:</h4></td> <td><input type="text" name="teslim_soyad"></input></td></tr>		
                                      <tr><td width="200"><h4>Teslim Edenin Tel:</h4></td> <td><input type="text" name="teslim_tel"></input></td></tr>                                     
                                      <tr><td></br></td></tr>
                                      <tr><td><input type="submit" value="Teslim Et"></td>                                                                                                     
                                </table>
                        </form>						
                    </div>
                    <p id="input1"></p>
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

<%
    if(request.getParameter("siparis_id") != null && request.getParameter("teslim_ad") != null && request.getParameter("teslim_soyad") != null && request.getParameter("teslim_tel") != null)
    {
        String siparis_id = request.getParameter("siparis_id"); 
        String teslim_ad=request.getParameter("teslim_ad");
        String teslim_soyad=request.getParameter("teslim_soyad");
        String teslim_tel=request.getParameter("teslim_tel");
 
        if(!teslim_ad.equals("") && !teslim_soyad.equals("") && !teslim_tel.equals("") )
        {
           Statement stmt = conn.createStatement();        
           stmt.executeUpdate("INSERT INTO teslim_eden(teslim_eden_ad,teslim_eden_soyad,teslim_eden_tel) VALUES ('"+teslim_ad+"','"+teslim_soyad+"','"+teslim_tel+"')");            
           ResultSet rs_teslim_eden = stmt.executeQuery("SELECT teslim_eden_id FROM teslim_eden WHERE teslim_eden_ad='" + teslim_ad + "' AND teslim_eden_soyad='" + teslim_soyad + "' AND teslim_eden_tel='" + teslim_tel + "'");
           rs_teslim_eden.next();
           String teslim_eden_id = rs_teslim_eden.getString("teslim_eden_id");
           stmt.executeUpdate("UPDATE siparis SET teslim_eden_id='"+ teslim_eden_id +"', siparis_durum='"+ "true" +"' WHERE siparis_id='"+siparis_id+"'");                    
           stmt.close();
           response.sendRedirect("lokanta_siparis.jsp");
        }else
            out.print("<script>alert('Tum alanlari doldurmaniz zorunludur. Lutfen tekrar deneyin!');history.back(-1);</script>");
 
    }
%>