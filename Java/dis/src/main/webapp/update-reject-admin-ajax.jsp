<%@page import="Connection.Connect"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
String id = request.getParameter("id");

Connect con = new Connect();
boolean status = con.Ins_Upd_Del("delete from admin_master where adminID = "+id);
con.commitData();
con.CloseConnection();
%>
