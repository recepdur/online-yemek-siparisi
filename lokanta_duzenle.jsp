<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.security.MessageDigest"%>
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
                                <td>Kullanıcı Şifreniz</td> <td> : </td>  <td><input type="text" name="sifre"></input></td>
                            </tr>
                             <tr>
                                 <td> Lokanta Adınız</td>  <td> : </td>  <td><input type="text" name="lokanta_ad" value="<% out.print(rs_lokanta_bilgi.getString("lokanta_ad"));%>"></input> </td>
                            </tr>
                            <tr>
                                <td> Email Adresiniz</td> <td> : </td>  <td><input type="text" name="lokanta_email" value="<% out.print(rs_lokanta_bilgi.getString("lokanta_email"));%>"></input>  </td>
                            </tr>
                             <tr>
                                <td> Telefonunuz</td> <td> : </td>  <td><input type="text" name="lokanta_tel" value="<% out.print(rs_lokanta_bilgi.getString("lokanta_tel"));%>"></input> </td>
                            </tr>
                            <tr>
                                <td> İl</td> <td> : </td>  <td><input type="text" name="il" value="<% out.print(rs_lokanta_bilgi.getString("il"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> İlce</td> <td> : </td>  <td><input type="text" name="ilce" value="<% out.print(rs_lokanta_bilgi.getString("ilce"));%>"></input> </td> 
                            </tr>
                            <tr>
                                <td> Semt</td> <td> : </td>  <td><input type="text" name="semt" value="<% out.print(rs_lokanta_bilgi.getString("semt"));%>"></input> </td> 
                            </tr>
                            <tr>
                                <td> Mahalle</td> <td> : </td>  <td><input type="text" name="mahalle" value="<% out.print(rs_lokanta_bilgi.getString("mahalle"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> Sokak</td> <td> : </td>  <td><input type="text" name="sokak" value="<% out.print(rs_lokanta_bilgi.getString("sokak"));%>"></input> </td> 
                            </tr>
                             <tr>
                                <td> Kapı No</td> <td> : </td>  <td><input type="text" name="kapi_no" value="<% out.print(rs_lokanta_bilgi.getString("kapi_no"));%>"></input> </td> 
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
                
             stmt.executeUpdate("UPDATE kullanici SET kullanici_sifre='"+ md5_kullanici_sifre+"' WHERE lokanta_id='"+lokanta+"'");                    
         }
     
    if(request.getParameter("lokanta_ad") != null && !request.getParameter("lokanta_ad").equals("") 
        && request.getParameter("lokanta_email") != null && !request.getParameter("lokanta_email").equals("")
        && request.getParameter("lokanta_tel") != null && !request.getParameter("lokanta_tel").equals("")
        && request.getParameter("il") != null && !request.getParameter("il").equals("") 
        && request.getParameter("ilce") != null && !request.getParameter("ilce").equals("")
        && request.getParameter("semt") != null && !request.getParameter("semt").equals("")
        && request.getParameter("mahalle") != null && !request.getParameter("mahalle").equals("")
        && request.getParameter("sokak") != null && !request.getParameter("sokak").equals("")
        && request.getParameter("kapi_no") != null && !request.getParameter("kapi_no").equals(""))
     {       
              stmt.executeUpdate("UPDATE lokanta SET lokanta_ad='"+ request.getParameter("lokanta_ad")+"', lokanta_email='"+ request.getParameter("lokanta_email")+"', lokanta_tel='"+ request.getParameter("lokanta_tel")+"' WHERE lokanta_id='"+lokanta+"'");                    
              ResultSet rs_lokanta = stmt.executeQuery("SELECT adres_id FROM lokanta WHERE lokanta_id='"+lokanta+"'"); 
              rs_lokanta.next();  
              String adres_id = rs_lokanta.getString("adres_id");
              stmt.executeUpdate("UPDATE adres SET il='"+ request.getParameter("il")+"', ilce='"+ request.getParameter("ilce")+"', semt='"+ request.getParameter("semt")+"', mahalle='"+ request.getParameter("mahalle")+"', sokak='"+ request.getParameter("sokak")+"', kapi_no='"+ request.getParameter("kapi_no")+"' WHERE adres_id='"+adres_id+"'");                    
     }
     
      response.sendRedirect("lokanta_index.jsp");
   }
                                
%>