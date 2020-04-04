
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
	ResultSet rsSemester=null;
	ResultSetMetaData mtdt = null;
	con = new Connect();
	int userDept = 0;
	if (session.getAttribute("facultyDepartment") != null) {
		userDept = (int)session.getAttribute("facultyDepartment");
	}
%>
<style>
.uk-accordion-title:focus{
	color: #000 !important;
}
.uk-badge{
	padding-bottom: 2px;
	margin-bottom: 5px;
	background: #cf6766;
	color: white;
	margin-left: 25px;
}
h3{
	margin: 0px !important;
}
.uk-card-body{
	padding: 10px;
}
.uk-accordion-title:hover{
	color: #cf6766 !important;
}
a:hover{
	color: #cf6766;
}
.uk-card-default {
    background: #fff;
    color: #333;
    box-shadow: 0 5px 15px rgba(0, 0, 0, .25);
    border: 1px solid #cf6766;
}
</style>
<title>HOME</title>

		<div class="navigation" id="navbar">
			<div class="dropdown">
				<!-- navigation STARTS here -->
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="facultyHome.jsp" class="active main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="facultyAddCo.jsp" class="main-link">ADD CO</a></li>
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
					<li><a href="#" class="main-link">UPDATE CO</a></li>
					<li><a href="#" class="main-link">UPDATE
							EXAM</a></li>
					<li><a href="#" class="main-link">UPDATE
							QUESTION</a></li>
					<li><a href="#" class="main-link">UPDATE
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

<div class="container" style="width: 90%; margin-bottom: 100px;">
	<div id="head"></div>
	<%
	rsBatch=con.SelectData("select distinctrow batch from attainment_overall,student_master,subject_master where attainment_overall.enrollmentno=student_master.enrollmentno and subject_master.subjectID=attainment_overall.subjectID and subject_master.subjectID in (select subjectID from co_master where facultyID="+(int)session.getAttribute("facultyID")+") and batch in (select batch from co_master where facultyID="+(int)session.getAttribute("facultyID")+") order by batch desc,semester desc,subject_master.subjectID asc;");
	
	%>	
	<ul uk-accordion>
	<li>
	<a class="uk-accordion-title" href="javascript:void(0)"><h3 class="uk-heading-bullet">OVERALL ATTAINMENT</h3></a>
	<div class="uk-accordion-content">
	<ul uk-accordion style="padding-left: 15px;">
	<%
	while(rsBatch.next()){
	%>
    <li>
        <a class="uk-accordion-title" href="javascript:void(0)"><%=rsBatch.getInt("batch")%></a>
		<%
		rsSemester=con.SelectData("select distinctrow semester from attainment_overall,student_master,subject_master where attainment_overall.enrollmentno=student_master.enrollmentno and subject_master.subjectID=attainment_overall.subjectID and subject_master.subjectID in (select subjectID from co_master where facultyID="+(int)session.getAttribute("facultyID")+") and batch in (select batch from co_master where facultyID="+(int)session.getAttribute("facultyID")+") order by batch desc,semester desc,subject_master.subjectID asc;");
		%>
        <div class="uk-accordion-content">
            <ul uk-accordion style="padding-left: 30px;">
			<%
			while(rsSemester.next()){
			%>
			<li>
				<a class="uk-accordion-title" href="#">Semester <%=rsSemester.getInt("semester")%></a>
				<div class="uk-accordion-content">
					<div class="uk-text-center uk-child-width-1-3@s uk-child-width-1-4@m" uk-grid uk-height-match="target: > div > a > .uk-card">
					<%
					rsAllSubject=con.SelectData("select distinctrow batch,semester,subject_master.subjectID,subjectName from attainment_overall,student_master,subject_master where attainment_overall.enrollmentno=student_master.enrollmentno and subject_master.subjectID=attainment_overall.subjectID and subject_master.subjectID in (select subjectID from co_master where facultyID=1) and batch in (select batch from co_master where facultyID=1) and batch="+rsBatch.getInt("batch")+" and semester="+rsSemester.getInt("semester")+" order by batch desc,semester desc,subject_master.subjectID asc;");
					while(rsAllSubject.next()){
					%>
						<div style="border-color: #cf6766;">
							<a href="#" class="attainment" id="<%=rsBatch.getInt("batch")%>-<%=rsAllSubject.getInt("subject_master.subjectID")%>" style="text-decoration:none;"><div class="uk-card uk-card-default uk-card-body"><%=rsAllSubject.getString("subjectName")%></div></a>
						</div>
					<%
					}
					rsAllSubject.close();
					%>
					</div>
				</div>
			</li>
			<%
			}
			rsSemester.close();
			%>
			
			</ul>
        </div>
    </li>
	<%	
	}
	rsBatch.close();
	%>
	</ul>
	</div>
	</li>
	</ul>
	<form method="post" action="/dis/overallAttainment.jsp" id="attainForm" hidden>
		<input type="number" name="subject_id" id="subject" hidden>
		<input type="number" name="batch" id="batch" hidden>
		<input type="text" name="submitOverall" value="submitOverall" hidden>
	</form>
	<script type="text/javascript">
		$(document).on("click",".attainment",function(){
			var values = this.id.split("-");
			$("#subject").attr("value",values[1]);
			$("#batch").attr("value",values[0]);
			$("#attainForm").submit();
		});
	</script>

<%@include file="/footer.jsp"%>
<%
  }
  else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
  %>