<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<%
    Connection conn = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String hostName = "dbs.cs.hacettepe.edu.tr";
        String portNumber = "1521";
        String sid = "ORAVT";
        String url = "jdbc:oracle:thin:@" + hostName + ":" + portNumber + ":" + sid;
        String userName = "b20926305";
        String password = "elma15";
        conn = DriverManager.getConnection(url, userName, password);

    } catch (Exception e) {
        out.println("Exception : " + e.getMessage() + "");
    }

%>

