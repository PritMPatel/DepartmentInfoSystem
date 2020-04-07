
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
<%@include file="/header.jsp"%>
<%
	Connect con = null;
	ResultSet rs = null;
	ResultSet rsAllSubject=null;
	ResultSet rsBatch=null;
	ResultSetMetaData mtdt = null;
	con = new Connect();
	int userDept = 0;
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
					<li><a href="facultyHome.jsp" class=" main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="facultyAddCo.jsp" class="active main-link">ADD CO</a></li>
					<li><a href="facultyAddExam.jsp" class="main-link">ADD
							EXAM</a></li>
					<li><a href="facultyAddQue.jsp" class="main-link">ADD
							QUESTION</a></li>
					<li><a href="facultyAddMarks.jsp" class="main-link">ADD
							MARKS</a></li>
							</ul></li>
					<li><a href="#" class="main-link">UPDATE &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="facultyUpdateCo.jsp" class="main-link">UPDATE CO</a></li>
					<li><a href="#" class="main-link">UPDATE
							EXAM</a></li>
					<li><a href="#" class="main-link">UPDATE
							QUESTION</a></li>
					<li><a href="facultyUpdateMarks.jsp" class="main-link">UPDATE
							MARKS</a></li>
							</ul></li>
					<li><a href="viewMarks.jsp" class="main-link">VIEW
							MARKS</a></li>
					<li><a href="calculateAttainment.jsp" class="main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
	</div>
</div>
<!-- navigation ENDS here -->
</div>

<%-- <a href="facultyAddCo.jsp">Add CO</a><br/>
        <a href="facultyAddExam.jsp">Add Exam</a><br/>
        <a href="facultyAddQue.jsp">Add Question</a><br/>
        <a href="facultyAddMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/> --%>

<div class="container" style="width: 80%; margin-bottom: 100px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">ADD
		COURSE OUTCOME</h3>
	<form method="POST">
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
					<label for="subjectID">Subject:</label>
					<select class="uk-select" name="subject_id" id="subject_id" required>
						<option value="" disabled selected>Select Subject</option>
						<%
							if (session.getAttribute("facultyDepartment") != null) {
								userDept = (int)session.getAttribute("facultyDepartment");
							}
							rsAllSubject=con.SelectData("select * from subject_master where subjectDepartment='"+userDept+"';");
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
				<label for="batch">Batch:</label> <select class="uk-select" name="batch" id="batch" required>
					<option value="" disabled selected>Select Batch</option>
					<%
								rsBatch=con.SelectData("select distinct batch from student_master where studentDepartment="+session.getAttribute("facultyDepartment")+";");
								while(rsBatch.next()){
									out.println("<option value="+rsBatch.getInt("batch")+">"+rsBatch.getInt("batch")+"</option>");
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
						String query = "";
						while (x <= conos) {
							query += "("+x+",'"+request.getParameter("co"+x)+"',"+request.getParameter("subject_id")+","+request.getParameter("faculty_id")+","+request.getParameter("batch")+")";
							if(x!=conos){
								query += ",";
							}
							x++;
						}
						if (con.Ins_Upd_Del("insert into co_master(coSrNo,coStatement,subjectID,facultyID,batch) VALUES "+query+";")){
							out.println("<script>$('#head').prepend('<div class=\"uk-alert-success uk-alert\" uk-alert><a class=\"uk-alert-close uk-close\" uk-close></a><b>COs Inserted Successfully</b>.</div>');</script>");
							con.commitData();
						}
						else{
							out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger uk-alert\" uk-alert><a class=\"uk-alert-close uk-close\" uk-close></a><b>ERROR</b>: COs of this Subject & Batch Already Exist.</div>');</script>");
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
		response.sendRedirect("/dis/login.jsp");
	}
  %>