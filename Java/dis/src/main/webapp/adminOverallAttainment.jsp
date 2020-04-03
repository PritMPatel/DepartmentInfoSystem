<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	//if (!userRole.equals("faculty")){
	//	response.sendRedirect("/dis/login.jsp");
	//}
	if (userRole.equals("admin")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/header.jsp"%>
<title>OVERALL ATTAINMENT</title>
<style>
.uk-table{
    width: 100% !important;
}
</style>
        <div class="navigation" id="navbar">
			<div class="dropdown">
				<!-- navigation STARTS here -->
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="adminHome.jsp" class="main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="addStudents.jsp" class="main-link">ADD STUDENTS</a></li>
                    <li><a href="addSubject.jsp" class="main-link">ADD SUBJECT</a></li>
							</ul></li>
					<li><a href="#" class="main-link">APPROVE &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="approveUser.jsp" class="main-link">APPROVE USER</a></li>
							</ul></li>
					<li><a href="adminOverallAttainment.jsp" class="active main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
			</div>
		</div>
		<!-- navigation ENDS here -->
	</div>  

<div class="container" style="width: 80%; margin-bottom: 100px">
    <div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">OVERALL ATTAINMENT</h3>
<%
    Connect con = new Connect();
    ResultSet rsAllSubject=null;
    ResultSet rsAvgAttain=null;
    ResultSet rsBatch=null;
    ResultSet rsCo=null;
    ResultSet rsCoAttain=null;
    ResultSet rsCoWiseMax=null;
    ResultSet rsCoTotal=null;
    ResultSet rsFaculty=null;
    ResultSet rsOverallAttain=null;
    ResultSet rsSubject=null;
    int nOfCo=0;
    int userDept=0;
    String e="";

    if(request.getParameter("next")==null){
%>
    <form method="POST">
    <div id="subjectBatch">
        <div class="form-row">
            <div class="col-sm"></div>
            <div class="col-sm">
                <label for="subjectID">Subject:</label> <select class="uk-select" name="subjectid" id="subjectid" required>
                    <option value="" disabled selected>Select Subject</option>
                    <%
                                if (session.getAttribute("adminDepartment") != null) {
                                    userDept = (int) session.getAttribute("adminDepartment");
                                }
                                rsAllSubject=con.SelectData("select * from subject_master where subjectID in(select distinct subjectID from attainment_overall,student_master where attainment_overall.enrollmentno=student_master.enrollmentno and studentDepartment="+userDept+");");
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
                <label for="batch">Batch:</label> <select class="uk-select" name="batch" id="batch1" required>
                    <option value="" disabled selected>Select Batch</option>
                    <%
                                rsBatch=con.SelectData("select distinct batch from attainment_overall,student_master where attainment_overall.enrollmentno=student_master.enrollmentno and studentDepartment="+userDept+";");
                                while(rsBatch.next()){
                                    out.println("<option value="+rsBatch.getInt("batch")+">"+rsBatch.getInt("batch")+"</option>");
                                }
                            %>
                </select>
            </div>
            <div class="col-sm"></div>
        </div>
        <center class="mt-3">
            <button type="submit" name="next" class="btn" value="submitOverall">Next</button>
            <br />
        </center>
    </div>
    </form>
<%
    }
    if(request.getParameter("next")!=null){
        rsOverallAttain=con.SelectData("select * from attainment_overall,student_master where attainment_overall.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch")+" order by student_master.enrollmentno;");
        rsAvgAttain=con.SelectData("select avg(attainmentOverall) as averageAttain from attainment_overall,student_master where attainment_overall.enrollmentno=student_master.enrollmentno and subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch")+" order by student_master.enrollmentno;");
        if(rsAvgAttain.next()){}
        rsCoAttain=con.SelectData("select enrollmentno,coSrNo,coAttainmentLevel from attainment_co,co_master where attainment_co.coID=co_master.coID and co_master.subjectID="+request.getParameter("subjectid")+" and co_master.batch="+request.getParameter("batch")+" order by enrollmentno,coSrNo;");
        rsFaculty=con.SelectData("select * from faculty_master where facultyID in (select facultyID from co_master where subjectID="+request.getParameter("subjectid")+" and co_master.batch="+request.getParameter("batch")+");");
        if(rsFaculty.next());
        rsCo=con.SelectData("select * from co_master where subjectID="+request.getParameter("subjectid")+" and co_master.batch="+request.getParameter("batch")+" order by coSrNo;");
        rsCo.last();
		nOfCo=rsCo.getRow();
		rsCo.beforeFirst();
        rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
		rsSubject.next();

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


        out.println("<div class='col-sm mt-4 mb-5'>"+
					"<button align='right' class='btn' type='button' onclick='printDiv();'>Print</button>"+
					"</div>");

        out.println("<div id='attainment' class='uk-overflow-auto' align='center'><table id='attainmentOverall' class='uk-table'>");

		out.println("<tr><th bgcolor='#e1e19b'><center><b>Subject</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+rsSubject.getString("subjectName")+"</b></center></th></tr>");
		out.println("<tr><th bgcolor='#e1e19b'><center><b>Batch</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+request.getParameter("batch")+"</b></center></th></tr>");
		out.println("<tr><th bgcolor='#e1e19b'><center><b>Faculty</b></center></th><th colspan='"+(nOfCo+1)+"'><center><b>"+rsFaculty.getString("facultyName")+"</b></center></th></tr>");
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

        rsOverallAttain.next();
        x=1;
        while(rsCoAttain.next()){
            if(!e.equals(rsCoAttain.getString("enrollmentno"))){
                e=rsCoAttain.getString("enrollmentno");
                out.println("<tr>");
                out.println("<td><center><b>"+rsCoAttain.getString("enrollmentno")+"</b></center></td>");
            }
            out.println("<td><center>"+rsCoAttain.getInt("coAttainmentLevel")+"</center></td>");
            if(x%nOfCo==0){
                out.println("<td><center>"+rsOverallAttain.getFloat("attainmentOverall")+"</center></td>");
                out.println("</tr>");
                if(rsOverallAttain.next()){}
            }
            x++;
        }

        out.println("<tr><td colspan='"+(nOfCo+2)+"' bgcolor='#cf6766'></td></tr>");
        out.println("<tr><td colspan='"+(nOfCo+1)+"' bgcolor='#e1e19b'><center><b>Average Subject Attainment</b></center></td><td><b>"+rsAvgAttain.getFloat("averageAttain")+"</b></td></tr>");
        out.println("</table></div>");
    }
%>
<script type="text/javascript">
	function printDiv() {
        var divName= "attainment";

        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
</script>


<%@include file="/footer.jsp"%>
<%
    }
    else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>
