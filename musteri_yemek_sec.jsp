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

        <script language=JavaScript> 
            function reload1(form)
            {
                var val1=form.id_kategori.options[form.id_kategori.options.selectedIndex].value;
                self.location='musteri_yemek_sec.jsp?id_kategori=' + val1 ;
            }
            function reload2(form)
            {
                var val1=form.id_kategori.options[form.id_kategori.options.selectedIndex].value;
                var val2=form.id_yemek.options[form.id_yemek.options.selectedIndex].value;
                self.location='musteri_yemek_sec.jsp?id_kategori='+val1 +'&id_yemek='+val2;
            }
        </script>
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
                      
                        <form id="form1" name="form1" method="post" action="musteri_yemek_sec.jsp">
                            <table border="0">
                                <tr></br></tr>
                                <tr><td align="center" colspan="4"><h3>Sipariş Vermek istediğiniz Yemeği Seçiniz </h3></td></tr>
                       
                                <%
                                    String kategori = request.getParameter("id_kategori");
                                    String yemek = request.getParameter("id_yemek");
                                    String lokanta = request.getParameter("id_lokanta");
                                    Statement stmt = conn.createStatement();

                                    out.print("<tr>");
                                    out.print("<td>Yemek Kategorisi</td><td>:</td> <td><select style=\"width:150px\"  name=\"id_kategori\" onchange=\"reload1(this.form)\"><option value=''>Kategori Seçin</option>");
                                    ResultSet rs_kategori = stmt.executeQuery("SELECT * FROM kategori_liste ");
                                    while (rs_kategori.next()) {
                                        if (rs_kategori.getString("kategori_liste_id").equals(kategori)) {
                                            out.print("<option selected value=" + rs_kategori.getString("kategori_liste_id") + ">" + rs_kategori.getString("kategori_liste_ad") + "</option>");
                                        } else {
                                            out.print("<option value=" + rs_kategori.getString("kategori_liste_id") + ">" + rs_kategori.getString("kategori_liste_ad") + "</option>");
                                        }
                                    }
                                    out.print("</select> </td>");
                                    out.print("</tr>");

                                    out.print("<tr>");
                                    out.print("<td>Yemek Adı</td><td>:</td> <td><select style=\"width:150px\"  name=\"id_yemek\" onchange=\"reload2(this.form)\"><option value=''>Yemek Seçin</option>");
                                    String yemek_adi = "";
                                    if (kategori != null) {
                                        ResultSet rs_yemek = stmt.executeQuery("SELECT * FROM yemek_liste WHERE kategori_liste_id='" + kategori + "'");
                                        while (rs_yemek.next()) {
                                            if (rs_yemek.getString("yemek_liste_id").equals(yemek)) {
                                                out.print("<option selected value=" + rs_yemek.getString("yemek_liste_id") + ">" + rs_yemek.getString("yemek_liste_ad") + "</option>");
                                                yemek_adi = rs_yemek.getString("yemek_liste_ad");
                                            } else {
                                                out.print("<option value=" + rs_yemek.getString("yemek_liste_id") + ">" + rs_yemek.getString("yemek_liste_ad") + "</option>");
                                            }
                                        }
                                    }
                                     out.print("</select> </td>");
                                     out.print("</tr>");
                                     out.print("<tr><td></br></td></tr> </table>");
                                    
                                    
                                    if (yemek != null) 
                                    {
                                        out.print("<table border=\"0\"><tr><td align=\"center\" colspan=\"5\"><h3>Lokanta Seçiniz</h3></td></tr> ");
                                        out.print("<tr><td></br></td></tr>");
                                        
                                 
                                        out.print("<tr>");
                                             out.print("<td width=\"100\"><h4>Sepete Ekle</h4></td>");
                                             out.print("<td width=\"100\"><h4>Yemek</h4></td>");
                                             out.print("<td width=\"100\"><h4>Fiyat</h4></td>");
                                             out.print("<td width=\"100\"><h4>Lokanta Adı</h4></td>");
                                             out.print("<td width=\"500\"><h4>Adres</h4></td>");
                                        out.print("</tr>");
                                        
               
                                        ResultSet rs_lokanta_yemek = stmt.executeQuery("SELECT * FROM v_lokanta_yemek_listele WHERE yemek_ad='" + yemek_adi + "'");
                                        while (rs_lokanta_yemek.next()) 
                                        {
                                           String adres = rs_lokanta_yemek.getString("il")+" "+rs_lokanta_yemek.getString("ilce")+" "+rs_lokanta_yemek.getString("semt")+" "+rs_lokanta_yemek.getString("mahalle")+" "+rs_lokanta_yemek.getString("sokak")+".Sokak Kapı No:"+rs_lokanta_yemek.getString("kapi_no");
                                           out.print("<tr>");
                                             out.print("<td width=\"100\"><h4><a href=\"musteri_yemek_sec.jsp?lokanta_id="+rs_lokanta_yemek.getString("lokanta_id")+"&musteri_id="+musteri+"&yemek_id="+rs_lokanta_yemek.getString("yemek_id")+"\">Ekle</a></h4></td>");
                                             out.print("<td><img src="+"yemekler/"+rs_lokanta_yemek.getString("yemek_resim")+" alt=\"Smiley face\" width=\"50\" height=\"50\"></td>");
                                             out.print("<td>"+rs_lokanta_yemek.getString("yemek_fiyat")+"</td>");
                                             out.print("<td>"+rs_lokanta_yemek.getString("lokanta_ad")+"</td>");
                                             out.print("<td>"+adres+"</td>");
                                           out.print("</tr>");                                           
                                             
                                        }
                                     
                                    }
                                    
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

    if(request.getParameter("lokanta_id")!=null && request.getParameter("musteri_id") != null && request.getParameter("yemek_id") != null)                                                                                         
    {
        String lokanta_id = request.getParameter("lokanta_id");
        String musteri_id = request.getParameter("musteri_id");
        String yemek_id = request.getParameter("yemek_id");
        String date = new SimpleDateFormat("dd.MM.yyyy HH-mm-ss").format(new java.util.Date());
                
        if(!lokanta_id.equals("") && !musteri_id.equals("") && !yemek_id.equals(""))
        {
            stmt.executeUpdate("INSERT INTO siparis(lokanta_id, yemek_id, musteri_id, siparis_tarih, siparis_miktar, siparis_durum, sepet_durum) VALUES ('"+lokanta_id+"','"+yemek_id+"','"+musteri_id+"','"+date+"','"+"1"+"','"+"false"+"','"+"false"+"')");            
            stmt.close();
            out.print("<script>alert('Seçilen yemek sepetinize eklendi.')</script>");
            response.sendRedirect("musteri_yemek_sec.jsp");
        }
    }  
                                
%> 