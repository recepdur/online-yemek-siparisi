<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.security.MessageDigest"%>
<%@include file="baglanti.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Yonetici Girişi</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />

    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='#';" style="cursor:pointer;">
                    <div class="logo"><span>Online Yemek Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="index.jsp" style="text-decoration:none;"><span>Anasayfa </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div class='cssmenu'>
                    <ul>	
                        <li class='has-sub '><a href='index.jsp'><span></br></span></a>

                        </li>

                    </ul>
                </div>
                <div id="giris">
                    <h1> Yönetici Girişi</h1>
                    <form id="form1" name="form1" method="post" action="yonetici_giris.jsp">				
                        <table>
                            <tr>
                                <td> Admin Adı </td>  <td>:</td>  <td><input type="text" name="yonetici_ad">  </td>
                            </tr>
                            <tr>
                                <td> Şifre </td>   <td>:</td>  <td><input type="password" name="yonetici_sifre">  </td>
                            </tr>
                            <tr>
                                <td> <input type="submit" name="form_adi" value="Giriş"></td>  <td></td>  
                            </tr>
                        </table>				
                    </form>
                    <%

                        if (request.getParameter("yonetici_ad") != null && request.getParameter("yonetici_sifre") != null) {
                            if (!(request.getParameter("yonetici_ad").equals("")) && !(request.getParameter("yonetici_sifre").equals(""))) {
                                String admin = request.getParameter("yonetici_ad");
                                String sifre = request.getParameter("yonetici_sifre");
                                Statement stmt = conn.createStatement();
                                
                                /* md5 şifreleme */
                                MessageDigest alg = MessageDigest.getInstance("MD5");
                                alg.reset();
                                alg.update(sifre.getBytes());
                                byte[] digest = alg.digest();
                                StringBuffer hashedpasswd = new StringBuffer();
                                String hx;
                                for (int i=0;i<digest.length;i++){
                                        hx =  Integer.toHexString(0xFF & digest[i]);
                                        if(hx.length() == 1){hx = "0" + hx;}
                                        hashedpasswd.append(hx);
                                }
                                String md5_sifre=hashedpasswd.toString();
                                
                                String sorgu = "SELECT * FROM YONETICI WHERE yonetici_ad='" + admin + "' AND yonetici_sifre='" + md5_sifre + "'";
                                ResultSet rs = stmt.executeQuery(sorgu);
                                if (rs.next()) {
                                    session.setAttribute("yonetici_login", "true");
                                    session.setAttribute("yonetici_id", rs.getString("yonetici_id"));
                                    response.sendRedirect("yonetici_index.jsp");
                                } else {
                                    out.print("Yönetici adı veya şifre hatalı");
                                }
                                stmt.close();
                            }
                        }
                    %>
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


