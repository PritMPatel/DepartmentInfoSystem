<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	//if (!userRole.equals("faculty")){
	//	response.sendRedirect("/dis/login.jsp");
	//}
	if (userRole.equals("admin")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/header.jsp"%>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
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
<title>ADD A SUBJECT</title>
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
					<li><a href="addSubject.jsp" class="active main-link">ADD SUBJECT</a></li>
							</ul></li>
					<li><a href="#" class="main-link">USERS &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="approveUser.jsp" class="main-link">APPROVE USER</a></li>
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
<div class="container" style="width: 80%; margin-bottom: 100px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">ADD
		A SUBJECT</h3>
	<form method="POST">
		<%-- ExamID:        <input type="number" name="exam_id"/><br/> --%>
		<div class="form-row">
		<div class="col-sm"></div>
			<div class="col-sm">
				<label for="subjectName">Subject Name:</label> <input type="text"
					class="uk-input" id="subject_name" name="subject_name"
					placeholder="Subject Name" required/>
			</div>
			<div class="col-sm"></div>
			</div>
			<div class="form-row">
		<div class="col-sm"></div>
			<div class="col-sm">
				<label for="subjectCode">Subject Code:</label> <input type="number"
					class="uk-input" id="subject_code" name="subject_code"
					placeholder="  Subject Code" min="0" required/>
			</div>
			<div class="col-sm"></div>
			</div>
			<div class="form-row">
		<div class="col-sm"></div>
			<div class="col-sm">
				<label for="semester">Semester:</label> 
				<select class="uk-select" name="semester" id="semester" required>
						<option value="" selected>Select a Semester</option>
						<option value="1">Semester 1</option>
						<option value="2">Semester 2</option>
						<option value="3">Semester 3</option>
						<option value="4">Semester 4</option>
						<option value="5">Semester 5</option>
						<option value="6">Semester 6</option>
						<option value="7">Semester 7</option>
						<option value="8">Semester 8</option>
				</select>
			</div>
			<div class="col-sm"></div>
			</div>
		<center class="mt-3">
			<button type="submit" class="btn" name="submit" value="submit">Submit</button>
		</center>
		</div>

	<%
	Connect con = null;
	ResultSet rs = null;
	ResultSetMetaData mtdt = null;
	con = new Connect();
	if(request.getParameter("submit")!=null){
		if (con.Ins_Upd_Del("insert into subject_master (subjectName, subjectCode, semester, subjectDepartment) values ('"+request.getParameter("subject_name")+"',"+request.getParameter("subject_code")+","+request.getParameter("semester")+","+(int)session.getAttribute("adminDepartment")+");"))
		{
			out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Subject Inserted Successfully</b>.</div>')</script>");        
			con.commitData();
		}
		else{
			out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Same Subject Exist for Selected Semester.</div>')</script>");
			con.rollbackData();
		}
		}
	%>
</form>

<%@include file="/footer.jsp"%>
<%
    }
    else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>
