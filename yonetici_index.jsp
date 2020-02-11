<%@page import="java.text.*"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>

<%

    String login = (String) session.getAttribute("yonetici_login");
    String yonetici = (String) session.getAttribute("yonetici_id");
    if (login != "true") {
        response.sendRedirect("index.jsp");
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Yönetici Sayfası</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='yonetici_index.jsp';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="yonetici_index.jsp" style="text-decoration:none;"><span>Yönetim </span></a>|
                    <a href="yonetici_profil.jsp" style="text-decoration:none;"><span>Profil </span></a>|
                    <a href="cikis.jsp" style="text-decoration:none;"><span> Çıkış </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div class='cssmenu'>
                    <ul>	
                        <li class='has-sub '><a href='#'><span></br></span></a> </li>
                    </ul>
                </div>

                <div id="buyukkutu">
                    <table border="0">
                        <tr></br></tr>
                        <tr><td align="center" colspan="3"><h3>Müşteri Bilgileri</h3></td></tr>      
                        <tr>
                            <td width="100"><h4>ID</h4></td> 
                            <td width="100"><h4>Ad</h4></td> 
                            <td width="100"><h4>Soyad</h4></td> 		
                        </tr>
                        <%
                            Statement stmt = conn.createStatement();
                            ResultSet rs_musteri = stmt.executeQuery("SELECT * FROM MUSTERI");
                            int s = 2;
                            while (rs_musteri.next()) {
                                if (s % 2 == 0) {
                                    out.print("<tr bgcolor=\"#9999FF\">");
                                } else {
                                    out.print("<tr bgcolor=\"#EEEEFF\">");
                                }

                                out.print("<td><a href=\"yonetici_musteri.jsp?musteri_id=" + rs_musteri.getString("musteri_id") + "\">" + rs_musteri.getString("musteri_id") + "</td>");
                                out.print("<td>" + rs_musteri.getString("musteri_ad") + "</td>");
                                out.print("<td>" + rs_musteri.getString("musteri_soyad") + "</td>");
                                out.print("</tr>");
                                s++;
                            }
                        %>

                    </table>
                </div>
                <div id="buyukkutu">
                    <table border="0">
                        <tr></br></tr>
                        <tr><td align="center" colspan="3"><h3>Lokanta Bilgileri</h3></td></tr>  
                        <tr>
                            <td width="100"><h4>ID</h4></td> 
                            <td width="100"><h4>Ad</h4></td> 
                            <td width="100"><h4>Onay</h4></td> 		
                        </tr>
                        <%
                            ResultSet rs_lokanta = stmt.executeQuery("SELECT * FROM lokanta");
                            s = 2;
                            while (rs_lokanta.next()) {
                                if (s % 2 == 0) {
                                    out.print("<tr bgcolor=\"#9999FF\">");
                                } else {
                                    out.print("<tr bgcolor=\"#EEEEFF\">");
                                }

                                out.print("<td><a href=\"yonetici_lokanta.jsp?lokanta_id=" + rs_lokanta.getString("lokanta_id") + "\">" + rs_lokanta.getString("lokanta_id") + "</td>");
                                out.print("<td>" + rs_lokanta.getString("lokanta_ad") + "</td>");
                                out.print("<td>" + rs_lokanta.getString("yonetici_onay") + "</td>");
                                out.print("</tr>");
                                s++;
                            }
                         out.print("<tr><td></td><td><a href=\"raporlama.jsp?yonetici_kaydet="+"true"+"\">Verileri Kaydet</a></td></tr>");

                        %>              

                    </table>                         
                </div>
                <div id="buyukkutu">
                    <table border="0">
                        <tr><td></br><td></tr>
                                    <tr><td align="center" colspan="3"><h3>İstatistikler </h3></td></tr>    
                                    <%
                                        ResultSet rs;
                                        rs = stmt.executeQuery("SELECT s.musteri_id FROM sıparıs s, musteri m WHERE m.musteri_ıd=s.musteri_id AND s.sepet_durum='true' GROUP BY s.musteri_id HAVING count(*)=(SELECT max(count(*)) FROM sıparıs s WHERE s.sepet_durum='true' GROUP BY s.musteri_ıd)");
                                        rs.next();
                                    %>                        
                                    <tr><td width="200">En çok sipariş veren müşteri </td><td width="100"><h4><% if(rs.getString("musteri_id") != null)out.print("<a href=\"yonetici_musteri.jsp?musteri_id=" + rs.getString("musteri_id") + "\">" + rs.getString("musteri_id"));%></h4></td></tr> 
                                    <%
                                        rs = stmt.executeQuery("SELECT s.lokanta_ıd FROM sıparıs s, lokanta l WHERE l.lokanta_ıd=s.lokanta_ıd AND s.sıparıs_durum='true' GROUP BY s.lokanta_ıd HAVING count(*)=(SELECT max(count(*)) FROM sıparıs s WHERE s.sıparıs_durum='true' GROUP BY s.lokanta_ıd)");
                                        rs.next();
                                    %>
                                    <tr><td width="300">En çok sipariş alan lokanta</td><td width="100"><h4><% if(rs.getString("lokanta_id") != null)out.print("<a href=\"yonetici_lokanta.jsp?lokanta_id=" + rs.getString("lokanta_id") + "\">" + rs.getString("lokanta_id"));%></h4></td></tr> 

                                    <%    rs = stmt.executeQuery("SELECT COUNT(musteri_id) FROM musteri");
                                        rs.next();
                                    %>                    
                                    <tr><td width="200">Toplam müşteri sayısı</td><td width="100"><h4><% if(rs.getString("COUNT(musteri_id)") != null) out.print(rs.getString("COUNT(musteri_id)"));%></h4></td></tr> 
                                    <%    rs = stmt.executeQuery("SELECT count(lokanta_id) from lokanta");
                                        rs.next();
                                    %>                        
                                    <tr><td width="200">Toplam lokanta sayısı</td><td width="100"><h4><% if(rs.getString("COUNT(lokanta_id)") != null) out.print(rs.getString("COUNT(lokanta_id)"));%></h4></td></tr>                       
                                    <%    rs = stmt.executeQuery("SELECT count(siparis_id) from siparis");
                                        rs.next();
                                    %>                        
                                    <tr><td width="200">Toplam sipariş sayısı</td><td width="100"><h4><% if(rs.getString("COUNT(siparis_id)") != null)out.print(rs.getString("COUNT(siparis_id)"));%></h4></td></tr>                       

                                    <%    rs = stmt.executeQuery("SELECT ad.ıl FROM adres ad GROUP BY ad.ıl HAVING count(*)=(SELECT max(count(*)) FROM adres ad GROUP BY ad.ıl)");
                                        rs.next();
                                    %>                        
                                    <tr><td width="200">En çok üye olunan il</td><td width="100"><h4><% if(rs.getString("il") != null) out.print(rs.getString("il"));%></h4></td></tr>                       

                                    <%    rs = stmt.executeQuery("SELECT te.teslım_eden_ad,te.teslım_eden_soyad FROM teslım_eden te GROUP BY te.teslım_eden_ad, te.teslım_eden_soyad HAVING count(*)= (SELECT max(count(*)) FROM teslım_eden te GROUP BY te.teslım_eden_ad, te.teslım_eden_soyad)");
                                              rs.next();%>
                                    <tr><td width="300">En çok sipariş teslim eden çalışan</td><td width="100"><h4><% if(rs.getString("teslım_eden_ad")!=null) out.print(rs.getString("teslım_eden_ad"));%>-<% out.print(rs.getString("teslım_eden_soyad"));%></h4></td></tr>                       

                                    </table>      
                                    <div class="clearboth"></div> <!-- Float Temizleyici-->		
                                    </div>

                                    <div id="footer">
                                        <p>
                                            <a href="yonetici_giris.jsp" style="text-decoration:none;"><span>Admin:</span></a>    &copy; By <a href="http://dev.cs.hacettepe.edu.tr/~b20926305/cv/" style="text-decoration:none;"> <span>Recep Dur</span></a> - <a href="#" style="text-decoration:none;"><span>Yahya Yalçın</span> </a>
                                        </p>
                                    </div>
                                    </div>
                                    </body>
                                    </html>
