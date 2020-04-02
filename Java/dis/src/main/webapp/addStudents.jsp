<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	if (userRole.equals("admin")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/header.jsp"%>
<title>ADD STUDENTS</title>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
td{
    padding: 0px !important;
}
th{
    background-color: #cf6766 !important;
    color: black !important;
}
table input{
    border: 0px !important;
}
.form-row .col-sm .form-row{
    padding:0px !important;
    display: inline !important;
    margin: 0px !important;
}
.col-md-3{
	display: inline-flex !important;
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
				<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
					Menu</label> <input type="checkbox" id="show-menu" role="button">
				<ul id="menu">
					<li><a href="adminHome.jsp" class="main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="addStudents.jsp" class="main-link">ADD STUDENTS</a></li>
							</ul></li>
					<li><a href="#" class="main-link">APPROVE &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="approveUser.jsp" class="main-link">APPROVE USER</a></li>
							</ul></li>
					<li><a href="#" class="main-link">VIEW
							ATTAINMENT</a></li>
					<li><a href="logout.jsp" class="main-link">LOGOUT</a></li>
				</ul>
			</div>
		</div>
		<!-- navigation ENDS here -->
	</div>
<div class="container" style="width: 80%; margin-bottom: 100px">
    <div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">ADD
		STUDENTS</h3>
	<form method="POST">
		<div class="form-row">
			<div class="col-sm"></div>
			<div class="col-sm">
				<label for="batch">Batch:</label>
				<input type="number" class="uk-input" name="batch" min="2000" max="2030" placeholder="Enter Batch" required>
			</div>
			<div class="col-sm"></div>
		</div>
		<div class="form-row" id="importRadio">
			<div class="col-sm"></div>
			<div class="col-sm">
				<div class="form-row" style="margin:0px !important;">
					<div class="col-sm" style="padding:0px !important;">
						<label><input class="uk-radio" type="radio" id='import' name="import" value='importdata'> Import</label>
					</div>
					<div class="col-sm" style='padding:0px !important;'>
						<label><input class="uk-radio" type="radio" id='import' name="import" value='insertdata'> Insert</label>
					</div>
				</div>
			</div>
			<div class="col-sm"></div>
		</div>
		<div class='form-row' id='importAuto' style='display: none;'>
			<div class='col-sm'>
				<div class='form-row'><b>Instructions for IMPORT:</b></div>
				<div class='form-row'><li>Upload .csv File Only</li></div>
				<div class='form-row'><li>First Row will be considered as a HEADING</li></div>
				<div class='form-row'><li>All Enrollment No should be in one column.</li></div>
				<div class='form-row'><li>Format Cells to number for proper result.</li></div>
				<div class='form-row'><li>Please <b>VERIFY</b> the Data before SUBMIT</li></div>
			</div>
			<div class='col-sm'>
				<div class='uk-form-custom'>
					<input type="file" id="fileUpload">
					<button class="uk-button uk-button-default" type="button">SELECT FILE</button>
				</div>
				<button class="uk-button uk-button-default" type="button" id="upload" value="Import" onclick="Upload()">Import</button>
			</div>
		</div>
        <div id="insertManual" style="display: none;">
			<div class="form-row" >
				<div class="col-sm"></div>
				<div class="col-sm">
					<label for="noStudents">No of Students:</label>
					<input type="number" class="uk-input" name="nOfStudent" id="nOfStudent" min="1" placeholder="Enter No of Students">
				</div>
				<div class="col-sm"></div>
			</div>
			<div id="studentData">
			</div>
		</div>
		<center class="mt-3"><button class='btn' type='submit' id='addStudentbtn' name='addStudentbtn' value='submit' style='display:none; background-color:#cf6766;'><b>Submit</b></button></center>
		<%
		Connect con = null;
		//ResultSet rs = null;
		ResultSetMetaData mtdt = null;
	con = new Connect();
	
	int x=1;
	ResultSet rs=con.SelectData("select adminDepartment from admin_master where adminID="+session.getAttribute("id")+";");
	rs.last();
	int dept=rs.getRow();
		if (request.getParameter("addStudentbtn") != null) {
			int noofStud=Integer.parseInt(request.getParameter("nOfStudent"));
			while(x=noofStud){
						if (con.Ins_Upd_Del(
								"insert into student_master (enrollmentno, batch, studentDepartment) values ('"+request.getParameter("enroll"+x+"")+"',"+request.getParameter("batch")+","+dept+");")){
											out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Student Inserted Successfully</b>.</div>')</script>");        
											con.commitData();
										}
						else{
								out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Same Enrollment Exist for Selected Batch.</div>')</script>");
								con.rollbackData();
							}
		}
		x++;
					}
		%>	
	<script type="text/javascript">
    function Upload() {
        var fileUpload = document.getElementById("fileUpload");
		var x=1;
        console.log(fileUpload.value);
        var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
        if (regex.test(fileUpload.value.toLowerCase())) {
            if (typeof (FileReader) != "undefined") {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var table = document.createElement("table");
                    var rows = e.target.result.split("\n");
                    for (var i = 0; i < rows.length; i++) {
                        if(i!=0){
                        var cells = rows[i].split(",");
                        if (cells.length > 1) {
                            var row = table.insertRow(-1);
                            for (var j = 0; j < 1; j++) {
                                var cell = row.insertCell(-1);
								var studentData = document.getElementById("studentData");
								$('#studentData').append('<div class="col-md-3"><input type="text" class="uk-input" name="enroll'+cells[j]+'" value="'+cells[j]+'" required></div>');				
								x++;
                            }
                        }}
                    }
					$('#insertManual').show();
					$('#nOfStudent').val(--x);
					$('#nOfStudent').attr("readonly",true);
					$('#upload').attr("disabled",true);
					$('#addStudentbtn').show();
                }
                reader.readAsText(fileUpload.files[0]);
            } else {
                alert("This browser does not support HTML5.");
            }
        } else {
            alert("Please upload a valid CSV file.");
        }
    }
	$(document).on("click","#import",function(){
        var state=this.value;
        if(state=='importdata'){
            $('#importAuto').show();
			$('#importRadio').hide();
        }
        else{
            $('#insertManual').show();
			$('#importRadio').hide();
        }
    });
	$(document).on("change","#nOfStudent",function(){
        var no=this.value;
		var x=1;
		$('#studentData').text('');
		while(x<=no){
			$('#studentData').append('<div class="col-md-3"><input type="text" class="uk-input" name="enroll'+x+'" placeholder="Enrollment No. '+x+'" required></div>')
			x++;
		}
		$('#addStudentbtn').show();
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