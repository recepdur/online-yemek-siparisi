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
        <title>Siparişler</title>
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
                        <form id="form1" name="form1" method="post" action="lokanta_index.jsp">
                            <h4 align="center" >Sipariş Bilgileriniz </h4><br>
                                <table border="0">
                                    <tr><td></br></td></tr>                                    
                                    <tr>
                                        <td width="50"><h4>Siparis</h4></td> 
                                        <td width="100"><h4>Yemek Adı</h4></td> 		
                                        <td width="100"><h4>Fiyat</h4></td>
                                        <td width="100"><h4>Siparis Miktarı</h4></td>
                                        <td width="100"><h4>Müşteri Adı</h4></td>
                                        <td width="300"><h4>Adres </h4></td>
                                        <td width="100"><h4>Tarih</h4></td> 
                                        <td width="100"><h4>Teslim Et</h4></td> 
                                    </tr>
                                    <%
                                        Statement stmt = conn.createStatement();
                                        String sorgu = "SELECT * FROM v_siparis_verilen_yemekler WHERE lokanta_id='" + lokanta + "' AND siparis_durum='"+"false" + "' AND sepet_durum='"+"true" + "'";
                                        ResultSet rs_siparis = stmt.executeQuery(sorgu);
                                        int s=2;
                                        while (rs_siparis.next()) 
                                        {
                                             if(s%2==0)
                                               out.print("<tr bgcolor=\"#9999FF\">");
                                            else
                                               out.print("<tr bgcolor=\"#EEEEFF\">");
                                            String adres = rs_siparis.getString("il") + " " + rs_siparis.getString("ilce")+ " " + rs_siparis.getString("semt")+ " " + rs_siparis.getString("mahalle")+ " " + rs_siparis.getString("sokak")+ ". Sokak Kapı No:" + rs_siparis.getString("kapi_no") ;
                                            out.print("<td><img src="+"yemekler/"+rs_siparis.getString("yemek_resim")+" alt=\"Smiley face\" width=\"50\" height=\"50\"></td>");                     
                                            out.print("<td>" + rs_siparis.getString("yemek_ad") + "</td>");
                                            out.print("<td>" + rs_siparis.getString("yemek_fiyat") + "</td>");
                                            out.print("<td>" + rs_siparis.getString("siparis_miktar") + "</td>");
                                            out.print("<td>" + rs_siparis.getString("musteri_ad") + "</td>");
                                            out.print("<td>" + adres + " </td>");
                                            out.print("<td>" + rs_siparis.getString("siparis_tarih") + "</td>");
                                            out.print("<td><a href=\"lokanta_siparis_teslim.jsp?siparis_id="+rs_siparis.getString("siparis_id")+"\">Teslim Et</a></td>");                                                                
                                          out.print("</tr>");
                                            s++;
                                        }
                                        out.print("<tr></tr><tr><td></td><td><a href=\"raporlama.jsp?siparis_kaydet="+"true"+"&lokanta_id="+lokanta+"\">Siparisleri Kaydet</a></td></tr>");
                                        stmt.close();
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
