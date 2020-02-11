<%@page import="javax.swing.filechooser.FileNameExtensionFilter"%>
<%@page import="javax.swing.JFileChooser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@ page import="javax.servlet.http.HttpUtils,java.util.*" %>
<%@include file="baglanti.jsp" %>


<%

    JFileChooser chooser = new JFileChooser();
    chooser.setVisible(true);
    chooser.setAcceptAllFileFilterUsed(false);
    chooser.setMultiSelectionEnabled(false);
    chooser.setFileFilter(new FileNameExtensionFilter("txt", ".txt"));
    chooser.setFileFilter(new FileNameExtensionFilter("pdf", ".pdf"));
    chooser.setFileFilter(new FileNameExtensionFilter("html", ".html"));


    int option = chooser.showSaveDialog(null);
    if (option == JFileChooser.APPROVE_OPTION) 
    {

        String filePath = chooser.getSelectedFile().getPath();
        String extension = chooser.getFileFilter().getDescription();

        Statement stmt = conn.createStatement();

        if (extension.equals("txt")) 
        {
            if (request.getParameter("sepet_kaydet") != null && request.getParameter("musteri_id") != null) 
            {
                String sepet_kaydet = request.getParameter("sepet_kaydet");
                String musteri = request.getParameter("musteri_id");
                if (sepet_kaydet.equals("true")) 
                {
                    ResultSet rs_sepet = stmt.executeQuery("SELECT * FROM v_sepetteki_yemekler WHERE musteri_id='" + musteri + "' AND siparis_durum='" + "false" + "' AND sepet_durum='" + "false" + "'");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                            PrintStream printStream = new PrintStream(dosya);
                            printStream.println("Sepetinizdeki ürünler");
                            printStream.println("Adı\t\tFiyatı\t\tLokanta\t\t\tLokanta Adresi\t\t\t\t\t Tarih");
                            
                            while (rs_sepet.next()) 
                            {
                                String adres = rs_sepet.getString("il") + " " + rs_sepet.getString("ilce") + " " + rs_sepet.getString("semt") + " " + rs_sepet.getString("mahalle") + " " + rs_sepet.getString("sokak") + " " + rs_sepet.getString("kapi_no");            
                                printStream.println(rs_sepet.getString("yemek_ad")+"\t"+rs_sepet.getString("yemek_fiyat")+"\t"+rs_sepet.getString("lokanta_ad")+"\t\t"+adres+"\t"+rs_sepet.getString("siparis_tarih"));          
                            }                           
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
                }

            }else if (request.getParameter("siparis_kaydet") != null && request.getParameter("lokanta_id") != null) 
            {
                String siparis_kaydet = request.getParameter("siparis_kaydet");
                String lokanta = request.getParameter("lokanta_id");
                if (siparis_kaydet.equals("true")) 
                {
                    ResultSet rs_siparis = stmt.executeQuery("SELECT * FROM v_siparis_verilen_yemekler WHERE lokanta_id='" + lokanta + "' AND siparis_durum='" + "false" + "' AND sepet_durum='" + "true" + "'");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                        PrintStream printStream = new PrintStream(dosya);
                         printStream.println("Siparişleriniz ");
                         printStream.println("Adı\t\tFiyatı\t\tSiparis Miktar\t\tMusteri Ad\t\tAdres\t\t\t\t\t Tarih");
                            while (rs_siparis.next()) 
                            {
                                String adres = rs_siparis.getString("il") + " " + rs_siparis.getString("ilce") + " " + rs_siparis.getString("semt") + " " + rs_siparis.getString("mahalle") + " " + rs_siparis.getString("sokak") + " " + rs_siparis.getString("kapi_no");            
                                printStream.println(rs_siparis.getString("yemek_ad")+"\t"+rs_siparis.getString("yemek_fiyat")+"\t\t"+rs_siparis.getString("siparis_miktar")+"\t\t"+rs_siparis.getString("musteri_ad")+"\t\t"+adres+"\t"+rs_siparis.getString("siparis_tarih"));                                                
                            }    
                                                        
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
                }
           }else if (request.getParameter("yonetici_kaydet") != null && request.getParameter("yonetici_kaydet").equals("true") ) 
           {
                   ResultSet rs_musteri = stmt.executeQuery("SELECT * FROM MUSTERI");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                         PrintStream printStream = new PrintStream(dosya);
                         printStream.println("\t\t\tVerileriniz ");
                         printStream.println("");
                         printStream.println("Müşteriler");
                         printStream.println("Adı\t\tSoyadı");
                            while (rs_musteri.next()) 
                            {
                                printStream.println(rs_musteri.getString("musteri_ad")+"\t\t"+rs_musteri.getString("musteri_soyad"));                                                
                            }   
                         
                         printStream.println("");
                         printStream.println("Lokantalar");
                         printStream.println("Lokanta Adı\tYonetici Onay");
                       ResultSet rs_lokanta = stmt.executeQuery("SELECT * FROM lokanta");

                            while (rs_lokanta.next()) 
                            {
                                printStream.println(rs_lokanta.getString("lokanta_ad")+"\t\t"+rs_lokanta.getString("yonetici_onay"));                                                
                            }    
                                                                              
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
           }

        } else if (chooser.getFileFilter().getDescription().equals("html")) 
        {
            if (request.getParameter("sepet_kaydet") != null && request.getParameter("musteri_id") != null) 
            {
                String sepet_kaydet = request.getParameter("sepet_kaydet");
                String musteri = request.getParameter("musteri_id");
                if (sepet_kaydet.equals("true")) 
                {
                    ResultSet rs_sepet = stmt.executeQuery("SELECT * FROM v_sepetteki_yemekler WHERE musteri_id='" + musteri + "' AND siparis_durum='" + "false" + "' AND sepet_durum='" + "false" + "'");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                        PrintStream printStream = new PrintStream(dosya);
                         printStream.println("<html><body>");
                            printStream.println(" <h4 align=\"center\" >Sepetinizdeki ürünler </h4><br>");
                            printStream.println("<table border=\"1\">");                           
                            printStream.println("<tr><td></br></td></tr>");                                    
                                    printStream.println("<tr>");
                                        printStream.println("<td width=\"100\"><h4>Adı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Fiyatı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Lokanta</h4></td>");
                                        printStream.println("<td width=\"300\"><h4>Lokanta Adresi</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Tarih</h4></td>");                                       
                                   printStream.println("</tr>");
                            int s=2;
                            while (rs_sepet.next()) 
                            {
                                  if(s%2==0)
                                      printStream.println("<tr bgcolor=\"#9999FF\">");
                                  else
                                      printStream.println("<tr bgcolor=\"#EEEEFF\">");
                                String adres = rs_sepet.getString("il") + " " + rs_sepet.getString("ilce") + " " + rs_sepet.getString("semt") + " " + rs_sepet.getString("mahalle") + " " + rs_sepet.getString("sokak") + " " + rs_sepet.getString("kapi_no");            
                                printStream.println("<td>"+rs_sepet.getString("yemek_ad")+"</td>");
                                printStream.println("<td>"+rs_sepet.getString("yemek_fiyat")+"</td>");
                                printStream.println("<td>"+rs_sepet.getString("lokanta_ad")+"</td>");
                                printStream.println("<td>"+adres+"</td>");
                                printStream.println("<td>"+rs_sepet.getString("siparis_tarih")+"</td>");
                                      printStream.println("</tr>");   
                                s++;      
                            }    
                         printStream.println("</table></body></html>");
                                                        
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
                }

            } if (request.getParameter("siparis_kaydet") != null && request.getParameter("lokanta_id") != null) 
            {
                String siparis_kaydet = request.getParameter("siparis_kaydet");
                String lokanta = request.getParameter("lokanta_id");
                if (siparis_kaydet.equals("true")) 
                {
                    ResultSet rs_siparis = stmt.executeQuery("SELECT * FROM v_siparis_verilen_yemekler WHERE lokanta_id='" + lokanta + "' AND siparis_durum='" + "false" + "' AND sepet_durum='" + "true" + "'");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                        PrintStream printStream = new PrintStream(dosya);
                         printStream.println("<html><body>");
                            printStream.println(" <h4 align=\"center\" >Siparişleriniz </h4><br>");
                            printStream.println("<table border=\"1\">");                           
                            printStream.println("<tr><td></br></td></tr>");                                    
                                    printStream.println("<tr>");
                                        printStream.println("<td width=\"100\"><h4>Adı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Fiyatı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Siparis Miktar</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Musteri Ad</h4></td>");
                                        printStream.println("<td width=\"300\"><h4>Musteri Adresi</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Tarih</h4></td>");                                       
                                   printStream.println("</tr>");
                            int s=2;
                            while (rs_siparis.next()) 
                            {
                                  if(s%2==0)
                                      printStream.println("<tr bgcolor=\"#9999FF\">");
                                  else
                                      printStream.println("<tr bgcolor=\"#EEEEFF\">");
                                String adres = rs_siparis.getString("il") + " " + rs_siparis.getString("ilce") + " " + rs_siparis.getString("semt") + " " + rs_siparis.getString("mahalle") + " " + rs_siparis.getString("sokak") + " " + rs_siparis.getString("kapi_no");            
                                printStream.println("<td>"+rs_siparis.getString("yemek_ad")+"</td>");
                                printStream.println("<td>"+rs_siparis.getString("yemek_fiyat")+"</td>");
                                printStream.println("<td>"+rs_siparis.getString("siparis_miktar")+"</td>");
                                printStream.println("<td>"+rs_siparis.getString("musteri_ad")+"</td>");
                                printStream.println("<td>"+adres+"</td>");
                                printStream.println("<td>"+rs_siparis.getString("siparis_tarih")+"</td>");
                                      printStream.println("</tr>");   
                                s++;      
                            }    
                         printStream.println("</table></body></html>");
                                                        
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
                }
            }else if (request.getParameter("yonetici_kaydet") != null && request.getParameter("yonetici_kaydet").equals("true") ) 
            {
                 ResultSet rs_musteri = stmt.executeQuery("SELECT * FROM MUSTERI");
                    try {
                        FileOutputStream dosya = new FileOutputStream(filePath + "." + extension);
                        try {
                         PrintStream printStream = new PrintStream(dosya);
                           printStream.println("<html><body>");                           
                            printStream.println("<table border=\"0\">");                           
                            printStream.println("<tr><td></br></td></tr>");                                    
                                    printStream.println("<tr>");
                                        printStream.println("<td colspan=\"2\"><h3>Müşteri Bilgileri</h3></td>");
                                        printStream.println("<tr><td></br></td></tr>");    
                                        printStream.println("<td width=\"100\"><h4>Adı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Soyadı</h4></td>");                                       
                                   printStream.println("</tr>");    
                             int s=2;
                            while (rs_musteri.next()) 
                            {
                                 if (s % 2 == 0) {
                                     printStream.println("<tr bgcolor=\"#9999FF\">");
                                } else {
                                     printStream.println("<tr bgcolor=\"#EEEEFF\">");
                                }
                                 printStream.println("<td>" + rs_musteri.getString("musteri_ad") + "</td>");
                                 printStream.println("<td>" + rs_musteri.getString("musteri_soyad") + "</td>");
                                 printStream.println("</tr>");
                               s++;
                            }                            
                         printStream.println("</table>");
                         
                    ResultSet rs_lokanta = stmt.executeQuery("SELECT * FROM lokanta");

                          printStream.println("<table border=\"0\">");                           
                            printStream.println("<tr><td></br></td></tr>");                                    
                                    printStream.println("<tr>");
                                        printStream.println("<td colspan=\"2\"><h3>Lokanta Bilgileri</h3></td>");
                                        printStream.println("<tr><td></br></td></tr>");    
                                        printStream.println("<td width=\"100\"><h4>Lokanta Adı</h4></td>");
                                        printStream.println("<td width=\"100\"><h4>Yonetici Onay</h4></td>");                                       
                                   printStream.println("</tr>");    
                             s=2;
                            while (rs_lokanta.next()) 
                            {
                                 if (s % 2 == 0) {
                                    printStream.println("<tr bgcolor=\"#9999FF\">");
                                } else {
                                     printStream.println("<tr bgcolor=\"#EEEEFF\">");
                                }
                                 printStream.println("<td>" + rs_lokanta.getString("lokanta_ad") + "</td>");
                                 printStream.println("<td>" + rs_lokanta.getString("yonetici_onay") + "</td>");
                                 printStream.println("</tr>");
                               s++;
                            }                            
                         printStream.println("</table>");
                                                                              
                            dosya.close();
                            out.print("<script>alert('Sepetiniz Dosyaya Başarıyla Kaydedildi!');history.back(-1);</script>");
                            out.print("<script>  self.location='musteri_sepet.jsp'; </script>");

                        } catch (Exception e) {
                            out.print("<script>alert('Verileriniz Dosyaya Eklenemedi!');history.back(-1);</script>");
                        }
                    } catch (IOException e) {
                        out.print("<script>alert('Dosya Oluşturulamadı!');history.back(-1);</script>");
                    }
            }

        } else if (chooser.getFileFilter().getDescription().equals("pdf")) 
        {
            
        }
        
         stmt.close();
    }

%>
