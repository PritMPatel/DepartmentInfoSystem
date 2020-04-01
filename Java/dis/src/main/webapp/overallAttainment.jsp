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
		width: 100% !important;
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

<%-- NAVIGATION --%>
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
					<li><a href="viewMarks.jsp" class="main-link">VIEW
							MARKS</a></li>
					<li><a href="calculateAttainment.jsp" class="active main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
	</div>
</div>
</div>

<div class="container" style="width: 80%; margin-bottom: 90px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">OVERALL ATTAINMENT</h3>
	<form method="POST" id="new">

    <%
    Connect con=null;
    ResultSet rsEnrollments=null;
	ResultSet rsCo=null;
	ResultSet rsSubject=null;
	ResultSet rsOverall=null;
	ResultSet rsCoAttain=null;
	ResultSet rsCoWiseMax=null; 
	ResultSet rsCoTotal=null;
	ResultSet rsPendingCoAttain = null;

	int nOfCo=0;
	int x1=1;
    con=new Connect();
    %>
    <%
    if(request.getParameter("submitOverall")==null && request.getParameter("submitOverallAttain")==null){
			response.sendRedirect("calculateAttainment.jsp");
	}
    if(request.getParameter("submitOverall")!=null){
        out.println("<form method='POST' action='dis/calculateAttainment.jsp'><input type='number' name='subject_id' value='"+request.getParameter("subject_id")+"' readonly hidden/>");
		out.println("<input type='number' name='batch' value='"+request.getParameter("batch")+"' readonly hidden/>");	

		rsCo=con.SelectData("select * from co_master where subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+" and facultyID="+(int)session.getAttribute("facultyID")+" order by coID;");
	
		rsCo.last();
		nOfCo=rsCo.getRow();
		rsCo.beforeFirst();

		String coMarksQuery = "select * from (";
		int x=1;
		while(x<=nOfCo && rsCo.next()){
			coMarksQuery += "(select "+rsCo.getInt("coID")+" as coID,round(sum(nCalcQuesMaxMarks),2) as coWeighTotal from question_master where "+rsCo.getInt("coID")+" in (coID1,coID2,coID3,coID4,coID5,coID6,coID7))";
			if(x<nOfCo){
				coMarksQuery += " UNION ALL ";
			}else{
				coMarksQuery += ") as t1";
			}
			x++;
		}
		rsCo.beforeFirst();

		rsCoWiseMax=con.SelectData(coMarksQuery+";");
		rsCoTotal=con.SelectData("select sum(t.coWeighTotal) as total from ("+coMarksQuery+") as t;");
		rsCoTotal.next();

		String attainmentOverallQuery = "select enrollmentno,round(sum(c)/"+rsCoTotal.getFloat("total")+",2) as overallAttainment from (select enrollmentno,(coAttainmentLevel*coWeighTotal) as c from attainment_co,("+coMarksQuery+") as t where t.coID=attainment_co.coID) as t1 group by enrollmentno order by enrollmentno;";
		rsOverall = con.SelectData(attainmentOverallQuery);

		rsCoAttain = con.SelectData("select enrollmentno,coAttainmentLevel from attainment_co where coID in (select coID from co_master where subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+") order by enrollmentno,coID;");

		rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subject_id")+";");
		rsSubject.next();

        rsEnrollments=con.SelectData("select enrollmentno from student_master where batch="+request.getParameter("batch")+" and studentDepartment="+(int)session.getAttribute("facultyDepartment")+" order by enrollmentno;");
		
		//BUTTONS
		
		out.println("<div class='form-row'><div class='col-sm'><center class=\"mt-4\">"+
					"<button type='button' class='btn' onclick='goBack()'>Go Back</button>"+
					"</center></div>");
		out.println("<div class='col-sm'><center class=\"mt-4\">"+
					"<a href='calculateAttainment.jsp'><button class='btn' type='button'>Reset</button></a>"+
					"</center></div>");	
		out.println("<div class='col-sm'><center class=\"mt-4\">"+
					"<button type='button' class='btn' id='exportExcel' value='OVERALL-"+rsSubject.getString("subjectName")+"-B"+request.getParameter("batch")+"' >Export to Excel</button>"+
					"</center></div>");				
		out.println("<div class='col-sm'><center class=\"mt-4 mb-5\">"+
					"<button class='btn' type='button' onclick='printDiv();'>Print</button>"+
					"</center></div></div>");
		
		if(!con.CheckData("select distinct subjectID from attainment_overall,student_master where attainment_overall.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+";")){
					out.println("<div class='form-row'><div class='col-sm'></div><div class='col-sm'><center>"+
						"<button class='btn' type='submit' name='submitOverallAttain' id='submitOverallAttain' value='submitOverallAttain' formaction='/dis/calculateAttainment.jsp' style='margin:30px; margin-top: 0px; background-color: #cf6766; color: white;'>Save</button>"+
						"</center></div><div class='col-sm'></div></div>");
				}

		//TABLE
		out.println("<div id='attainment' class='uk-overflow-auto' align='center'><table id='attainmentOverall' class='uk-table'>");

		out.println("<tr><th bgcolor='#e1e19b'><center><b>Subject</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+rsSubject.getString("subjectName")+"</b></center></th></tr>");
		out.println("<tr><th bgcolor='#e1e19b'><center><b>Batch</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+request.getParameter("batch")+"</b></center></th></tr>");
		out.println("<tr><th bgcolor='#e1e19b'><center><b>Faculty</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+session.getAttribute("getfacultyName")+"</b></center></th></tr>");
		out.println("<tr><td colspan='"+(nOfCo+2)+"' bgcolor='#cf6766'></td></tr>");
		
		out.println("<tr><th bgcolor='#e1e19b'><center><b>CO</b></center></th>");
		while(rsCo.next()){
			out.println("<th bgcolor='silver'><center><b>"+rsCo.getInt("coSrNo")+"</b></center></th>");
		}
		out.println("<th bgcolor='silver'><center><b>Total</b></center></th></tr>");
		out.println("<tr><th bgcolor='#e1e19b'><center><b>Max Marks</b></center></th>");
		while(rsCoWiseMax.next()){
			out.println("<th><center><b>"+rsCoWiseMax.getFloat("coWeighTotal")+"</b></center></th>");
		}
		out.println("<th><center><b>"+rsCoTotal.getFloat("total")+"</b></center></th></tr>");
		out.println("<tr><td colspan='"+(nOfCo+2)+"' bgcolor='#cf6766'></td></tr>");
		out.println("<tr style='border-top: 2px solid; border-bottom: 2px solid;'><th colspan='"+(nOfCo+2)+"' bgcolor='silver'><center><b>Overall Subject Attainment</b></center></th></tr>");
		out.println("<tr style='border-top: 2px solid; border-bottom: 2px solid;'><th bgcolor='#e1e19b' rowspan='1'><center><b>Enrollment</b></center></th>");
		rsCo.beforeFirst();
		while(rsCo.next()){
			out.println("<th bgcolor='silver' rowspan='1'><center><b>CO-"+rsCo.getInt("coSrNo")+"</b></center></th>");
		}
		out.println("<th rowspan='1' bgcolor='#e1e19b'><center><b>Overall Attainment</center></b></th></tr>");
		out.println("<tr></tr>");
		
		while(rsEnrollments.next() && rsOverall.next()){
			x=1;
			out.println("<tr>");
			out.println("<td><input type='text' name='enroll"+x1+"' value='"+rsEnrollments.getString("enrollmentno")+"' readonly hidden><center><b>"+rsEnrollments.getString("enrollmentno")+"</b></center></td>");
			while(x<=nOfCo && rsCoAttain.next()){
				out.println("<td><center>"+rsCoAttain.getInt("coAttainmentLevel")+"</center></td>");
				x++;
			}
			out.println("<td><input type='number' name='oAtt"+x1+"' step='0.01' value='"+rsOverall.getFloat("overallAttainment")+"' readonly hidden><center>"+rsOverall.getFloat("overallAttainment")+"</center></td>");
			out.println("</tr>");
			x1++;
		}
        out.println("</table></div></form>");
    }
	if(request.getParameter("submitOverallAttain")!=null){
				rsEnrollments=con.SelectData("select enrollmentno from student_master where batch="+request.getParameter("batch")+" and studentDepartment="+(int)session.getAttribute("facultyDepartment")+" order by enrollmentno;");
				rsEnrollments.last();
				int nOfStudent=rsEnrollments.getRow();
				String value = "";
				x1=1;
				while(x1<=nOfStudent){
					value += "('"+request.getParameter("enroll"+x1)+"',"+request.getParameter("oAtt"+x1)+","+request.getParameter("subject_id")+")";
					if(x1!=nOfStudent){
						value+=",";
					}
					x1++;
				}
				if(con.Ins_Upd_Del("insert into attainment_overall (enrollmentno,attainmentOverall,subjectID) values "+value+";")){
					out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Data Saved Successfully.</b></div>')</script>");        
					con.commitData();
				}
				else{
					out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Try Again Later.</div>')</script>");
					con.rollbackData();
				}
			}
    %>
    <%-- <th bgcolor='#e1e19b' colspan='"+nOfCo+"'><center><b>Attainment Level</center></b></th></tr><tr> --%>
    <script type="text/javascript">
	function printDiv() {
                    var divName= "attainment";

                     var printContents = document.getElementById(divName).innerHTML;
                     var originalContents = document.body.innerHTML;

                     document.body.innerHTML = printContents;

                     window.print();

                    document.body.innerHTML = originalContents;
                }
	function goBack(){window.history.back()}
	$(function() {
				$("#exportExcel").click(function(){
				var name= $("#exportExcel").val();
				$("#attainmentOverall").table2excel({
					exclude: ".noExl",
    				filename: name,
					fileext:".xls",
					preserveColors:true
				}); 
		});
	});
	</script>
    </form>
</div>
    <%@include file="/footer.jsp"%>
<%
  }
  else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>