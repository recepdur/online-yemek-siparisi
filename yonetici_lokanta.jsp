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
                        <li class='has-sub '><a href='#'><span></span></a> </li>
                    </ul>
                </div>

                <div id="content">			
                    <div id="buyukkutu">
                        <form id="form1" name="form1" method="post" action="yonetici_lokantalar.jsp">
                            <h4 align="center" >Lokanta Bilgileri </h4><br>
                                <table border="0">
                                    <tr>
                                        <td width="100"><h4>Ad</h4></td> 		
                                        <td width="100"><h4>Telefon</h4></td>
                                        <td width="200"><h4>Email</h4></td>
                                        <td width="300"><h4>Adres </h4></td>
                                        <td width="100"><h4>Yönetici Onayı </h4></td>
                                        <td width="50"><h4>Onayla</h4></td>


                                    </tr>
                                    <%
                                        String lokanta = request.getParameter("lokanta_id");

                                        Statement stmt = conn.createStatement();
                                        String sorgu = "SELECT * FROM V_LOKANTA_BILGI WHERE lokanta_id='"+lokanta+"'";
                                        ResultSet rs_yonetici = stmt.executeQuery(sorgu);
                                        int s=2;
                                        while (rs_yonetici.next()) 
                                        {
                                            String adres = rs_yonetici.getString("il") + " " + rs_yonetici.getString("ilce")+ " " + rs_yonetici.getString("semt")+ " " + rs_yonetici.getString("mahalle")+ " " + rs_yonetici.getString("sokak")+ " " + rs_yonetici.getString("kapi_no") ;
                                           if(s%2==0)
                                               out.print("<tr bgcolor=\"#9999FF\">");
                                            else
                                               out.print("<tr bgcolor=\"#EEEEFF\">");
                                            out.print("<td >" +rs_yonetici.getString("lokanta_ad") + "</td>");
                                            out.print("<td>" + rs_yonetici.getString("lokanta_tel") + "</td>");
                                            out.print("<td>" + rs_yonetici.getString("lokanta_email") + "</td>");
                                            out.print("<td>" + adres + " </td>");
                                            out.print("<td>" + rs_yonetici.getString("yonetici_onay") + "</td>");
                                            if(rs_yonetici.getString("yonetici_onay").equals("false"))
                                               out.print("<td><a href=\"yonetici_lokantalar.jsp?lokanta_id="+lokanta+"&onayla="+"true"+"\">Onayla</a></td>");
                                           else
                                               out.print("<td>ONAYLANDI</td>");
                                            out.print("</tr>");
                                            s++;
                                        }
                                    %>

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
    if( request.getParameter("onayla")!=null)
    {
       String onayla = request.getParameter("onayla");
       if(onayla.equals("true"))
       {
            stmt.executeUpdate("UPDATE lokanta SET yonetici_onay='"+"true"+"' WHERE lokanta_id='"+lokanta+"'");            
            response.sendRedirect("yonetici_index.jsp");         
       }
    }
                                        
    stmt.close();
%>                                                                                                         
                                    