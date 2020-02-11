<%@page import="java.security.MessageDigest"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.text.*"%>
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
                    <%
                      Statement stmt = conn.createStatement();                                                             
                      ResultSet rs_yonetici = stmt.executeQuery("SELECT * FROM yonetici WHERE yonetici_id='"+yonetici+"'"); 
                      rs_yonetici.next();         
                    %>
                <div id="buyukkutu">
                    <form id="form1" name="form1" method="post" action="yonetici_profil.jsp">				
                        <table border="1">
                            <tr></br></tr>
                            <tr><td align="center" colspan="4"><h3>Yonetici Bilgileriniz</h3></td></tr>
                            <tr>
                                <td width="200">Kullanıcı Adınız</td>  <td> : </td>  <td><input type="text" name="yonetici_ad" value="<% out.print(rs_yonetici.getString("yonetici_ad"));%>"> </input> </td>
                            </tr>
                            <tr>
                                <td>Kullanıcı Şifreniz</td> <td> : </td>  <td><h4><input type="text" name="yonetici_sifre" value="*****"></input></td>
                            </tr>                          
                                <td></td><td></td><td> <input type="submit" name="duzenle" value="Güncelle"></td>  
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

    if(request.getParameter("duzenle") != null)
    {
          if(request.getParameter("yonetici_ad") != null && !request.getParameter("yonetici_ad").equals(""))
          {
               stmt.executeUpdate("UPDATE yonetici SET yonetici_ad='"+ request.getParameter("yonetici_ad")+"' WHERE yonetici_id='"+yonetici+"'");                    
          }
          
          if(request.getParameter("yonetici_sifre") != null && !request.getParameter("yonetici_sifre").equals("") && !request.getParameter("yonetici_sifre").equals("*****"))
          {
                /* md5 şifreleme */
                MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(request.getParameter("yonetici_sifre").getBytes());
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
                String md5_sifre = hashedpasswd.toString();
                
             stmt.executeUpdate("UPDATE yonetici SET yonetici_sifre='"+ md5_sifre+"' WHERE yonetici_id='"+yonetici+"'");                    

          }
               
       response.sendRedirect("yonetici_index.jsp");
    }

                                
%>