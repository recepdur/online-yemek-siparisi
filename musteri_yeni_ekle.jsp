<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.security.MessageDigest"%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>

<%

    if (request.getParameter("kullanici_ad") != null && request.getParameter("kullanici_sifre") != null && request.getParameter("musteri_ad") != null && request.getParameter("musteri_soyad") != null
            && request.getParameter("musteri_email") != null && request.getParameter("musteri_tel") != null && request.getParameter("musteri_sokak") != null
            && request.getParameter("musteri_kapi_no") != null && request.getParameter("id_il") != null && request.getParameter("id_ilce") != null
            && request.getParameter("id_semt") != null && request.getParameter("id_mahalle") != null) // check input
    {
        String kullanici_ad = request.getParameter("kullanici_ad");
        String kullanici_sifre = request.getParameter("kullanici_sifre");
        String ad = request.getParameter("musteri_ad");
        String soyad = request.getParameter("musteri_soyad");
        String email = request.getParameter("musteri_email");
        String tel = request.getParameter("musteri_tel");
        String sokak = request.getParameter("musteri_sokak");
        String kapi_no = request.getParameter("musteri_kapi_no");
        String il = request.getParameter("id_il");
        String ilce = request.getParameter("id_ilce");
        String semt = request.getParameter("id_semt");
        String mahalle = request.getParameter("id_mahalle");

        if (!kullanici_ad.equals("") && !kullanici_sifre.equals("") && !ad.equals("") && !soyad.equals("")
                && !email.equals("") && !tel.equals("") && !sokak.equals("") && !kapi_no.equals("") && !il.equals("")
                && !ilce.equals("") && !semt.equals("") && !mahalle.equals("")) // check input
        {
            Statement stmt = conn.createStatement();
            ResultSet rs_kullanici = stmt.executeQuery("SELECT * FROM kullanici WHERE kullanici_ad='" + kullanici_ad + "'");
            if (rs_kullanici.next() == false) 
            {
                ResultSet rs_il2 = stmt.executeQuery("SELECT * FROM il WHERE il_id='" + il + "'");
                rs_il2.next();
                String il_ad = rs_il2.getString("il_ad");
                ResultSet rs_ilce2 = stmt.executeQuery("SELECT * FROM ILCE WHERE ilce_id='" + ilce + "'");
                rs_ilce2.next();
                String ilce_ad = rs_ilce2.getString("ilce_ad");
                ResultSet rs_semt2 = stmt.executeQuery("SELECT * FROM SEMT WHERE semt_id='" + semt + "'");
                rs_semt2.next();
                String semt_ad = rs_semt2.getString("semt_ad");
                ResultSet rs_mahalle2 = stmt.executeQuery("SELECT * FROM MAHALLE WHERE mahalle_id='" + mahalle + "'");
                rs_mahalle2.next();
                String mahalle_ad = rs_mahalle2.getString("mahalle_ad");

                /**
                 * adres bilgisi ekleme
                 */
                stmt.executeUpdate("INSERT INTO adres(il,ilce,semt,mahalle,sokak,kapi_no) VALUES ('" + il_ad + "','" + ilce_ad + "','" + semt_ad + "','" + mahalle_ad + "','" + sokak + "','" + kapi_no + "')");

                /**
                 * musteri bilgisi ekleme
                 */
                ResultSet rs_adres = stmt.executeQuery("SELECT adres_id FROM adres WHERE il='" + il_ad + "' AND ilce='" + ilce_ad + "' AND semt='" + semt_ad + "' AND mahalle='" + mahalle_ad + "' AND sokak='" + sokak + "' AND kapi_no='" + kapi_no + "'");
                rs_adres.next();
                String adres_id = rs_adres.getString("adres_id");
                stmt.executeUpdate("INSERT INTO musteri(musteri_ad,musteri_soyad,musteri_email,adres_id,musteri_tel) VALUES ('" + ad + "','" + soyad + "','" + email + "','" + adres_id + "','" + tel + "')");

                /* md5 şifreleme */
                MessageDigest alg = MessageDigest.getInstance("MD5");
                alg.reset();
                alg.update(kullanici_sifre.getBytes());
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
                String md5_kullanici_sifre = hashedpasswd.toString();

                /**
                 * kullanıcı bilgisi ekleme
                 */
                ResultSet rs_musteri = stmt.executeQuery("SELECT musteri_id FROM musteri WHERE musteri_ad='" + ad + "' AND musteri_soyad='" + soyad + "'AND adres_id='" + adres_id + "'");
                rs_musteri.next();
                String musteri_id = rs_musteri.getString("musteri_id");
                stmt.executeUpdate("INSERT INTO kullanici(musteri_id, kullanici_ad, kullanici_sifre)  VALUES ('" + musteri_id + "','" + kullanici_ad + "','" + md5_kullanici_sifre + "')");

                stmt.close();
                out.print("<script>  self.location='musteri_giris.jsp'; </script>");

            } else {
                out.print("<script>alert('Kullanıcı Adı zaten kullanılıyor!');history.back(-1);</script>");
            }

        } else {
            out.print("<script>alert('Tum alanlari doldurmaniz zorunludur. Lutfen tekrar deneyin!');history.back(-1);</script>");
        }


    }



%>