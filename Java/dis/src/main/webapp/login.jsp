
<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	if (userRole.equals("admin")) {
		response.sendRedirect("adminHome.jsp");
	} else if (userRole.equals("faculty")) {
		response.sendRedirect("facultyHome.jsp");
	} else {
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="Connection.Md5"%>
<title>Login</title>
<jsp:include page="header.jsp" />

<body style="height: -webkit-fill-available; min-height: 50vh;">

	<div class="header" style="width: 100%; z-index: 980;" uk-sticky="">
		<h1 class="uk-heading-divider"></h1>
		<h1 class="uk-heading-line uk-text-center">
			<span>Department Information System</span>
		</h1>
		<h1 class="uk-heading-divider"></h1>
	</div>
	<div class="page">
		<div class="page-single" style="width: 100%;">
			<div class="container">
				<div class="row">
					<div class="col col-login mx-auto">
						<form class="card" action="" method="post">
							<div class="card-body p-6">
								<div class="card-title">
									<center>Login</center>
								</div>
								<div class="form-group">
                                    <div class="selectgroup w-100">
                                        <label class="selectgroup-item">
                                            <input type="radio" name="roleSelect" value="Admin"
                                                class="selectgroup-input">
                                            <span class="selectgroup-button">Admin</span>
                                        </label>
                                        <label class="selectgroup-item">
                                            <input type="radio" name="roleSelect" value="Faculty"
                                                class="selectgroup-input">
                                            <span class="selectgroup-button">Faculty</span>
                                        </label>
                                    </div>
                                </div>
								<%-- <div class="form-group">
									<label class="form-label">You are</label> <select
										class="form-control custom-select" id="roleSelect"
										name="roleSelect">
										<option value="Admin">Admin</option>
										<option value="Faculty">Faculty</option>
									</select>
								</div> --%>
								<div class="form-group">
									<label class="form-label">Email</label> <input type="email"
										name="email" class="form-control" id="InputEmail1"
										aria-describedby="emailHelp" placeholder="Enter Email"
										required="">
								</div>
								<div class="form-group">
									<label class="form-label">Password</label> <input
										type="password" name="password" class="form-control"
										id="InputPassword1" placeholder="Password" required="">
								</div>

								<div class="form-footer">
									<button type="submit" class="btn btn-primary btn-block"
										id="submitLink" value="submit" name="btnLogin"
										style="color: white;">Sign in</button>
								</div>
							</div>
							<%
								Connect con = new Connect();
								Md5 md = new Md5();
									String role = request.getParameter("roleSelect");
									if (request.getParameter("btnLogin") != null && role.equals("Admin")) {
										if (con.CheckData("select * from admin_master where adminEmail='" + request.getParameter("email")
												+ "' and adminPassword='" + md.getMd5(request.getParameter("password")) + "'")) {
											ResultSet rs = con.SelectData("select adminID,adminName,adminDepartment from admin_master where adminEmail='"
													+ request.getParameter("email") + "';");
											String Uname = request.getParameter("email");
											String Name = null;
											int dept = 0;
											int id=0;
											if (rs.next()) {
												Name = rs.getString("adminName");
												dept = rs.getInt("adminDepartment");
												id = rs.getInt("adminID");

											}
											session.setAttribute("getadminName", Name);
											session.setAttribute("adminID",id);
											session.setAttribute("adminUsername", Uname);
											session.setAttribute("adminDepartment", dept);
											session.setAttribute("role", "admin");
											response.sendRedirect("adminHome.jsp");
										} else {
											out.println("<script>alert('Wrong username or password')</script>");
										}
									} else if (request.getParameter("btnLogin") != null && role.equals("Faculty")) {
										if (con.CheckData(
												"select * from faculty_master where facultyEmail='" + request.getParameter("email")
														+ "' and facultyPassword='" + md.getMd5(request.getParameter("password")) + "'")) {
											ResultSet rs = con.SelectData("select facultyID,facultyName,facultyDepartment from faculty_master where facultyEmail='"
													+ request.getParameter("email") + "';");
											String Uname = request.getParameter("email");
											String Name = null;
											int dept = 0;
											int id=0;
											if (rs.next()) {
												Name = rs.getString("facultyName");
												dept = rs.getInt("facultyDepartment");
												id = rs.getInt("facultyID");

											}
											session.setAttribute("getfacultyName", Name);
											session.setAttribute("facultyUsername", Uname);
											session.setAttribute("facultyID",id);
											session.setAttribute("role", "faculty");
											session.setAttribute("facultyDepartment", dept);
											response.sendRedirect("facultyHome.jsp");
										} else {
											out.println("<script>alert('Wrong username or password')</script>");
		
										}
									}
							%>
						</form>
						<div class="text-center text-muted">
							Don't have account yet? <a href="./registerUser.jsp">Sign up</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>

<%
	}
%>