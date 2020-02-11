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
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                self.location='musteri_bolge_sec.jsp?id_il=' + val1 ;
            }
            function reload2(form)
            {
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                var val2=form.id_ilce.options[form.id_ilce.options.selectedIndex].value;
                self.location='musteri_bolge_sec.jsp?id_il='+val1 +'&id_ilce='+val2;
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

                        <form id="form1" name="form1" method="post" action="musteri_bolge_sec.jsp">
                            <table border="0">
                              <tr></br></tr>
                              <tr><td align="center" colspan="4"><h3>Sipariş Vermek istediğiniz Bölgeyi Seçiniz </h3></td></tr>
                                <%
                                    String il = request.getParameter("id_il");
                                    String ilce = request.getParameter("id_ilce");
                                    String lokanta = request.getParameter("id_lokanta");
                                    Statement stmt = conn.createStatement();

                                    out.print("<tr>");
                                    out.print("<td>İl</td><td>:</td> <td><select style=\"width:150px\"  name=\"id_il\" onchange=\"reload1(this.form)\"><option value=''>il seçin</option>");
                                    ResultSet rs_il = stmt.executeQuery("SELECT * FROM il ");
                                    while (rs_il.next()) {
                                        if (rs_il.getString("il_id").equals(il)) {
                                            out.print("<option selected value=" + rs_il.getString("il_id") + ">" + rs_il.getString("il_ad") + "</option>");
                                        } else {
                                            out.print("<option value=" + rs_il.getString("il_id") + ">" + rs_il.getString("il_ad") + "</option>");
                                        }
                                    }
                                    out.print("</select> </td>");
                                    out.print("</tr>");

                                    out.print("<tr>");
                                    out.print("<td>İlçe</td><td>:</td> <td><select style=\"width:150px\"  name=\"id_ilce\" onchange=\"reload2(this.form)\"><option value=''>ilce seçin</option>");
                                    String ilce_adi = "";
                                    if (il != null) {
                                        ResultSet rs_ilce = stmt.executeQuery("SELECT * FROM ilce WHERE il_id='" + il + "'");
                                        while (rs_ilce.next()) {
                                            if (rs_ilce.getString("ilce_id").equals(ilce)) {
                                                out.print("<option selected value=" + rs_ilce.getString("ilce_id") + ">" + rs_ilce.getString("ilce_ad") + "</option>");
                                                ilce_adi = rs_ilce.getString("ilce_ad");
                                            } else {
                                                out.print("<option value=" + rs_ilce.getString("ilce_id") + ">" + rs_ilce.getString("ilce_ad") + "</option>");
                                            }
                                        }
                                    }
                                     out.print("</select> </td>");
                                     out.print("</tr>");
                                     out.print("<tr><td></br></td></tr> </table>");
                                    
                                    
                                    if (ilce != null) 
                                    {
                                        out.print("<table border=\"0\"><tr><td align=\"center\" colspan=\"5\"><h3>Lokanta Seçiniz</h3></td></tr> ");
                                        out.print("<tr><td></br></td></tr>");
                                        
                                 
                                        out.print("<tr>");
                                             out.print("<td width=\"100\"><h4>Sepete Ekle</h4></td>");
                                             out.print("<td width=\"100\"><h4>Yemek</h4></td>");
                                             out.print("<td width=\"100\"><h4>Yemek Adı</h4></td>");
                                             out.print("<td width=\"100\"><h4>Fiyat</h4></td>");
                                             out.print("<td width=\"100\"><h4>Lokanta Adı</h4></td>");
                                             out.print("<td width=\"500\"><h4>Adres</h4></td>");
                                        out.print("</tr>");
                                        
               
                                        ResultSet rs_lokanta_yemek = stmt.executeQuery("SELECT * FROM v_lokanta_yemek_listele WHERE ilce='" + ilce_adi + "'");
                                        while (rs_lokanta_yemek.next()) 
                                        {
                                           String adres = rs_lokanta_yemek.getString("il")+" "+rs_lokanta_yemek.getString("ilce")+" "+rs_lokanta_yemek.getString("semt")+" "+rs_lokanta_yemek.getString("mahalle")+" "+rs_lokanta_yemek.getString("sokak")+".Sokak Kapı No:"+rs_lokanta_yemek.getString("kapi_no");
                                           out.print("<tr>");
                                             out.print("<td width=\"100\"><h4><a href=\"musteri_bolge_sec.jsp?lokanta_id="+rs_lokanta_yemek.getString("lokanta_id")+"&musteri_id="+musteri+"&yemek_id="+rs_lokanta_yemek.getString("yemek_id")+"\">Ekle</a></h4></td>");
                                             out.print("<td><img src="+"yemekler/"+rs_lokanta_yemek.getString("yemek_resim")+" alt=\"Smiley face\" width=\"50\" height=\"50\"></td>");
                                             out.print("<td>"+rs_lokanta_yemek.getString("yemek_ad")+"</td>");
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
            response.sendRedirect("musteri_bolge_sec.jsp");
        }
    }  
                                
%> 