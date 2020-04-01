<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="Connection.Md5"%>
<title>REGISTER</title>
<style type="text/css">
    a{
        color: inherit !important;
    }
    a:hover{
        color: #cf6766 !important;
        text-decoration: none !important;
	}
	.form-row {
		padding-top: 4px !important;
		padding-bottom: 4px !important;
	}
</style>
<jsp:include page="header.jsp" />
    <div class="navigation"></div>
</div>
<div class="container" id='main' style="width: 80%; border: 1px solid #cf6766; margin-top:14px;margin-bottom: 50px;">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">REGISTER</h3>
	<form method="POST">
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
                <%-- <label for="roleSelect">You are:</label> --%>
                <select class="uk-select" name="roleSelect" id="roleSelect" required>
                    <option value="" selected disabled>Role</option>
                    <option value="Faculty">Faculty</option>
                    <option value="Admin">Admin</option>
                </select>
			</div>
			<div class="col-sm"></div>
		</div>
        <div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
			<%-- <label for="name">Name:</label> --%>
			<input type="text" class="uk-input" name="name" placeholder="Name" required>
			</div>
			<div class="col-sm"></div>
		</div>
        <div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
			<%-- <label for="department">Department:</label> --%>
					<select class="uk-select" name="department" id="department" required>
						<option value="" selected disabled>Branch</option>
                        <option value="16">Information Technology</option>
						<option value="7">Computer Engineering</option>
					</select>
			</div>
			<div class="col-sm"></div>
		</div>
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
			<%-- <label for="email">Email:</label> --%>
			<input type="email" class="uk-input" name="email" placeholder="Email" required>
			</div>
			<div class="col-sm"></div>
		</div>
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
			<%-- <label for="password">Password:</label> --%>
			<input type="password" class="uk-input" id="password" name="password" onkeyup="checkPass(); return false;" placeholder="Password" required>
			</div>
			<div class="col-sm"></div>
		</div>
        <div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
			<%-- <label for="password">Password:</label> --%>
			<input type="password" class="uk-input" id="confirmPassword" name="confirmPassword" onkeyup="checkPass(); return false;" placeholder="Confirm Password" required>
			</div>
			<div class="col-sm"></div>
		</div>
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
				<center class="mt-3">
					<button type="submit" class="btn" id="submitLink" value="submit" name="btnRegister" style="background-color: #cf6766; color: white;">SIGN UP</button>
				</center>
			</div>
			<div class="col-sm"></div>
		</div>
        <div class="text-center text-muted">
            Already have an account? <a href="./login.jsp">SIGN IN</a>
		</div>
	</form>
	<%
		Connect con = new Connect();
		Md5 md = new Md5();
		String role = request.getParameter("roleSelect");
		if (request.getParameter("btnRegister") != null && role.equals("Admin")){
			if(con.Ins_Upd_Del("insert into admin_master (adminName,adminEmail,adminPassword,adminDepartment) values ('"+request.getParameter("name")+"','"+request.getParameter("email")+"','"+md.getMd5(request.getParameter("password"))+"',"+request.getParameter("department")+");")){
				con.commitData();
				out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Your Registration Request Sent for Approval.</b></div>')</script>");
				con.CloseConnection();
			} else{
				con.rollbackData();
				out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Email Address Already Exist.</div>')</script>");
				con.CloseConnection();
			}
		} else if(request.getParameter("btnRegister") != null && role.equals("Faculty")){
			if(con.Ins_Upd_Del("insert into faculty_master (facultyName,facultyEmail,facultyPassword,facultyDepartment) values ('"+request.getParameter("name")+"','"+request.getParameter("email")+"','"+md.getMd5(request.getParameter("password"))+"',"+request.getParameter("department")+");")){
				con.commitData();
				out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Your Registration Request Sent for Approval.</b></div>')</script>");
				con.CloseConnection();
			} else{
				con.rollbackData();
				out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Email Address Already Exist.</div>')</script>");
				con.CloseConnection();
			}
		}
	%>

	<script type="text/javascript">
		function checkPass() {
			var pass1 = document.getElementById('password');
			var pass2 = document.getElementById('confirmPassword');
			var b = document.getElementById('submitLink');
			var box = document.getElementById('main');
			if (pass1.value == 0) {
				b.disabled = true;
			} else if (pass1.value == pass2.value) {
				pass1.classList.remove("uk-form-danger");
				pass2.classList.remove("uk-form-danger");
				b.disabled = false;
				pass2.classList.add("uk-form-success");
				pass1.classList.add("uk-form-success");
				box.style.border="2px solid #32d296";
				
			} else {
				pass1.classList.remove("uk-form-success");
				pass2.classList.remove("uk-form-success");
				b.disabled = true;
				pass2.classList.add("uk-form-danger");
				pass1.classList.add("uk-form-danger");
				box.style.border="2px solid #f0506e";
			}
		}
	</script>
<jsp:include page="footer.jsp" />
