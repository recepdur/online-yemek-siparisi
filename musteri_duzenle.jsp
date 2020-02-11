<%@page import="java.security.MessageDigest"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.text.*"%>
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
                <%
                      Statement stmt = conn.createStatement();                                                             
                      ResultSet rs_musteri_bilgi = stmt.executeQuery("SELECT * FROM v_musteri_bilgi WHERE musteri_id='"+musteri+"'"); 
                      rs_musteri_bilgi.next();         
                %>

                    <div id="buyukkutu">
                        <form id="form1" name="form1" method="post" action="musteri_duzenle.jsp">				
                        <table border="1">
                            <tr></br></tr>
                            <tr><td align="center" colspan="4"><h3>Müşteri Bilgileriniz</h3></td></tr>
                            <tr>
                                <td width="200">Kullanıcı Adınız</td>  <td> : </td>  <td><h4><% out.print(rs_musteri_bilgi.getString("kullanici_ad"));%> </td>
                            </tr>
                            <tr>
                                <td>Kullanıcı Şifreniz</td> <td> : </td>  <td><input type="text" name="sifre"></input></td>
                            </tr>
                             <tr>
                                 <td>Adınız</td>  <td> : </td>  <td><input type="text" name="musteri_ad" value="<% out.print(rs_musteri_bilgi.getString("musteri_ad"));%>"></input> </td>
                            </tr>
                             <tr>
                                 <td>Soyadınız</td>  <td> : </td>  <td><input type="text" name="musteri_soyad" value="<% out.print(rs_musteri_bilgi.getString("musteri_soyad"));%>"></input> </td>
                            </tr>
                            <tr>
                                <td> Email Adresiniz</td> <td> : </td>  <td><input type="text" name="musteri_email" value="<% out.print(rs_musteri_bilgi.getString("musteri_email"));%>"></input>  </td>
                            </tr>
                             <tr>
                                <td> Telefonunuz</td> <td> : </td>  <td><input type="text" name="musteri_tel" value="<% out.print(rs_musteri_bilgi.getString("musteri_tel"));%>"></input> </td>
                            </tr>
                            <tr>
                                <td> İl</td> <td> : </td>  <td><input type="text" name="il" value="<% out.print(rs_musteri_bilgi.getString("il"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> İlce</td> <td> : </td>  <td><input type="text" name="ilce" value="<% out.print(rs_musteri_bilgi.getString("ilce"));%>"></input> </td> 
                            </tr>
                            <tr>
                                <td> Semt</td> <td> : </td>  <td><input type="text" name="semt" value="<% out.print(rs_musteri_bilgi.getString("semt"));%>"></input> </td> 
                            </tr>
                            <tr>
                                <td> Mahalle</td> <td> : </td>  <td><input type="text" name="mahalle" value="<% out.print(rs_musteri_bilgi.getString("mahalle"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> Sokak</td> <td> : </td>  <td><input type="text" name="sokak" value="<% out.print(rs_musteri_bilgi.getString("sokak"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> Kapı No</td> <td> : </td>  <td><input type="text" name="kapi_no" value="<% out.print(rs_musteri_bilgi.getString("kapi_no"));%>"></input> </td> 
                            </tr>
                            <tr>
                                <td></td><td></td><td> <input type="submit" name="form_adi" value="Güncelle"></td>  
                            </tr>
                        </table>				
                    </form>
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

<%

    if(request.getParameter("duzenle") == null )   // guncelleme yap
    {
        if(request.getParameter("sifre") != null && !request.getParameter("sifre").equals(""))
         {
                /* md5 şifreleme */
                MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(request.getParameter("sifre").getBytes());
                byte[] digest = alg.digest();
                StringBuffer hashedpasswd = new StringBuffer();
                String hx;
                for (int i = 0; i < digest.length; i++) {
                    hx = Integer.toHexString(0xFF & digest[i]);
                    if (hx.length() == 1) {
                        hx = "0" + hx;
                    }
                    hashedpasswd.append(hx);
                }
                String md5_kullanici_sifre = hashedpasswd.toString();
                
             stmt.executeUpdate("UPDATE kullanici SET kullanici_sifre='"+ md5_kullanici_sifre+"' WHERE musteri_id='"+musteri+"'");                    
         }
     
    if(request.getParameter("musteri_ad") != null && !request.getParameter("musteri_ad").equals("") 
        && request.getParameter("musteri_soyad") != null && !request.getParameter("musteri_soyad").equals("")
        && request.getParameter("musteri_email") != null && !request.getParameter("musteri_email").equals("")
        && request.getParameter("musteri_tel") != null && !request.getParameter("musteri_tel").equals("")
        && request.getParameter("il") != null && !request.getParameter("il").equals("") 
        && request.getParameter("ilce") != null && !request.getParameter("ilce").equals("")
        && request.getParameter("semt") != null && !request.getParameter("semt").equals("")
        && request.getParameter("mahalle") != null && !request.getParameter("mahalle").equals("")
        && request.getParameter("sokak") != null && !request.getParameter("sokak").equals("")
        && request.getParameter("kapi_no") != null && !request.getParameter("kapi_no").equals(""))
     {       
              stmt.executeUpdate("UPDATE musteri SET musteri_ad='"+ request.getParameter("musteri_ad")+"', musteri_soyad='"+ request.getParameter("musteri_soyad")+"', musteri_email='"+ request.getParameter("musteri_email")+"', musteri_tel='"+ request.getParameter("musteri_tel")+"' WHERE musteri_id='"+musteri+"'");                    
              ResultSet rs_musteri = stmt.executeQuery("SELECT adres_id FROM musteri WHERE musteri_id='"+musteri+"'"); 
              rs_musteri.next();  
              String adres_id = rs_musteri.getString("adres_id");
              stmt.executeUpdate("UPDATE adres SET il='"+ request.getParameter("il")+"', ilce='"+ request.getParameter("ilce")+"', semt='"+ request.getParameter("semt")+"', mahalle='"+ request.getParameter("mahalle")+"', sokak='"+ request.getParameter("sokak")+"', kapi_no='"+ request.getParameter("kapi_no")+"' WHERE adres_id='"+adres_id+"'");                    
     }
     
      response.sendRedirect("musteri_index.jsp");
   }
                                
%>