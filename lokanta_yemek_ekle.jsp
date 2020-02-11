<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>
<%
    String login = (String)session.getAttribute("lokanta_login");
    String lokanta = (String) session.getAttribute("lokanta_id");
    if (login != "true") {
        response.sendRedirect("index.jsp");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Yemek Ekle</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />
        <script language=JavaScript> 
            function reload1(form)
            {
                var val1=form.id_kategori.options[form.id_kategori.options.selectedIndex].value;
                self.location='lokanta_yemek_ekle.jsp?id_kategori=' + val1 ;
            }
            function reload2(form)
            {
                var val1=form.id_kategori.options[form.id_kategori.options.selectedIndex].value;
                var val2=form.id_yemek.options[form.id_yemek.options.selectedIndex].value;
                self.location='lokanta_yemek_ekle.jsp?id_kategori='+val1 +'&id_yemek='+val2;
            }
       
        </script>
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
                    <div id="yeniurunekle">
                        <h1><br>Yemek Ekle</h1>

                        <form id="form1" name="form1" method="post" action="lokanta_yemek_ekle.jsp">
                            <table border="0">

                                <%
                                    String kategori = request.getParameter("id_kategori");
                                    String yemek = request.getParameter("id_yemek");
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
                                    if (kategori != null) {
                                        ResultSet rs_yemek = stmt.executeQuery("SELECT * FROM yemek_liste WHERE kategori_liste_id='" + kategori + "'");
                                        while (rs_yemek.next()) {
                                            if (rs_yemek.getString("yemek_liste_id").equals(yemek)) {
                                                out.print("<option selected value=" + rs_yemek.getString("yemek_liste_id") + ">" + rs_yemek.getString("yemek_liste_ad") + "</option>");
                                            } else {
                                                out.print("<option value=" + rs_yemek.getString("yemek_liste_id") + ">" + rs_yemek.getString("yemek_liste_ad") + "</option>");
                                            }
                                        }
                                    }
                                    out.print("</select> </td>");
                                    out.print("</tr>");

                                %>					
                                <tr>
                                    <td width="150">Yemek Fiyatı</td> <td>:</td> 
                                    <td> <input style="width:150px" type="text" name="yemek_fiyat"> </td>
                                </tr>                             
                                <tr>
                                    <td width="150">Yemek Resim</td> <td>:</td> 
                                    <td> <input style="width:150px" type="file" name="yemek_resim"> </td>
                                </tr>
                                <tr>
                                    <td> <br> </td> 						
                                </tr>
                                <tr>
                                    <td> <input type="submit" name="form_adi" value="Ekle"></td> 						
                                </tr>
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

            
            
    if (request.getParameter("yemek_fiyat") != null) // check input
    {
        String yemek_fiyat = request.getParameter("yemek_fiyat");
        String yemek_resim = request.getParameter("yemek_resim");

        if (!yemek_fiyat.equals("")) // check input
        {
            ResultSet rs_kategori2 = stmt.executeQuery("SELECT * FROM kategori_liste WHERE kategori_liste_id='" + kategori + "'");
            rs_kategori2.next();
            String kategori_ad = rs_kategori2.getString("kategori_liste_ad");
            ResultSet rs_yemek2 = stmt.executeQuery("SELECT * FROM yemek_liste WHERE yemek_liste_id='" + yemek + "'");
            rs_yemek2.next();
            String yemek_ad = rs_yemek2.getString("yemek_liste_ad");
            
            stmt.executeUpdate("INSERT INTO lokanta_yemek(yemek_ad, kategori_ad, yemek_fiyat, yemek_resim, lokanta_id) VALUES ('"+yemek_ad+"','"+kategori_ad+"','"+yemek_fiyat+"','"+yemek_resim+"','"+lokanta+"')");            
            stmt.close();

            out.print("<script>alert('Yemek eklendi..');</script>");
            response.sendRedirect("lokanta_yemek_ekle.jsp");

        } else {
            out.print("<script>alert('Tum alanlari doldurmaniz zorunludur. Lutfen tekrar deneyin!');history.back(-1);</script>");
            response.sendRedirect("lokanta_yemek_ekle.jsp");
        }

    }


%>