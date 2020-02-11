<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/HTML; charset=ISO-8859-9" />
        <title>Lokanta Kayıt</title>
        <link href="styles.css" rel="stylesheet" type="text/css" />
        <script language=JavaScript> 
            function reload1(form)
            {
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                self.location='lokanta_yeni.jsp?id_il=' + val1 ;
            }
            function reload2(form)
            {
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                var val2=form.id_ilce.options[form.id_ilce.options.selectedIndex].value;
                self.location='lokanta_yeni.jsp?id_il='+val1 +'&id_ilce='+val2;
            }
            function reload3(form)
            {
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                var val2=form.id_ilce.options[form.id_ilce.options.selectedIndex].value;
                var val3=form.id_semt.options[form.id_semt.options.selectedIndex].value;
                self.location='lokanta_yeni.jsp?id_il='+val1 +'&id_ilce=' + val2 + '&id_semt=' + val3; 
            }
            function reload4(form)
            {
                var val1=form.id_il.options[form.id_il.options.selectedIndex].value;
                var val2=form.id_ilce.options[form.id_ilce.options.selectedIndex].value;
                var val3=form.id_semt.options[form.id_semt.options.selectedIndex].value;
                var val4=form.id_mahalle.options[form.id_mahalle.options.selectedIndex].value;
                self.location='lokanta_yeni.jsp?id_il='+val1 +'&id_ilce=' + val2 + '&id_semt=' + val3 + '&id_mahalle=' + val4; 
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div id="header">
                <div id="leftheader" onclick="location.href='index.jsp';" style="cursor:pointer;">
                    <div class="logo">Online Yemek <span>Siparişi</span></div>
                </div>
                <div id="rightheader">	
                    <a href="index.jsp" style="text-decoration:none;"><span>Anasayfa </span></a>|
                    <a href="musteri_giris.jsp" style="text-decoration:none;"><span>Müşteri Girişi </span></a>|
                    <a href="lokanta_giris.jsp" style="text-decoration:none;"><span>Lokanta Girişi </span></a>
                </div>
            </div>
            <div id="mainpage">

                <div class='cssmenu'>
                    <ul>	
                        <li class='has-sub '><a href='giris.php'><span>Meyve-Sebze</span></a>
                            <ul>
                                <li class=''><a href='giris.php'><span>Meyve</span></a></li>
                                <li class=''><a href='giris.php'><span>Sebze</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <div id="yenikayit">
                    <h1><br> Lokanta Yeni Kayıt Ekranı</h1>

                    <form method="post" name=f1 action="lokanta_yeni_ekle.jsp">
                        <table border="0">					
                            <tr>
                                <td colspan="3" align="center"><h4>Adres Bilgilerini Giriniz</h4></td>
                            </tr>
                            <%
                                String il = request.getParameter("id_il");
                                String ilce = request.getParameter("id_ilce");
                                String semt = request.getParameter("id_semt");
                                String mahalle = request.getParameter("id_mahalle");
                                Statement stmt = conn.createStatement();

                                out.print("<tr>");
                                out.print("<td>İl Seçiniz</td><td>:</td> <td><select style=\"width:150px\"  name=\"id_il\" onchange=\"reload1(this.form)\"><option value=''>il seçiniz</option>");
                                ResultSet rs_il = stmt.executeQuery("SELECT * FROM IL ");
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
                                out.print("<td>İlçe Seçiniz</td><td>:</td><td><select style=\"width:150px\"  name=\"id_ilce\" onchange=\"reload2(this.form)\"><option value=''>ilçe seçiniz</option>");
                                if (il != null) {
                                    ResultSet rs_ilce = stmt.executeQuery("SELECT * FROM ILCE WHERE il_id='" + il + "'");
                                    while (rs_ilce.next()) {
                                        if (rs_ilce.getString("ilce_id").equals(ilce)) {
                                            out.print("<option selected value=" + rs_ilce.getString("ilce_id") + ">" + rs_ilce.getString("ilce_ad") + "</option>");
                                        } else {
                                            out.print("<option value=" + rs_ilce.getString("ilce_id") + ">" + rs_ilce.getString("ilce_ad") + "</option>");
                                        }
                                    }
                                }
                                out.print("</select> </td>");
                                out.print("</tr>");

                                out.print("<tr>");
                                out.print("<td>Semt Seçiniz</td><td>:</td><td><select style=\"width:150px\"  name=\"id_semt\" onchange=\"reload3(this.form)\"><option value=''>Semt seçiniz</option>");
                                if (ilce != null) {
                                    ResultSet rs_semt = stmt.executeQuery("SELECT * FROM SEMT WHERE ilce_id='" + ilce + "'");
                                    while (rs_semt.next()) {
                                        if (rs_semt.getString("semt_id").equals(semt)) {
                                            out.print("<option selected value=" + rs_semt.getString("semt_id") + ">" + rs_semt.getString("semt_ad") + "</option>");
                                        } else {
                                            out.print("<option value=" + rs_semt.getString("semt_id") + ">" + rs_semt.getString("semt_ad") + "</option>");
                                        }
                                    }
                                }
                                out.print("</select> </td>");
                                out.print("</tr>");

                                out.print("<tr>");
                                out.print("<td>Mahalle Seçiniz</td><td>:</td><td><select style=\"width:150px\"  name=\"id_mahalle\" onchange=\"reload4(this.form)\"><option value=''>Mahalle seçiniz</option>");
                                if (semt != null) {
                                    ResultSet rs_mahalle = stmt.executeQuery("SELECT * FROM MAHALLE WHERE semt_id='" + semt + "'");
                                    while (rs_mahalle.next()) {
                                        if (rs_mahalle.getString("mahalle_id").equals(mahalle)) {
                                            out.print("<option selected value=" + rs_mahalle.getString("mahalle_id") + ">" + rs_mahalle.getString("mahalle_ad") + "</option>");
                                        } else {
                                            out.print("<option value=" + rs_mahalle.getString("mahalle_id") + ">" + rs_mahalle.getString("mahalle_ad") + "</option>");
                                        }
                                    }
                                }
                                out.print("</select> </td>");
                                out.print("</tr>");

                            %>						
                            <tr>
                                <td>Sokak </td><td>:</td> <td><input type="text" name="lokanta_sokak"></td>
                            </tr>
                            <tr>
                                <td>Kapı no</td><td>:</td> <td><input type="text" name="lokanta_kapi_no"></td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center"><h4>Lokanta Bilgilerini Giriniz</h4></td>
                            </tr>
                            <tr>
                                <td>Kullanıcı Adı</td><td>:</td> <td><input type="text" name="kullanici_ad"></td>
                            </tr>
                            <tr>
                                <td>Kullanıcı Şifre</td><td>:</td> <td><input type="text" name="kullanici_sifre"></td>
                            </tr>
                            <tr>
                                <td>Lokanta Adı</td><td>:</td> <td><input type="text" name="lokanta_ad"></td>
                            </tr>
                            <tr>
                                <td>E-mail</td><td>:</td> <td><input type="text" name="lokanta_email"></td>
                            </tr>
                            <tr>
                                <td>Telefon</td><td>:</td> <td><input type="text" name="lokanta_tel"></td>
                            </tr>

                            <td><input type="submit" value="Kaydet"></td>
                        </table>
                    </form>		
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
