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
                <div id="leftheader" onclick="location.href='musteri_index.jsp';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="musteri_index.jsp" style="text-decoration:none;"><span>Anasayfa </span></a>|
                    <a href="cikis.jsp" style="text-decoration:none;"><span> Çıkış </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div id="headermenu" class='cssmenu' >
                    <ul>
                        <li class='has-sub '><a href="musteri_bolge_sec.jsp"><span>Bölge Seçme</span></a> </li>
                        <li class='has-sub '><a href="musteri_yemek_sec.jsp"><span>Yemek Seçme</span></a> </li>
                        <li class='has-sub '><a href="musteri_sepet.jsp"><span>Sepetim</span></a> </li>
                    </ul>
                </div>

                <div id="content">	
                    <%
                        Statement stmt = conn.createStatement();
                        ResultSet rs_musteri_bilgi = stmt.executeQuery("SELECT * FROM v_musteri_bilgi WHERE musteri_id='" + musteri + "'");
                        rs_musteri_bilgi.next();
                    %>

                    <div id="buyukkutu">
                        <form id="form1" name="form1" method="post" action="musteri_duzenle.jsp">				
                            <table border="1">
                                <tr></br></tr>
                                <tr><td align="center" colspan="4"><h3>Musteri Bilgileriniz</h3></td></tr>
                                <tr>
                                    <td width="200">Kullanıcı Adınız</td>  <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("kullanici_ad"));%> </td>
                                </tr>
                                <tr>
                                    <td>Kullanıcı Şifreniz</td> <td> : </td>  <td><h4>*****</td>
                                </tr>
                                <tr>
                                    <td> Adınız</td>  <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("musteri_ad"));%> </td>
                                </tr>
                                <tr>
                                    <td> Soyadınız</td>  <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("musteri_soyad"));%> </td>
                                </tr>
                                <tr>
                                    <td> Email Adresiniz</td> <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("musteri_email"));%> </td>
                                </tr>
                                <tr>
                                    <td> Telefonunuz</td> <td> : </td>  <td> <h4><% out.print(rs_musteri_bilgi.getString("musteri_tel"));%> </td>
                                </tr>
                                <tr>
                                    <td> Adresiniz</td> <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("il") + " " + rs_musteri_bilgi.getString("ilce") + " " + rs_musteri_bilgi.getString("semt") + " " + rs_musteri_bilgi.getString("mahalle") + " " + rs_musteri_bilgi.getString("sokak") + ". Sokak Kapı No:" + rs_musteri_bilgi.getString("kapi_no"));%> </td>
                                </tr>
                                <tr>
                                    <td></td><td></td><td> <input type="submit" name="duzenle" value="Düzenle"></td>  
                                </tr>
                            </table>				
                        </form>
                    </div>            

                    <div id="buyukkutu">
                        <%
                            ResultSet rs_1 = stmt.executeQuery("SELECT SUM(s.siparis_miktar*ly.yemek_fiyat) FROM siparis s, lokanta_yemek ly WHERE s.yemek_id=ly.yemek_id AND s.sepet_durum='" + "true" + "' AND s.siparis_durum='" + "true" + "' AND s.musteri_id='" + musteri + "'");
                            rs_1.next();

                        %>
                        <table align="center" border="1">
                            <tr></br></tr> <tr></br></tr> <tr></br></tr>
                            <tr><td align="center" colspan="4"><h3> Verileriniz</h3></td></tr>
                            <tr height="50">
                                <td width="300">Şimdiye Kadar Toplam Harcamanız </td><td> : </td><td align="center" width="100"><h3><% if (rs_1.getString("SUM(s.siparis_miktar*ly.yemek_fiyat)") != null) { out.print(rs_1.getString("SUM(s.siparis_miktar*ly.yemek_fiyat)"));}%> TL</td>
                            </tr>
                        </table>				

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
