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

<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
td{
    padding-left: 35px !important;
	padding-right: 35px !important;
	margin: 25px !important;
}
th{
    background-color: #f0f0f0;
    color: black !important;
	text-align:center !important;
	font-weight: bold !important;
	padding: 15px !important;
	margin: 25px !important;
}
table{
    border: 0px !important;
}
.form-row .col-sm .form-row{
    padding:0px !important;
    display: inline !important;
    margin: 0px !important;
}
.uk-table{
    width: 100% !important;
}

.uk-table td, .uk-table th{
	border: 0px !important;
}

.approve{
	color: #28a745 !important;
}
.approve::before{
	border-bottom-color: #28a745 !important;
}
.reject{
	color: red !important;
}

.reject::before{
	border-bottom-color: red !important;
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
					<li><a href="addSubject.jsp" class="main-link">ADD SUBJECT</a></li>
							</ul></li>
					<li><a href="#" class="main-link">USERS &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="approveUser.jsp" class="active main-link">APPROVE USER</a></li>
					<li><a href="removeUser.jsp" class="main-link">REMOVE USER</a></li>
							</ul></li>
					<li><a href="adminOverallAttainment.jsp" class="main-link">VIEW
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
<%
			rsAdmin= con.SelectData("select * from admin_master where isApproved=0;");
			rsFaculty = con.SelectData("select * from faculty_master where isApproved=0 and facultyDepartment="+(int)session.getAttribute("adminDepartment")+";");
			if(!rsFaculty.next() && !rsAdmin.next()){
				out.println("<div class=\"uk-alert text-center\" uk-alert><b>No Pending Request Found</b>.</div>");
			}
			else{
%>			
		<div class="uk-overflow-auto">
		<table align="center" class="uk-table uk-table-striped">
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
			rsAdmin.beforeFirst();
			while(rsAdmin.next()){
		%>
        <tr>
            <td>Admin</td>
            <td><%out.println(rsAdmin.getString("adminName"));%></td>
			<td><%out.println(rsAdmin.getString("adminEmail"));%></td>
			<td>
			<button type="button" class="uk-button uk-button-text approve approveAdmin" id="<%=rsAdmin.getInt("adminID")%>" style="margin:8px;">Approve</button>
			</td>
			<td>
			<button type="button" class="uk-button uk-button-text reject rejectAdmin" id="<%=rsAdmin.getInt("adminID")%>" style="margin:8px;">Reject</button>
			</td>
        </tr>
		<%
			}
			rsFaculty.beforeFirst();
			while(rsFaculty.next()){
		%>
		<tr>
            <td>Faculty</td>
            <td><%out.println(rsFaculty.getString("facultyName"));%></td>
			<td><%out.println(rsFaculty.getString("facultyEmail"));%></td>
			<td>
			<button type="button" class="uk-button uk-button-text approve approveFaculty" id="<%=rsFaculty.getInt("facultyID")%>" style="margin:8px;">Approve</button>
			</td>
			<td>
			<button type="button" class="uk-button uk-button-text reject rejectFaculty" id="<%=rsFaculty.getInt("facultyID")%>" style="margin:8px;">Reject</button>
			</td>
        </tr>	
		<%
			}
			con.CloseConnection();
		%>
	</tbody></table></div>
	<%
	}
	%>
	<%@include file="/footer.jsp"%>
<%
    }
    else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>