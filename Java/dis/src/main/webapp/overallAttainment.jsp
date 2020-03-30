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

<%-- NAVIGATION --%>
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
			<li><a href="addMarks.jsp" class="main-link">ADD MARKS</a></li>
			<li><a href="calculateAttainment.jsp" class="active main-link">VIEW ATTAINMENT</a></li>
            <li><a href="viewMarks.jsp" class="main-link">VIEW MARKS</a></li>
            <li><a href="overallAttainment.jsp" class="active main-link">OVERALL ATTAINMENT</a></li>
			<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
		</ul>
	</div>
</div>
</div>

<div class="container" style="width: 80%; margin-bottom: 0px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">OVERALL ATTAINMENT</h3>
	<form method="POST">

    <%
    Connect con=null;
    ResultSet rsEnrollments=bull
    Connect con=new Connect();
    %>
    <%
    if(request.getParameter("next")==null){%>
			<%@include file="subjectBatchForm.jsp"%>
    <%}
    if(request.getParameter("next")!=null){
        out.println("<input type='number' name='subject_id' value='"+request.getParameter("subjectid")+"' readonly hidden/>");

        rsEnrollments=con.SelectData("select enrollmentno from student_master where batch="+request.getParameter("batch")+" and studentDepartment="+(int)session.getAttribute("facultyDepartment")+" order by enrollmentno;");

        
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
    if(request.getParameter("next")==null && request.getParameter("viewattain")==null){%>
		<%@include file="subjectBatchForm.jsp"%>
%>






<%
  }
  else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>