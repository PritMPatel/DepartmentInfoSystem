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
	<title>CALCULATE ATTAINMENT</title>
	<script src="js/jquery.table2excel.js"></script>
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
			<li><a href="addCo.jsp" class="main-link">ADD CO</a></li>
			<li><a href="addExam.jsp" class="main-link">ADD EXAM</a></li>
			<li><a href="addQue.jsp" class="main-link">ADD QUESTION</a></li>
			<li><a href="addMarks.jsp" class="main-link">ADD
					MARKS</a></li>
			<li><a href="calculateAttainment.jsp" class="active main-link">VIEW
					ATTAINMENT</a></li>
			<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
		</ul>
	</div>
</div>
<!-- navigation ENDS here -->
</div>
	<div class="container" style="width: 80%; margin-bottom: 0px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">VIEW ATTAINMENT</h3>
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
		
		if(request.getParameter("next")==null && request.getParameter("viewattain")==null){%>
			<%@include file="subjectBatchForm.jsp"%>
		<%}
		if(request.getParameter("next")!=null){
                        rsCo=con.SelectData("select * from co_master where subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+" and facultyID="+(int)session.getAttribute("facultyID")+";");
						if(!rsCo.next()){
							out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ACCESS DENIED</b>: You can't Access requested Data.'.</div>')</script>");
							response.sendRedirect("dis/calculateAttainment.jsp");
						}
						rsCo.beforeFirst();
                        rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
						rsSubject.next();
						out.println("<div class='form-row'><div class='col-sm'><label for='subjectID'>Subject:</label><input type='number' class='uk-input' id='subject_id' name='subject_id' value='"+request.getParameter("subjectid")+"' hidden/><input type='text' class='uk-input' id='subjectName' name='subjectName' value='"+ rsSubject.getString("subjectName")+"' readonly/></div>");
						out.println("<div class='col-sm'><label for='batch'>Batch:</label><input type='number' name='batch' class='uk-input' id='batch1' value='"
										+ request.getParameter("batch1") + "' readonly/></div></div> ");
						out.println("<div class='form-row'><div class='col-sm'><label for='coID'>Course Outcome:</label><select class='uk-select' id='co_id' name='co_id' required><option value='' selected disabled>Select CO</option>");
                        while(rsCo.next()){
                            out.println("<option value='"+rsCo.getInt("coID")+"'>"+rsCo.getInt("coSrNo")+" - "+rsCo.getString("coStatement")+"</option>");
                        }
                        out.println("</select></br>");
						out.println("<center class=\"mt-3\">"+
								"<button type=\"submit\" class=\"btn\" name=\"viewattain\" value=\"viewattain\" style='margin:30px;'>Submit</button>"+
								"<a href='calculateAttainment.jsp'><button class='btn' type='button' style='margin:30px;'>Reset</button></a>"+
							"</center>");
                    }
		if(request.getParameter("viewattain")!=null){
				out.println("<input type='number' name='subject_id' value='"+request.getParameter("subject_id")+"' readonly hidden/>");
            	out.println("<input type='number' name='batch' value='"+request.getParameter("batch")+"' readonly hidden/>");
				out.println("<input type='number' name='coid' value='"+request.getParameter("co_id")+"' readonly hidden/>");
				%>
				<%
				//rsCo=con.SelectData("select * from co_master where coID not in(SELECT coID FROM attainment_co,student_master where attainment_co.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+") and coID="+request.getParameter("co_id")+";");
				rsCo=con.SelectData("select * from co_master where coID="+request.getParameter("co_id")+";");
				rsCo.next();
				rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subject_id")+";");
				rsSubject.next();
				out.println("<div class='form-row'><div class='col-sm'><center class=\"mt-3\">"+
					"<a href='calculateAttainment.jsp'><button class='btn' type='button' style='margin:30px;'>Reset</button></a>"+
				"</center></div>");
				out.println("<div class='col-sm'><center class=\"mt-3\">"+
					"<button type='button' class='btn' id='exportExcel' value='"+rsSubject.getString("subjectName")+"-CO"+rsCo.getInt("coSrNo")+"-B"+request.getParameter("batch")+"' style='margin:30px;'>Export to Excel</button>"+
				"</center></div>");				
				out.println("<div class='col-sm'><center class=\"mt-3\">"+
					"<button class='btn' type='button' onclick='printDiv();' style='margin:30px;'>Print</button>"+
				"</center></div></div>");
				
				if(!con.CheckData("select distinct coID from attainment_co where coID="+request.getParameter("co_id")+";")){
					out.println("<div class='form-row'><div class='col-sm'></div><div class='col-sm'><center>"+
						"<button class='btn' type='submit' value='submit' style='margin:30px; margin-top: 0px; background-color: #cf6766; color: white;'>Save</button>"+
						"</center></div><div class='col-sm'></div></div></div>");
				}
				
				out.println("<div class=\"container\" style=\"width: 100%; margin-bottom: 100px; max-width: 90vw;margin-top:0px;\">");
				
				rs0=con.SelectData("select count(typeDescription)*2 as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+") order by enrollmentno,typeDescription,examName,QueDesc) as t;");
				int cls=0;
				int tps=0;
				if(rs0.next()){
					cls = rs0.getInt("colspan");
				}
				if(cls+4>14){
					tps=14;
				}
				else{
					tps=cls+4;
				}
				out.println("<div id='attainment' class='uk-overflow-auto' align='center'><table id='attainCalculation' class='uk-table'>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Subject</b></center></th><th colspan='"+tps+"'><center><b>"+rsSubject.getString("subjectName")+"</b></center></th></tr>");
            	out.println("<tr><th bgcolor='#e1e19b'><center><b>Batch</b></center></th><th colspan='"+tps+"'><center><b>"+request.getParameter("batch")+"</b></center></th></tr>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Faculty</b></center></th><th colspan='"+tps+"'><center><b>"+session.getAttribute("getfacultyName")+"</b></center></th></tr>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>CO</b></center></th><th colspan='"+tps+"'><center><b>"+rsCo.getInt("coSrNo")+"</b></center></th></tr>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Statement</b></center></th><th colspan='"+tps+"'><center><b>"+rsCo.getString("coStatement")+"</b></center></th></tr>");
				out.println("<tr><td></td></tr>");
				out.println("<tr><th rowspan='5' bgcolor='#e1e19b'><center><b>Enrollment</b></center></th>");
				out.println("<th colspan='"+cls+"' bgcolor='lightgrey'><center><b>CO-"+rsCo.getInt("coSrNo")+"</b></center></th>");
				out.println("<th rowspan='4' colspan='2' bgcolor='peachpuff'><center><b>Total</b></center></th>");
				out.println("<th rowspan='5' colspan='1' bgcolor='lightsalmon'><center><b>Attainment</b></center></th>");
				out.println("<th rowspan='5' colspan='1' bgcolor='thistle'><center><b>Attainment Level</b></center></th>");
				out.println("</tr><tr>");
				rs=con.SelectData("select typeDescription,count(examName)*2 as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")) as t group by typeDescription order by typeDescription,examName,QueDesc;");
				while(rs.next()){
					out.println("<th colspan='"+rs.getInt("colspan")+"' bgcolor='silver'><center><b>"+rs.getString("typeDescription")+"</b></center></th>");
				}
				out.println("</tr><tr>");
				rs2=con.SelectData("select examName,count(queDesc)*2 as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")) as t group by examName order by typeDescription,examName,QueDesc;");
				while(rs2.next()){
					out.println("<th colspan='"+rs2.getInt("colspan")+"' bgcolor='gold'><center><b>"+rs2.getString("examName")+"</b></center></th>");
				}
				out.println("</tr><tr>");
				rs3=con.SelectData("select distinctrow typeDescription,examName,queDesc,round(calcQuesMaxMarks,2) as calcQuesMaxMarks,round(nCalcQuesMaxMarks,2) as nCalcQuesMaxMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+") order by enrollmentno,typeDescription,examName,QueDesc;");
				while(rs3.next()){
					out.println("<th colspan='2' bgcolor='lightblue'><center><b>"+rs3.getString("queDesc")+"</b></center></th>");
				}
				out.println("</tr><tr>");
				rs3.beforeFirst();
				while(rs3.next()){
					out.println("<th colspan='1' bgcolor='lightblue'><center><b>"+rs3.getString("calcQuesMaxMarks")+"</b></center></th><th colspan='1' bgcolor='lightblue'><center><b>"+rs3.getString("nCalcQuesMaxMarks")+"</b></center></th>");
				}
				rsTotalCalcMax=con.SelectData("select distinct round(sum(calcQuesMaxMarks),2) as calcTotal from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc;");
				rsTotalCalcMax.next();
				rsTotalNCalcMax=con.SelectData("select distinct round(sum(nCalcQuesMaxMarks),2) as nCalcTotal from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc;");
				rsTotalNCalcMax.next();
				out.println("<th rowspan='1' bgcolor='peachpuff'><center><b>"+rsTotalCalcMax.getFloat("calcTotal")+"</b></center></th>");
				out.println("<th rowspan='1' bgcolor='peachpuff'><center><b>"+rsTotalNCalcMax.getFloat("nCalcTotal")+"</b></center></th>");
				out.println("</tr>");
				rs4=con.SelectData("select enrollmentno from student_master where batch="+request.getParameter("batch")+" and studentDepartment="+(int)session.getAttribute("facultyDepartment")+";");
				while(rs4.next()){
					out.println("<tr>");
					out.println("<td bgcolor='#e1e19b'><center><b>"+rs4.getString("enrollmentno")+"</b></center></td>");
					rs5=con.SelectData("select enrollmentno,typeDescription,examName,queDesc,round(calcObtainedMarks,2) as calcObtainedMarks,round(nCalcObtainedMarks,2) as nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where enrollmentno=\""+rs4.getString("enrollmentno")+"\" and question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")  order by enrollmentno,typeDescription,examName,QueDesc;");
					while(rs5.next()){
						out.println("<td colspan=2><center>"+rs5.getFloat("calcObtainedMarks")+"</center></td>");
					}
					rs6=con.SelectData("select enrollmentno,round(totalCalcObt,2) as totalCalcObt,round(totalNCalcObt,2) as totalNCalcObt,round(totalNCalcObt*100/maxNCalcObt,2) as attainPercent from (select enrollmentno,sum(calcQuesMaxMarks),sum(calcObtainedMarks) as totalCalcObt,sum(nCalcQuesMaxMarks) as maxNCalcObt,sum(nCalcObtainedMarks) as totalNCalcObt from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where enrollmentno=\""+rs4.getString("enrollmentno")+"\" and question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+")) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc) as t;");
					if(rs6.next()){
						out.println("<td colspan=1 bgcolor='peachpuff'><center>"+rs6.getFloat("totalCalcObt")+"</center></td>");
						out.println("<td colspan=1 bgcolor='peachpuff'><center>"+rs6.getFloat("totalNCalcObt")+"</center></td>");
						out.println("<td colspan=1 bgcolor='lightsalmon' ><center>"+rs6.getFloat("attainPercent")+"<input type='number' id='atTable' class='uk-input uk-form-blank uk-form-small uk-width-xsmall' step='0.01' value='"+rs6.getFloat("attainPercent")+"' readonly hidden/></center></td>");
						float percent=rs6.getFloat("attainPercent");
						int lvl=0;
						if(percent>=70)
							lvl=3;
						else if(percent>=55)
							lvl=2;
						else if(percent>=40)
							lvl=1;
						else
							lvl=0;
						out.println("<td colspan=1 bgcolor='thistle'><center>"+lvl+"<input type='number' id='atTable' class='uk-input uk-form-blank uk-form-small uk-width-xsmall' value='"+lvl+"' hidden readonly/>");
						
						out.println("</center></td>");
					}
					out.println("</tr>");
				}

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
				$("#attainCalculation").table2excel({
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