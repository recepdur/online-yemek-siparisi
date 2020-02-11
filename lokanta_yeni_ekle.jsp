<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("utf-8");%>
<%@page import="java.security.MessageDigest"%>
<%@include file="baglanti.jsp" %>
<%@ page language="java" %>
<%

    if (request.getParameter("kullanici_ad") != null && request.getParameter("kullanici_sifre") != null && request.getParameter("lokanta_ad") != null
            && request.getParameter("lokanta_email") != null && request.getParameter("lokanta_tel") != null
            && request.getParameter("id_il") != null && request.getParameter("id_ilce") != null
            && request.getParameter("id_semt") != null && request.getParameter("id_mahalle") != null
            && request.getParameter("lokanta_sokak") != null && request.getParameter("lokanta_kapi_no") != null) // check input
    {
        String kullanici_ad = request.getParameter("kullanici_ad");
        String kullanici_sifre = request.getParameter("kullanici_sifre");
        String ad = request.getParameter("lokanta_ad");
        String email = request.getParameter("lokanta_email");
        String tel = request.getParameter("lokanta_tel");
        String il = request.getParameter("id_il");
        String ilce = request.getParameter("id_ilce");
        String semt = request.getParameter("id_semt");
        String mahalle = request.getParameter("id_mahalle");
        String sokak = request.getParameter("lokanta_sokak");
        String kapi_no = request.getParameter("lokanta_kapi_no");

        if (!kullanici_ad.equals("") && !kullanici_sifre.equals("") && !ad.equals("") && !email.equals("")
                && !tel.equals("") && !il.equals("") && !ilce.equals("") && !semt.equals("")
                && !mahalle.equals("") && !sokak.equals("") && !kapi_no.equals("")) // check input
        {
            Statement stmt = conn.createStatement();
            ResultSet rs_kullanici = stmt.executeQuery("SELECT * FROM kullanici WHERE kullanici_ad='" + kullanici_ad + "'");
            if (rs_kullanici.next() == false) 
            {
                ResultSet rs_il = stmt.executeQuery("SELECT * FROM il WHERE il_id='" + il + "'");
                rs_il.next();
                String il_ad = rs_il.getString("il_ad");
                ResultSet rs_ilce = stmt.executeQuery("SELECT * FROM ILCE WHERE ilce_id='" + ilce + "'");
                rs_ilce.next();
                String ilce_ad = rs_ilce.getString("ilce_ad");
                ResultSet rs_semt = stmt.executeQuery("SELECT * FROM SEMT WHERE semt_id='" + semt + "'");
                rs_semt.next();
                String semt_ad = rs_semt.getString("semt_ad");
                ResultSet rs_mahalle = stmt.executeQuery("SELECT * FROM MAHALLE WHERE mahalle_id='" + mahalle + "'");
                rs_mahalle.next();
                String mahalle_ad = rs_mahalle.getString("mahalle_ad");

                /**
                 * adres bilgisi ekleme
                 */
                stmt.executeUpdate("INSERT INTO adres(il,ilce,semt,mahalle,sokak,kapi_no) VALUES ('" + il_ad + "','" + ilce_ad + "','" + semt_ad + "','" + mahalle_ad + "','" + sokak + "','" + kapi_no + "')");

                /**
                 * lokanta bilgisi ekleme
                 */
                ResultSet rs_adres = stmt.executeQuery("SELECT adres_id FROM adres WHERE il='" + il_ad + "' AND ilce='" + ilce_ad + "' AND semt='" + semt_ad + "' AND mahalle='" + mahalle_ad + "' AND sokak='" + sokak + "' AND kapi_no='" + kapi_no + "'");
                rs_adres.next();
                String adres_id = rs_adres.getString("adres_id");
                stmt.executeUpdate("INSERT INTO lokanta(lokanta_ad,lokanta_email,yonetici_onay,adres_id,lokanta_tel) VALUES ('" + ad + "','" + email + "','" + "false" + "','" + adres_id + "','" + tel + "')");

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
                ResultSet rs_lokanta = stmt.executeQuery("SELECT lokanta_id FROM lokanta WHERE lokanta_ad='" + ad + "'");
                rs_lokanta.next();
                String lokanta_id = rs_lokanta.getString("lokanta_id");
                stmt.executeUpdate("INSERT INTO kullanici(lokanta_id, kullanici_ad, kullanici_sifre)  VALUES ('" + lokanta_id + "','" + kullanici_ad + "','" + md5_kullanici_sifre + "')");

                stmt.close();
                out.print("<script>  self.location='lokanta_giris.jsp'; </script>");

            } else {
                out.print("<script>alert('Kullanıcı Adı zaten kullanılıyor!');history.back(-1);</script>");
            }

        } else {
            out.print("<script>alert('Tum alanlari doldurmaniz zorunludur. Lutfen tekrar deneyin!');history.back(-1);</script>");
        }

    }

%>