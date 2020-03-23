
<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	if (!userRole.equals("faculty")){
		response.sendRedirect("/dis/login.jsp");
	}
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
	ResultSetMetaData mtdt = null;
	con = new Connect();
	ResultSet rsAllSubject = null;
	ResultSet rsExamType = null;
%>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
</style>
<title>ADD AN EXAMINATION</title>
<div class="navigation" id="navbar">
	<div class="dropdown">
		<!-- navigation STARTS here -->
		<label for="show-menu" class="show-menu" style="margin-bottom: 0px">Show
			Menu</label> <input type="checkbox" id="show-menu" role="button">
		<ul id="menu">
			<li><a href="facultyHome.jsp" class=" main-link">HOME</a></li>
			<li><a href="addCo.jsp" class=" main-link">ADD CO</a></li>
			<li><a href="addExam.jsp" class="active main-link">ADD EXAM</a></li>
			<li><a href="addQue.jsp" class=" main-link">ADD QUESTION</a></li>
			<li><a href="addMarks.jsp" class="main-link">ADD MARKS</a></li>
			<li><a href="calculateAttainment.jsp" class="main-link">VIEW
					ATTAINMENT</a></li>
			<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
		</ul>
	</div>
</div>
<!-- navigation ENDS here -->
</div>
<%-- <a href="addCo.jsp">Add CO</a><br/>
        <a href="addExam.jsp">Add Exam</a><br/>
        <a href="addQue.jsp">Add Question</a><br/>
        <a href="addMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/>--%>

<div class="container" style="width: 80%; margin-bottom: 100px">
	<h3 id="head" style="text-align: center; padding-bottom: 10px;">ADD
		AN EXAMINATION</h3>
	<form method="POST">
		<%-- ExamID:        <input type="number" name="exam_id"/><br/> --%>
		<div class="form-row">
			<div class="col-sm">
				<label for="examName">Exam Name:</label> <input type="text"
					class="uk-input" id="exam_name" name="exam_name"
					placeholder="EXAM NAME" />
			</div>
			
			<div class="col-sm">
					<label for="examTypeID">Category of Exam:</label>
					<select class="uk-select" name="exam_type" id="exam_type">
						<option value=0 disabled selected>SELECT CATEGORY OF EXAM</option>
						<%
							rsExamType=con.SelectData("select * from examtype_master;");
							while(rsExamType.next()){
								out.println("<option value="+rsExamType.getInt("examtypeID")+">"+rsExamType.getString("typeDescription")+"</option>");
							}
						%>
					</select>
				</div>
		</div>
		<%-- EXAM Date:     <input type="date" name="exam_date"/><br/> --%>
		<div class="form-row">
			<div class="col-sm">
					<label for="subjectID">Subject:</label>
					<select class="uk-select" name="subject_id" id="subject_id">
						<option value=0 disabled selected>SELECT SUBJECT</option>
						<%
							rsAllSubject=con.SelectData("select * from subject_master where subjectID in(select distinct subjectID from co_master where facultyID="+session.getAttribute("facultyID")+");");
							while(rsAllSubject.next()){
								out.println("<option value="+rsAllSubject.getInt("subjectID")+">"+rsAllSubject.getString("subjectName")+"</option>");
							}
						%>
					</select>
				</div>
			
			<div class="col-sm">
				<label for="totalMarks">Total Marks:</label> <input type="number"
					class="uk-input" id="total_max_marks" name="total_max_marks"
					placeholder="Total Marks" />
			</div>
		</div>
		<div class="form-row">
			<div class="col-sm">
				<label for="weightage">Weightage:</label> <input type="number"
					class="uk-input" id="weightage" name="weightage"
					placeholder="Weightage" />
			</div>
			<!-- MaxWeightMarks:<input type="text" name="max_weighted_marks"/><br/>:::Calculated Based on Type Of Exam::: -->

			
			<div class="col-sm">
				<label for="batch">Batch: </label> <input type="number"
					class="uk-input" id="batch" name="batch" placeholder="Batch" />
			</div>

		</div>
		<center class="mt-3">
			<button type="submit" class="btn" name="submit" value="submit">Submit</button>
		</center>
		<%
				
					/*float exam_weightage=0;
					int n_marks1 = 0;
					float MaxWeightMarks = 0;*/
					if (request.getParameter("submit") != null) {
						int i = Integer.parseInt(request.getParameter("exam_type"));
						rs = con.SelectData("select * from examtype_master where examTypeID=" + i + ";");
						if (con.Ins_Upd_Del(
								"insert into exam_master(examName,batch,totalMaxMarks,weightage,subjectID,examTypeID,facultyID) VALUES('"
										+ request.getParameter("exam_name") + "'," + request.getParameter("batch") + ","
										+ request.getParameter("total_max_marks") + "," + request.getParameter("weightage")
										+ "," + request.getParameter("subject_id") + "," + i + ","
										+ session.getAttribute("facultyID") + ");"))
							out.println("<script>alert('Record inserted......');</script>");
						else
							out.println("<script>alert('Record was not inserted......');</script>");
					}
				}
			%>
	</form>

<%@include file="/footer.jsp"%>