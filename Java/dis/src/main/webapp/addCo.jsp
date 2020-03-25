
<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	//if (!userRole.equals("faculty")){
	//	response.sendRedirect("/dis/login.jsp");
	//}
	if (userRole.equals("faculty")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/headerFaculty.jsp"%>
<%
	Connect con = null;
	ResultSet rs = null;
	ResultSet rsAllSubject=null;
	ResultSetMetaData mtdt = null;
	con = new Connect();
	String userDept = "";
%>
<style>
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
<title>ADD A COURSE OUTCOME</title>
<div class="navigation" id="navbar">
	<div class="dropdown">
		<!-- navigation STARTS here -->
		<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
			Menu</label> <input type="checkbox" id="show-menu" role="button">
		<ul id="menu">
			<li><a href="facultyHome.jsp" class="main-link">HOME</a></li>
			<li><a href="addCo.jsp" class="active main-link">ADD CO</a></li>
			<li><a href="addExam.jsp" class="main-link">ADD EXAM</a></li>
			<li><a href="addQue.jsp" class="main-link">ADD
					QUESTION</a></li>
			<li><a href="addMarks.jsp" class="main-link">ADD
					MARKS</a></li>
			<li><a href="calculateAttainment.jsp" class="main-link">VIEW
					ATTAINMENT</a></li>
			<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
			<%-- <li><a href="#" class="main-link">MANAGE USERS &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
							<li><a href="addadmin.jsp">ADD USER</a></li>
							<li><a href="#">DELETE USER</a></li>
						</ul></li> --%>
		</ul>
	</div>
</div>
<!-- navigation ENDS here -->
</div>

<%-- <a href="addCo.jsp">Add CO</a><br/>
        <a href="addExam.jsp">Add Exam</a><br/>
        <a href="addQue.jsp">Add Question</a><br/>
        <a href="addMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/> --%>

<div class="container" style="width: 80%; margin-bottom: 100px">
	<h3 id="head" style="text-align: center; padding-bottom: 10px;">ADD
		COURSE OUTCOME</h3>
	<form method="POST">
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
					<label for="subjectID">Subject:</label>
					<select class="uk-select" name="subject_id" id="subject_id">
						<option value=0 disabled selected>Select Subject</option>
						<%
							if (session.getAttribute("facultyDepartment") != null) {
								userDept = (String) session.getAttribute("facultyDepartment");
							}
							rsAllSubject=con.SelectData("select * from subject_master where branch='"+userDept+"';");
							while(rsAllSubject.next()){
								out.println("<option value="+rsAllSubject.getInt("subjectID")+">"+rsAllSubject.getString("subjectName")+"</option>");
							}
						%>
					</select>
				</div>
			<div class="col-sm"></div>
		</div>

		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">

				<label for="facultyID">Faculty Name: </label><input type="number" value='<%=session.getAttribute("facultyID")%>' name="faculty_id" id="faculty_id" hidden> <input type="text"
					value='<%=session.getAttribute("getfacultyName")%>'
					class="uk-input" id="facultyName" name="facultyName"
					placeholder="Faculty Name" readonly />
			</div>
			<div class="col-sm"></div>
		</div>

		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">

				<label for="noCO">No of CO:</label> <input type="number"
					class="uk-input" name="cono" id="cono" min="1"
					placeholder="Add No of COs" />
			</div>
			<div class="col-sm"></div>
		</div>
		<div id="cos"></div>
		<center class="mt-3">
			<button type="submit" class="btn" id="submit" name="submit" value="submit" disabled>Submit</button>
		</center>
		<script type="text/javascript">
			$(document).on("change","#cono",function(){
				var cono = this.value;
				var n = 1;
				$("#cos").text('');
                while(n<=cono){
                    $('#cos').append('<div class="form-row"><label for="coStmt">CO Statement '+n+' :</label><input type="text" class="uk-input" name="co'+(n)+'" placeholder="Course Outcome Statement" required></div>');
                    n++;
				}
				if(cono>0)
					$('#submit').removeAttr("disabled");
				else
					$('#submit').attr("disabled","true");
			});

        </script>
		<%
				
					if (request.getParameter("submit") != null) {
						int conos = Integer.parseInt(request.getParameter("cono"));
						int x = 1;
						while (x <= conos) {
							if (con.Ins_Upd_Del("insert into co_master(coSrNo,coStatement,subjectID,facultyID) VALUES(" + x
									+ ",'" + request.getParameter("co" + x) + "'," + request.getParameter("subject_id")
									+ "," + request.getParameter("faculty_id") + ");")){
								if(x==conos){
									out.println("<script>$('.container').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a>CO Inserted Successfully.</div>')</script>");        
									con.commitData();
								}	
							}
							else{
								out.println("<script>$('.container').prepend('<div class=\"uk-alert-danger\" uk-alert><a cl-ass=\"uk-alert-close\" uk-close></a>ERROR: @CO "+x+": Please Insert All CO Again.</div>')</script>");
								con.rollbackData();
							}
							x++;
						}
					}
				%>
	</form>
	
<%@include file="/footer.jsp"%>
<%
  }
  else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("/dis/login.jsp");
	}
  %>