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
	<title>CALCULATE ATTAINMENT</title>
	<script src="js/jquery.table2excel.js"></script>
		<style type="text/css">
		@media print {@page { size: landscape;}}
		table{
		border-collapse: collapse;
		}
		th,td{
			border: 1px solid black;
			
			text-align: center;
			vertical-align: center;
			padding: 2px 5px;
		}
		</style>
<style type="text/css">
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
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
		<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i
			class="fa fa-bars mr-3"></i>Show Menu</label> <input type="checkbox" id="show-menu" role="button">
		<ul id="menu">
					<li><a href="facultyHome.jsp" class="main-link">HOME</a></li>
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
					<li><a href="viewMarks.jsp" class="active main-link">VIEW
							MARKS</a></li>
					<li><a href="calculateAttainment.jsp" class="main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
	</div>
</div>
<!-- navigation ENDS here -->
</div>
	<div class="container" style="width: 80%; margin-bottom: 0px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">VIEW MARKS</h3>
	<form method="POST">

		<%-- <a href="addCo.jsp">Add CO</a><br/>
		<a href="addExam.jsp">Add Exam</a><br/>
		<a href="addQue.jsp">Add Question</a><br/>
		<a href="addMarks.jsp">Add Marks</a><br/>
		<a href="calculateAttainment.jsp">Calculate Attainment</a><br/>
		<br/><br/> --%>
		<%
			Connect con=null;
			ResultSet rs0=null;
			ResultSet rs=null;
			ResultSet rs2=null;
			ResultSet rs3=null;
			ResultSet rs4=null;
			ResultSet rs5=null;
			ResultSet rs6=null;
			ResultSet rs7=null;
			ResultSetMetaData mtdt=null;
			
			ResultSet rsTotalCalcMax=null;
			ResultSet rsTotalNCalcMax=null;
			ResultSet rsCo=null;
			ResultSet rsSubject=null;
			String s = "";
			int coCounter=0;
			int i=1;
			con=new Connect();
		
		if(request.getParameter("next")==null && request.getParameter("viewmarks")==null){%>
			<%@include file="subjectBatchForm.jsp"%>
		<%}
		if(request.getParameter("next")!=null){
                rsCo=con.SelectData("select * from co_master where subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+" and facultyID="+(int)session.getAttribute("facultyID")+";");
                if(!rsCo.next()){
                    out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ACCESS DENIED</b>: You can't Access requested Data.</div>')</script>");
                    response.sendRedirect("dis/viewMarks.jsp");
                }
                rsCo.beforeFirst();
                rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
                rsSubject.next();
		
				out.println("<div class='form-row'><div class='col-sm'><center class=\"mt-3\">"+
					"<a href='calculateAttainment.jsp'><button class='btn' type='button' style='margin:30px;'>Reset</button></a>"+
				"</center></div>");
				out.println("<div class='col-sm'><center class=\"mt-3\">"+
					"<button type='button' class='btn' id='exportExcel' value='MARKS-"+rsSubject.getString("subjectName")+"-B"+request.getParameter("batch")+"' style='margin:30px;'>Export to Excel</button>"+
				"</center></div>");				
				out.println("<div class='col-sm'><center class=\"mt-3\">"+
					"<button class='btn' type='button' onclick='printDiv();' style='margin:30px;'>Print</button>"+
				"</center></div></div>");
				
				out.println("<div class=\"container\" style=\"width: 100%; margin-bottom: 100px; max-width: 90vw;margin-top:0px;\">");
				
				//rs0=con.SelectData("select count(typeDescription)*2 as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch1")+" and exam_master.subjectID="+request.getParameter("subjectid")+") order by enrollmentno,typeDescription,examName,QueDesc) as t;");
				
				out.println("<div id='attainment' class='uk-overflow-auto' align='center'><table id='marksView' class='uk-table'>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Subject</b></center></th><th colspan='6'><center><b>"+rsSubject.getString("subjectName")+"</b></center></th></tr>");
            	out.println("<tr><th bgcolor='#e1e19b'><center><b>Batch</b></center></th><th colspan='6'><center><b>"+request.getParameter("batch1")+"</b></center></th></tr>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Faculty</b></center></th><th colspan='6'><center><b>"+session.getAttribute("getfacultyName")+"</b></center></th></tr>");
				out.println("<tr><td></td></tr>");
				out.println("<tr><th rowspan='4' bgcolor='#e1e19b'><center><b>Enrollment</b></center></th>");
			
				rs=con.SelectData("select typeDescription,count(typeDescription) as colspan from question_master qm,exam_master em,examtype_master etm where qm.examID=em.examID and em.examtypeID=etm.examtypeID and em.subjectID="+request.getParameter("subjectid")+" and em.facultyID="+(int)session.getAttribute("facultyID")+" and batch="+request.getParameter("batch1")+" and questionID in (select distinct questionId from marks_obtained_master) group by etm.examtypeID order by etm.examtypeID,em.examID,qm.questionID;");
				while(rs.next()){
					out.println("<th colspan='"+rs.getInt("colspan")+"' bgcolor='silver'><center><b>"+rs.getString("typeDescription")+"</b></center></th>");
				}
				out.println("</tr><tr>");
				rs2=con.SelectData("select examName,count(examName) as colspan from question_master qm,exam_master em,examtype_master etm where qm.examID=em.examID and em.examtypeID=etm.examtypeID and em.subjectID="+request.getParameter("subjectid")+" and em.facultyID="+(int)session.getAttribute("facultyID")+" and batch="+request.getParameter("batch1")+" and questionID in (select distinct questionId from marks_obtained_master) group by etm.examtypeID,em.examID order by etm.examtypeID,em.examID,qm.questionID;");
				while(rs2.next()){
					out.println("<th colspan='"+rs2.getInt("colspan")+"' bgcolor='gold'><center><b>"+rs2.getString("examName")+"</b></center></th>");
				}
				out.println("</tr><tr>");
				rs3=con.SelectData("select queDesc,queMaxMarks from question_master qm,exam_master em,examtype_master etm where qm.examID=em.examID and em.examtypeID=etm.examtypeID and em.subjectID="+request.getParameter("subjectid")+" and em.facultyID="+(int)session.getAttribute("facultyID")+" and batch="+request.getParameter("batch1")+" and questionID in (select distinct questionId from marks_obtained_master) order by etm.examtypeID,em.examID,qm.questionID;");
				while(rs3.next()){
					out.println("<th colspan='1' bgcolor='lightblue'><center><b>"+rs3.getString("queDesc")+"</b></center></th>");
				}
				out.println("</tr><tr>");
                rs3.beforeFirst();
                while(rs3.next()){
					out.println("<th colspan='1' bgcolor='lightblue'><center><b>"+rs3.getString("queMaxMarks")+"</b></center></th>");
				}
                rs5=con.SelectData("select enrollmentno,queDesc,obtainedMarks from marks_obtained_master mob,question_master qm,exam_master em,examtype_master etm where qm.examID=em.examID and em.examtypeID=etm.examtypeID and mob.questionID=qm.questionID and em.subjectID="+request.getParameter("subjectid")+" and em.facultyID="+(int)session.getAttribute("facultyID")+" and batch="+request.getParameter("batch1")+" order by enrollmentno,etm.examtypeID,em.examID,qm.questionID;");
                String e = "";
                rs5.beforeFirst();
                while(rs5.next()){
                    if(e.equals(rs5.getString("enrollmentno"))){
                    }
                    else{
                        out.println("</tr><tr><td bgcolor='#e1e19b'><center><b>"+rs5.getString("enrollmentno")+"</b></center></td>");
                        e = rs5.getString("enrollmentno");
                    }
                    out.println("<td colspan=1><center>"+rs5.getFloat("obtainedMarks")+"</center></td>");
                }
                out.println("</tr>");
				out.println("</table></div>");
			}
		%>

		</form>
	</body>
	<script type="text/javascript">
	function printDiv() {
                    var divName= "attainment";

                     var printContents = document.getElementById(divName).innerHTML;
                     var originalContents = document.body.innerHTML;

                     document.body.innerHTML = printContents;

                     window.print();

                     document.body.innerHTML = originalContents;
                }
	$(function() {
				$("#exportExcel").click(function(){
				var name= $("#exportExcel").val();
				$("#marksView").table2excel({
					exclude: ".noExl",
    				filename: name,
					fileext:".xls",
					preserveColors:true
				}); 
		});
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