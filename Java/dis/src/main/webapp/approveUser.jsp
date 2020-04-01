<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	if (userRole.equals("admin")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/header.jsp"%>
<title>APPROVE USERS</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$(".approveAdmin").click(function () {
			var id2 = this.id;
			$.ajax({
				url: "update-approve-admin-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
	});
	$(document).ready(function () {
		$(".rejectAdmin").click(function () {
			var id2 = this.id;
			$.ajax({
				url: "update-reject-admin-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
	});
	$(document).ready(function () {
		$(".approveFaculty").click(function () {
			var id2 = this.id;
			$.ajax({
				url: "update-approve-faculty-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
	});
	$(document).ready(function () {
		$(".rejectFaculty").click(function () {
			var id2 = this.id;
			$.ajax({
				url: "update-reject-faculty-ajax.jsp",
				type: "post",
				data: {
					id: id2,
				},
				success: function (data) {
					location.reload(true);
				}
			});
		});
	});
</script>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
td{
    padding: 0px !important;
}
th{
    background-color: #cf6766 !important;
    color: black !important;
}
table input{
    border: 0px !important;
}
.form-row .col-sm .form-row{
    padding:0px !important;
    display: inline !important;
    margin: 0px !important;
}
.uk-table{
    width: auto !important;
}
/* Chrome, Safari, Edge, Opera */
		input::-webkit-outer-spin-button,
		input::-webkit-inner-spin-button {
		-webkit-appearance: none;
		margin: 0;
		}
/* Firefox */
		input[type=number] {
		-moz-appearance: textfield;
		}
</style>
        <div class="navigation" id="navbar">
			<div class="dropdown">
				<!-- navigation STARTS here -->
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="adminHome.jsp" class="main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="addStudents.jsp" class="main-link">ADD STUDENTS</a></li>
							</ul></li>
					<li><a href="#" class="main-link">APPROVE &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="#" class="main-link">APPROVE USER</a></li>
							</ul></li>
					<li><a href="#" class="main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
			</div>
		</div>
		<!-- navigation ENDS here -->
	</div>
	<%
	Connect con = null;
	con = new Connect();
	ResultSet rsFaculty = null;
	ResultSet rsAdmin = null;
	%>
<div class="container" style="width: 80%; margin-bottom: 100px">
    <div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">APPROVE
		USERS</h3>
	<table class="uk-table uk-table-hover uk-table-divider">
    <thead>
        <tr>
            <th>Role</th>
            <th>Name</th>
            <th>Email</th>
			<th></th>
			<th></th>
        </tr>
    </thead>
    <tbody>
		<%
			rsAdmin= con.SelectData("select * from admin_master where isApproved=0;");
			rsFaculty = con.SelectData("select * from faculty_master where isApproved=0 and facultyDepartment="+(int)session.getAttribute("adminDepartment")+";");
		
			while(rsAdmin.next()){
		%>
        <tr>
            <td>Admin</td>
            <td><%out.println(rsAdmin.getString("adminName"));%></td>
			<td><%out.println(rsAdmin.getString("adminEmail"));%></td>
			<td><a href="" class="uk-icon-button" id="<%=rsAdmin.getInt(1)%>" class="approveAdmin" uk-icon="check"></a></td>
			<td><a href="" class="uk-icon-button" id="<%=rsAdmin.getInt(1)%>" class="rejectAdmin" uk-icon="close"></a></td>
        </tr>
		<%
			}
			while(rsFaculty.next()){
		%>
		<tr>
            <td>Faculty</td>
            <td><%out.println(rsFaculty.getString("facultyName"));%></td>
			<td><%out.println(rsFaculty.getString("facultyEmail"));%></td>
			<td><a href="" class="uk-icon-button" id="<%=rsFaculty.getInt(1)%>" class="approveFaculty" uk-icon="check"></a></td>
			<td><a href="" class="uk-icon-button" id="<%=rsFaculty.getInt(1)%>" class="rejectFaculty" uk-icon="close"></a></td>
        </tr>	
		<%
			}
		%>
	</tbody>
<%
    }
    else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>