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

                <div id="content">			
                    <div id="buyukkutu">
               <form id="form1" name="form1" method="post" action="lokanta_stok.jsp">
                            <h4 align="center" >Yemek Bilgileri </h4><br>
                                <table border="0">
                                    <tr>
                                        <td width="100"><h4>Kategori</h4></td> 		
                                        <td width="200"><h4>Yemek</h4></td>
                                        <td width="100"><h4>Fiyat</h4></td>
                                        <td width="100"><h4>Güncelle</h4></td>
                                        <td width="100"><h4>Sil</h4></td>
                                    </tr>
                                    <%
                                        Statement stmt = conn.createStatement();
                                        String sorgu = "SELECT * FROM lokanta_yemek WHERE lokanta_id='"+lokanta+"'";
                                        ResultSet rs_lokanta_yemek = stmt.executeQuery(sorgu);
                                        int s=2;
                                        while (rs_lokanta_yemek.next()) 
                                        {
                                            if(s%2==0)
                                               out.print("<tr bgcolor=\"#9999FF\">");
                                            else
                                               out.print("<tr bgcolor=\"#EEEEFF\">");

                                            out.print("<td >"+ rs_lokanta_yemek.getString("kategori_ad") + "</td>");
                                            out.print("<td>" + rs_lokanta_yemek.getString("yemek_ad") + "</td>");
                                            out.print("<td>" + rs_lokanta_yemek.getString("yemek_fiyat") + "</td>");
                                            out.print("<td><a href=\"lokanta_stok.jsp?lokanta_id="+lokanta+"&yemek_id="+rs_lokanta_yemek.getString("yemek_id")+"&yemek_duzenle="+"true"+"\">Guncelle</a></td>");
                                            out.print("<td><a href=\"lokanta_stok.jsp?lokanta_id="+lokanta+"&yemek_id="+rs_lokanta_yemek.getString("yemek_id")+"&yemek_sil="+"true"+"\">Sil</a></td>");
                                            s++;
                                        }
                                       
                                    %>

                                </table>
                        </form>

                         <form id="form1" name="form1" method="post" action="lokanta_stok.jsp">                       
                                <table border="1">                                    
                                    <%
                                     if(request.getParameter("yemek_duzenle") != null)
                                        if(request.getParameter("yemek_duzenle").equals("true"))
                                        {
                                            String yemek_id = request.getParameter("yemek_id");
                                            ResultSet rs_lokanta_yemek2 = stmt.executeQuery("SELECT * FROM lokanta_yemek WHERE lokanta_id='"+lokanta+"'AND yemek_id='"+yemek_id+"'");
                                            while (rs_lokanta_yemek2.next()) 
                                            {  
                                                out.print("<tr><td>ID</td><td><input readonly=\"yes\" type=\"text\" name=\"yemek_id2\" value="+rs_lokanta_yemek2.getString("yemek_id")+"> </input></td></tr>");
                                                out.print("<tr><td>Kategori</td><td>"+ rs_lokanta_yemek2.getString("kategori_ad") +"</td></tr>");
                                                out.print("<tr><td>Yemek</td><td>"+ rs_lokanta_yemek2.getString("yemek_ad") +"</td></tr>");
                                                out.print("<tr><td>Yeni Fiyat</td><td><input type=\"text\" name=\"yeni_fiyat\" value="+rs_lokanta_yemek2.getString("yemek_fiyat")+"> </input></td></tr>");
                                                out.print("<tr><td><input type=\"submit\" value=\"Güncelle\" /></td></tr>");
                                            }
                                        }
                                    %>

                                </table>
                        </form>

                    </div>

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
    if(request.getParameter("yeni_fiyat") != null)
    {
        String yeni_fiyat = request.getParameter("yeni_fiyat");
        String yemek_id = request.getParameter("yemek_id2");
        stmt.executeUpdate("UPDATE lokanta_yemek SET yemek_fiyat='"+ yeni_fiyat +"' WHERE lokanta_id='"+lokanta+"' AND yemek_id='"+yemek_id+"'");            
        out.print("<script>  self.location='lokanta_stok.jsp'; </script>");
       // response.sendRedirect("lokanta_stok.jsp");        
    }
    
    if(request.getParameter("yemek_sil")!=null && request.getParameter("yemek_sil").equals("true") )
    {
        String yemek_id = request.getParameter("yemek_id");
        stmt.executeUpdate("DELETE FROM lokanta_yemek WHERE lokanta_id='"+lokanta+"' AND yemek_id='"+yemek_id+"'");            
        out.print("<script>  self.location='lokanta_stok.jsp'; </script>");
       // response.sendRedirect("lokanta_stok.jsp");        
    }
    stmt.close();
%>                                                           