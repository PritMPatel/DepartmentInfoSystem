<%@page import="Connection.Connect"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
String id = request.getParameter("id");

Connect con = new Connect();
boolean status = con.Ins_Upd_Del("update admin_master set isApproved=1 where adminID = "+id);

%>