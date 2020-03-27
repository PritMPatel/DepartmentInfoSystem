<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%
	ResultSet rsBatch=null;
	ResultSet rsAllSubject=null;
	int userDept=0;
	con=new Connect();
%>
<div id="subjectBatch">

	<div class="form-row">
		<div class="col-sm"></div>
		<div class="col-sm">
			<label for="subjectID">Subject:</label> <select class="uk-select" name="subjectid" id="subjectid" required>
				<option value="" disabled selected>Select Subject</option>
				<%
							if (session.getAttribute("facultyDepartment") != null) {
								userDept = (int) session.getAttribute("facultyDepartment");
							}
							rsAllSubject=con.SelectData("select * from subject_master where subjectID in(select distinct subjectID from exam_master where facultyID="+session.getAttribute("facultyID")+");");
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
			<label for="batch">Batch:</label> <select class="uk-select" name="batch1" id="batch1" required>
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
	<center class="mt-3">
		<button name="next" class="btn" value="next">Next</button>
		<br />
	</center>
</div>