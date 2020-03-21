<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title>ATTAINMENT</title>
		<script src="js/jquery-3.2.1.min.js"></script>
		<script src="js/jquery.table2excel.js"></script>
		<style type="text/css" media="print">
			.page
			{
			-webkit-transform: rotate(-90deg); 
			-moz-transform:rotate(-90deg);
			filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=2);
			}
		</style>
		<style>
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
	</head>
	<body>
		<a href="addCo.jsp">Add CO</a><br/>
		<a href="addExam.jsp">Add Exam</a><br/>
		<a href="addQue.jsp">Add Question</a><br/>
		<a href="addMarks.jsp">Add Marks</a><br/>
		<a href="calculateAttainment.jsp">Calculate Attainment</a><br/>
		<br/><br/>
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
			ResultSet rsBatch=null;
			ResultSet rsTotalCalcMax=null;
			ResultSet rsTotalNCalcMax=null;
			ResultSet rsCo=null;
			ResultSet rsSubject=null;
			String s = "";
			int coCounter=0;
			int i=1;
			con=new Connect();
		%>
		<form method="POST">
		<div id="selectco">
            SubjectID:<input type="number" name="subjectid"/><br/> 
            Batch:<select name="batch1" id="batch1"><option value=0 disabled selected>Select Batch</option>
			<%
				rsBatch=con.SelectData("select distinct batch from student_master");
				while(rsBatch.next()){
					out.println("<option value="+rsBatch.getInt("batch")+">"+rsBatch.getInt("batch")+"</option>");
				}
			%>
			</select><br/>
            <button id="coselect" name="coselect" value="coselect">Select CO</button><br/>
    	</div>

		<%
		if(request.getParameter("coselect")!=null){
                        rsCo=con.SelectData("select * from co_master where coID not in(SELECT coID FROM attainment_co,student_master where attainment_co.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subject1")+" and batch="+request.getParameter("batch1")+");");
                        out.println("SubjectID:<input type='number' name='subject_id' value='"+request.getParameter("subjectid")+"'/><br/> ");
                        out.println("Batch:<input type='number' name='batch' value='"+request.getParameter("batch1")+"'/><br/> ");
                        out.println("CO:<select name='co_id'><option disabled selected>Select CO</option>");
						out.println("<script type='text/javascript'>$(document).change(function(){$('#subjectid #batch1').attr('disabled','true');}); </script>");
                        while(rsCo.next()){
                            out.println("<option value='"+rsCo.getInt("coID")+"'>"+rsCo.getInt("coSrNo")+" - "+rsCo.getString("coStatement")+"</option>");
                        }
                        out.println("</select></br>");
						out.println("<button name='viewattain' value='viewattain'>View Attainment</button><br/>");
						out.println("<a href='calculateAttainment.jsp'><button type='button'>Reset</button></a><br/>");
                    }
		if(request.getParameter("viewattain")!=null){
				out.println("SubjectID:<input type='number' name='subject_id' value='"+request.getParameter("subject_id")+"' disabled/><br/> ");
            	out.println("Batch:<input type='number' name='batch' value='"+request.getParameter("batch")+"' disabled/><br/> ");
				out.println("CO:<input type='number' name='coid' value='"+request.getParameter("co_id")+"' disabled/><br/>");
		%>
		<a href='calculateAttainment.jsp'><button type='button'>Reset</button></a><br/>
		<%
				rsCo=con.SelectData("select * from co_master where coID not in(SELECT coID FROM attainment_co,student_master where attainment_co.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+") and coID="+request.getParameter("co_id")+";");
				rsCo.next();
				rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subject_id")+";");
				rsSubject.next();
				out.println("<button type='button' id='exportExcel' value='"+rsSubject.getString("subjectName")+"-CO"+rsCo.getInt("coSrNo")+"-B"+request.getParameter("batch")+"'>Export to Excel</button><br/><br/>");
				out.println("<button type='button' onclick='printDiv();'>Print</button>");

				out.println("<div id='attainment'><table id='attainCalculation'>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>Subject</b></center></th><th colspan='4'><center><b>"+rsSubject.getString("subjectName")+"</b></center></th></tr>");
            	out.println("<tr><th bgcolor='#e1e19b'><center><b>Batch</b></center></th><th colspan='4'><center><b>"+request.getParameter("batch")+"</b></center></th></tr>");
				out.println("<tr><th bgcolor='#e1e19b'><center><b>CO</b></center></th><th colspan='4'><center><b>"+request.getParameter("co_id")+"</b></center></th></tr>");
				out.println("<tr><td></td></tr>");
				out.println("<tr><th rowspan='5' bgcolor='#e1e19b'><center><b>Enrollment</b></center></th>");
				rs0=con.SelectData("select count(typeDescription)*2 as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID="+request.getParameter("co_id")+") IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch="+request.getParameter("batch")+" and exam_master.subjectID="+request.getParameter("subject_id")+") order by enrollmentno,typeDescription,examName,QueDesc) as t;");
				if(rs0.next()){
					out.println("<th colspan='"+rs0.getInt("colspan")+"' bgcolor='lightgrey'><center><b>CO-"+rsCo.getInt("coSrNo")+"</b></center></th>");
				}
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
				rs4=con.SelectData("select enrollmentno from student_master where batch="+request.getParameter("batch")+";");
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
						out.println("<td colspan=1 bgcolor='lightsalmon'><center>"+rs6.getFloat("attainPercent")+"</center></td>");
						float percent=rs6.getFloat("attainPercent");
						out.println("<td colspan=1 bgcolor='thistle'><center>");
						if(percent>=70)
							out.println("3");
						else if(percent>=55)
							out.println("2");
						else if(percent>=40)
							out.println("1");
						else
							out.println("0");
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
</html>