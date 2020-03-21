<%
	String userRole = new String("SUPERSTAR");
	
	if(session.getAttribute("role") != null){
		userRole = (String)session.getAttribute("role");
	}
	if(userRole.equals("faculty")){
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>ADD EXAM</title>
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/uikit@3.3.7/dist/css/uikit.min.css" />
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
			<p class="h4" style="margin-top: 20px; padding-top: 10px;">DEPARTMENT
				INFORMATION SYSTEM</p>
			<!-- div>
</div>-->
		</div>
		<div class="navigation" id="navbar">
			<div class="dropdown">
				<!-- navigation STARTS here -->
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px">Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="facultyHome.jsp" class="active main-link">HOME</a></li>
					<li><a href="addCo.jsp" class="active main-link">ADD CO</a></li>
					<li><a href="addExam.jsp" class="active main-link">ADD
							EXAM</a></li>
					<li><a href="addQue.jsp" class="active main-link">ADD
							QUESTION</a></li>
					<li><a href="addMarks.jsp" class="active main-link">ADD
							MARKS</a></li>
					<li><a href="calculateAttainment.jsp" class="active main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="#" class="active main-link">LOGOUT</a></li>
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
	
</body>
</html>
<%
	}
	else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>