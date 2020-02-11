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
                    <div id="buyukkutu">                        
                        <form id="form1" name="form1" method="post" action="musteri_sepet.jsp">
                           <h4 align="center" >Sepetinizdeki ürünler </h4><br>
                            <table border="0">                           
                                    <tr><td></br></td></tr>                                    
                                    <tr>
                                        <td width="50"><h4>Yemek</h4></td>
                                        <td width="100"><h4>Adı</h4></td>
                                        <td width="100"><h4>Fiyatı</h4></td>
                                        <td width="100"><h4>Lokanta</h4></td>
                                        <td width="300"><h4>Lokanta Adresi</h4></td>
                                        <td width="100"><h4>Tarih</h4></td>
                                        <td width="100"><h4>Satın Al</h4></td>
                                        <td width="100"><h4>Sil</h4></td>
                                   </tr>
                                    
                                <%
                                   Statement stmt = conn.createStatement();                                                             
                                   ResultSet rs_sepet = stmt.executeQuery("SELECT * FROM v_sepetteki_yemekler WHERE musteri_id='"+musteri+"' AND siparis_durum='"+"false"+"' AND sepet_durum='"+"false"+"'"); 
                                    int s=2;
                                   while(rs_sepet.next())
                                    {
                                       String adres = rs_sepet.getString("il")+" "+rs_sepet.getString("ilce")+" "+rs_sepet.getString("semt")+" "+rs_sepet.getString("mahalle")+" "+rs_sepet.getString("sokak")+" "+rs_sepet.getString("kapi_no");
                                          if(s%2==0)
                                               out.print("<tr bgcolor=\"#9999FF\">");
                                            else
                                               out.print("<tr bgcolor=\"#EEEEFF\">");
                      
                                            out.print("<td><img src="+"yemekler/"+rs_sepet.getString("yemek_resim")+" alt=\"Smiley face\" width=\"50\" height=\"50\"></td>");
                                            out.print("<td>"+rs_sepet.getString("yemek_ad")+"</td>");
                                            out.print("<td>"+rs_sepet.getString("yemek_fiyat")+"</td>");
                                            out.print("<td>"+rs_sepet.getString("lokanta_ad")+"</td>");
                                            out.print("<td>"+adres+"</td>");
                                            out.print("<td>"+rs_sepet.getString("siparis_tarih")+"</td>");
                                            out.print("<td><a href=\"musteri_sepet_satinal.jsp?siparis_id="+rs_sepet.getString("siparis_id")+"\">Onayla</a></td>");
                                            out.print("<td><a href=\"musteri_sepet.jsp?siparis_id="+rs_sepet.getString("siparis_id")+"&sil="+"true"+"\">Sil</a></td>");                    
                                         out.print("</tr>");
                                         s++;
                                    }
                                    
                                    out.print("<tr></tr><tr><td></td><td><a href=\"raporlama.jsp?sepet_kaydet="+"true"+"&musteri_id="+musteri+"\">Sepeti Kaydet</a></td></tr>");
                                %>                              
                      
                            </table>
                        </form>
                                
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
                                
<%

    if(request.getParameter("siparis_id")!=null && request.getParameter("sil") != null )                                                                                         
    {
        String siparis_id = request.getParameter("siparis_id");
        String sil = request.getParameter("sil");

        if(sil.equals("true"))
        {
            stmt.executeUpdate("DELETE FROM siparis WHERE siparis_id='"+siparis_id+"'");            
            response.sendRedirect("musteri_sepet.jsp");
        }
    }  

     stmt.close();              
%> 