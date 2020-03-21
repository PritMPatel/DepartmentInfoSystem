<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>ADD CO</title>
        <script src="js/jquery-3.2.1.min.js"></script>
        <link rel="icon" type="image/ico" href="images/download.jpg" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/DIS.css">
<link rel="stylesheet" type="text/css" href="css/nav-style.css">

<link rel="stylesheet" type="text/javascript" href="JScript/passtest.js">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">
        .body {
            height: 100%;
            margin: 0;
            font: 400 10px/1.8 "Lato", sans-serif;
            margin-bottom: 60px; /* Margin bottom by footer height */
            color: #777;
        }
    </script>
    </head>
    <body>
    <div class="container-fluid  "
		style="padding-left: 0px; padding-right: 0px;">
		<div class="row" style="margin-left: 5px;">
        <img src="images/download.jpg"
				class="img-responsive my-img mt-3 mr-3 ml-3 mb-3"
				style="height: 60px; width: 60px; margin-left: 15px;">
			<!-- <div class="col-sm"> -->
			<p class="h4 mt-4">DEPARTMENT INFORMATION SYSTEM</p>
			<!-- div>
</div>-->
		</div>
        <div class="navigation" id="navbar">
			<div class="dropdown">
				<!-- navigation STARTS here -->
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px">Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="index.jsp" class="active main-link">HOME</a></li>
                    <li><a href="addCo.jsp" class="active main-link">ADD CO</a></li>
                    <li><a href="addExam.jsp" class="active main-link">ADD EXAM</a></li>
                    <li><a href="addQue.jsp" class="active main-link">ADD QUESTION</a></li>
                    <li><a href="addMarks.jsp" class="active main-link">ADD MARKS</a></li>
					<li><a href="calculateAttainment.jsp" class="active main-link">VIEW ATTAINMENT</a></li>
					
					<%-- <li><a href="#" class="main-link">MANAGE USERS &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
							<li><a href="addadmin.jsp">ADD USER</a></li>
							<li><a href="#">DELETE USER</a></li>
						</ul></li> --%>
				</ul>
			</div>
		</div>
		<!-- navigation ENDS here -->
	</div>

    <%-- <a href="addCo.jsp">Add CO</a><br/>
        <a href="addExam.jsp">Add Exam</a><br/>
        <a href="addQue.jsp">Add Question</a><br/>
        <a href="addMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/> --%>
        <br/><br/>
        <div class="container" style="width: 80%; margin-bottom: 100px">
	<h3 id="head" style="text-align: center; padding-bottom: 10px;">ADD COURSE OUTCOME</h3>
    <form method="POST">
    <div class="form-row">
			<div class="col-sm">
        <label for="subjectID">SubjectID:</label> 
            <input type="number" class="form-control" id ="subject_id" name="subject_id" placeholder="SUBJECT ID"/></div><br/>
        
        <div class="col-sm-1"></div>
			<div class="col-sm">
            <label for="facultyID">FacultyID: </label> 
            <input type="number" class="form-control" id ="faculty_id" name="faculty_id" placeholder="FACULTY ID"/></div>
		</div>
<br/>

        No of CO:  <input type="number" name="cono" id="cono"/><br/>
            <input onclick="addRow(this.form);" type="button" name="addbut" value="Add"><br/>
            <div id="cos">
            </div>
       
        <button type="submit" name="submit" value="submit">Submit</button>
        <script type="text/javascript">
            function addRow(frm) {
                var cono = frm.cono.value;
                var n = 1;
                while(n<=cono){
                    jQuery('#cos').append('CoStatement '+n+' :<input type="text" name="co'+(n)+'"><br/>');
                    n++;
                }
                frm.addbut.disabled="true";
            }
        </script>
        <%
            Connect con=null;
            ResultSet rs=null;
            ResultSetMetaData mtdt=null;
            con=new Connect();
            if (request.getParameter("submit") != null){
            int conos = Integer.parseInt(request.getParameter("cono"));
            int x = 1;
            while(x<=conos){
                if (con.Ins_Upd_Del("insert into co_master(coID,coStatement,subjectID,facultyID) VALUES("+x+",'"+request.getParameter("co"+x)+"',"+request.getParameter("subject_id")+","+request.getParameter("faculty_id")+");"))
                    out.println("<script>alert('CO "+x+" inserted......');</script>");
                else
                    out.println("<script>alert('CO was not inserted......');</script>");
                x++;
            }
            }
        %>
        </form>
    </body>
</html>