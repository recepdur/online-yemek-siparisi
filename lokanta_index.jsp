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
        <title>Yönetim</title>
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
                <%
                      Statement stmt = conn.createStatement();                                                             
                      ResultSet rs_lokanta_bilgi = stmt.executeQuery("SELECT * FROM v_lokanta_bilgi WHERE lokanta_id='"+lokanta+"'"); 
                      rs_lokanta_bilgi.next();         
                %>

                    <div id="buyukkutu">
                        <form id="form1" name="form1" method="post" action="lokanta_duzenle.jsp">				
                        <table border="1">
                            <tr></br></tr>
                            <tr><td align="center" colspan="4"><h3>Lokanta Bilgileriniz</h3></td></tr>
                            <tr>
                                <td width="200">Kullanıcı Adınız</td>  <td> : </td>  <td><h4><% out.print(rs_lokanta_bilgi.getString("kullanici_ad"));%> </td>
                            </tr>
                            <tr>
                                <td>Kullanıcı Şifreniz</td> <td> : </td>  <td><h4>*****</td>
                            </tr>
                             <tr>
                                <td> Lokanta Adınız</td>  <td> : </td>  <td><h4><% out.print(rs_lokanta_bilgi.getString("lokanta_ad"));%> </td>
                            </tr>
                            <tr>
                                <td> Email Adresiniz</td> <td> : </td>  <td><h4><% out.print(rs_lokanta_bilgi.getString("lokanta_email"));%> </td>
                            </tr>
                             <tr>
                                <td> Telefonunuz</td> <td> : </td>  <td> <h4><% out.print(rs_lokanta_bilgi.getString("lokanta_tel"));%> </td>
                            </tr>
                            <tr>
                                <td> Adresiniz</td> <td> : </td>  <td><h4><% out.print(rs_lokanta_bilgi.getString("il")+" "+rs_lokanta_bilgi.getString("ilce")+" "+rs_lokanta_bilgi.getString("semt")+" "+rs_lokanta_bilgi.getString("mahalle")+" "+rs_lokanta_bilgi.getString("sokak")+". Sokak Kapı No:"+rs_lokanta_bilgi.getString("kapi_no"));%> </td>
                            </tr>
                            <tr>
                                <td></td><td></td><td> <input type="submit" name="duzenle" value="Düzenle"></td>  
                            </tr>
                        </table>				
                    </form>
                    </div>            
                            
                    <div id="buyukkutu">
                        <table align="center" border="1">
                              <tr></br></tr> <tr></br></tr> <tr></br></tr>
                             <tr><td align="center" colspan="4"><h3> Verileriniz</h3></td></tr>
   <%  
    ResultSet rs; 
    rs =stmt.executeQuery("SELECT SUM(s.siparis_miktar*ly.yemek_fiyat) FROM siparis s, lokanta_yemek ly WHERE s.yemek_id=ly.yemek_id AND s.sepet_durum='"+"true"+"' AND s.siparis_durum='"+"true"+"' AND s.lokanta_id='"+lokanta+"'"); 
    rs.next();  %> 
                            <tr height="50">
                                <td width="300">Şimdiye Kadar Toplam Cironuz </td><td> : </td><td align="center" width="150"><h3><% if(rs.getString("SUM(s.siparis_miktar*ly.yemek_fiyat)")!=null)out.print(rs.getString("SUM(s.siparis_miktar*ly.yemek_fiyat)"));%> TL</td>
                            </tr>
    <% rs =stmt.executeQuery("SELECT * FROM lokanta_yemek where yemek_fıyat=(SELECT MIN(CAST(yemek_fıyat AS FLOAT)) FROM lokanta_yemek where lokanta_id='"+lokanta+"') AND lokanta_ıd='"+lokanta+"'"); 
    rs.next();  %>
                             <tr height="50">
                                <td width="300">En Ucuz Yemek </td><td> : </td><td align="center" width="150"><h3><% out.print(rs.getString("yemek_ad"));%> - <% out.print(rs.getString("yemek_fiyat"));%>  TL</td>
                            </tr>
    <% rs =stmt.executeQuery("SELECT * FROM lokanta_yemek where yemek_fıyat=(SELECT MAX(CAST(yemek_fıyat AS FLOAT)) FROM lokanta_yemek where lokanta_id='"+lokanta+"') AND lokanta_ıd='"+lokanta+"'"); 
    rs.next();  %>
                             <tr height="50">
                                <td width="300">En Pahalı Yemek </td><td> : </td><td align="center" width="150"><h3><% out.print(rs.getString("yemek_ad"));%> - <% out.print(rs.getString("yemek_fiyat"));%>  TL</td>
                            </tr>
   <% rs =stmt.executeQuery("SELECT * FROM lokanta_yemek where yemek_fıyat=(SELECT MAX(CAST(yemek_fıyat AS FLOAT)) FROM lokanta_yemek where lokanta_id='"+lokanta+"') AND lokanta_ıd='"+lokanta+"'"); 
    rs.next();  %>
                            <tr height="50">
                                <td width="300">En Pahalı Yemek </td><td> : </td><td align="center" width="150"><h3><% out.print(rs.getString("yemek_ad"));%> - <% out.print(rs.getString("yemek_fiyat"));%>  TL</td>
                            </tr>
                          </table>				

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
