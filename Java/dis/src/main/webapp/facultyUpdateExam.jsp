
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
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
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
<title>UPDATE EXAM</title>
<div class="navigation" id="navbar">
	<div class="dropdown">
		<!-- navigation STARTS here -->
		<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
			Menu</label> <input type="checkbox" id="show-menu" role="button">
		<ul id="menu">
					<li><a href="facultyHome.jsp" class=" main-link">HOME</a></li>
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
					<li><a href="facultyUpdateCo.jsp" class="main-link">UPDATE CO</a></li>
					<li><a href="facultyUpdateExam.jsp" class="active main-link">UPDATE
							EXAM</a></li>
					<li><a href="#" class="main-link">UPDATE
							QUESTION</a></li>
					<li><a href="facultyUpdateMarks.jsp" class="main-link">UPDATE
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

<div class="container" style="width: 80%; margin-bottom: 100px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">UPDATE EXAM</h3>
	<form method="POST">
<%
    Connect con = null;
    con = new Connect();
    ResultSet AllExam=null;
	ResultSet Exam=null;
	ResultSet rsExamType=null;
	ResultSet rsSubject=null;
    if(request.getParameter("next")==null){
        AllExam= con.SelectData("select * from exam_master,subject_master where subject_master.subjectID=exam_master.subjectID and (exam_master.subjectID,batch) in (select subjectID,batch from co_master where facultyID="+(int)session.getAttribute("facultyID")+") and examID not in (select distinct examID from question_master) order by batch desc, subjectName asc;");
        %>
        <input type="number" id="subject_id" name="subject_id" hidden required>
        <input type="number" id="exam_id" name="exam_id" hidden required>
        <input type="number" id="batch" name="batch" hidden required>
        <div class="form-row">
            <div class="col-sm-3"></div>
            <div class="col-sm">
                <label for="exam">Exam:</label> <select class="uk-select" id="selectExam" required>
                    <option value="" disabled selected>Select Exam</option>
                    <%
                        while(AllExam.next()){
                            out.println("<option value='"+AllExam.getInt("batch")+"-"+AllExam.getInt("exam_master.subjectID")+"-"+AllExam.getInt("examID")+"'>"+AllExam.getInt("batch")+" - "+AllExam.getString("subjectName")+" - "+AllExam.getString("examName")+" </option>");
                        }
                    %>
                </select>
            </div>
            <div class="col-sm-3"></div>
        </div>
        <center class="mt-3">
            <button name="next" class="btn" id="next" value="next">Next</button>
        </center>
        <%
    }
    if(request.getParameter("next")!=null){
		Exam = con.SelectData("select * from exam_master where examID="+request.getParameter("exam_id")+";");
		if(Exam.next()){
	%>
		<div class="form-row">
			<div class="col-sm">
				<label for="examName">Exam Name:</label> <input type="text"
					class="uk-input" id="exam_name" name="exam_name"
					placeholder="Exam Name" value="<%=Exam.getString("examName")%>" required/>
			</div>
			<div class="col-sm">
					<label for="examTypeID">Category of Exam:</label>
					<select class="uk-select" name="exam_type" id="exam_type" required>
						<option value="" disabled>Select Category of Exam</option>
						<%
							rsExamType=con.SelectData("select * from examtype_master;");
							while(rsExamType.next()){%>
								<option value=<%=rsExamType.getInt("examtypeID")%> <%if(rsExamType.getInt("examtypeID")==Exam.getInt("examtypeID")){out.println("selected");}%>><%=rsExamType.getString("typeDescription")%></option>
							<%}
						%>
					</select>
				</div>
		</div>

		<div class="form-row">
			<div class="col-sm">
				<label for="totalMarks">Total Marks:</label> <input type="number"
					class="uk-input" id="total_max_marks" name="total_max_marks"
					placeholder="Total Marks" min="1" value="<%=Exam.getInt("totalMaxMarks")%>" required/>
			</div>
			<div class="col-sm">
				<label for="weightage">Weightage:</label> <input type="number"
					class="uk-input" id="weightage" name="weightage"
					placeholder="Weightage" min="1" value="<%=Exam.getInt("weightage")%>" required/>
			</div>
		</div>
		<div class="form-row">
			<%
			rsSubject=con.SelectData("select * from subject_master where subjectID="+Exam.getInt("subjectID")+";");
			if(rsSubject.next()){
			%>
			<div class="col-sm">
				<label for="subjectID">Subject:</label>
				<input type="text" class="uk-input" name="subjectName" placeholder="Subject Name" value="<%=rsSubject.getString("subjectName")%>" readonly required/>
				<input type="text" class="uk-input" name="subject_id" placeholder="Subject Name" value="<%=Exam.getInt("subjectID")%>" hidden readonly required/>
				<input type="text" class="uk-input" name="exam_id" placeholder="ExamID" value="<%=Exam.getInt("examID")%>" hidden readonly required/>
			</div>
			<%}%>
			<div class="col-sm">
				<label for="batch">Batch:</label> 
				<input type="number" class="uk-input" name="batch" placeholder="Batch" value="<%=Exam.getInt("batch")%>" readonly required/>
			</div>
		</div>
		<center class="mt-3">
			<button type="submit" class="btn" name="update" value="update">Update</button>
		</center>
	<%
		}
    }
	if(request.getParameter("update")!=null){
		if(con.Ins_Upd_Del("UPDATE exam_master SET examName='"+request.getParameter("exam_name")+"',examtypeID="+request.getParameter("exam_type")+",totalMaxMarks="+request.getParameter("total_max_marks")+",weightage="+request.getParameter("weightage")+" WHERE examID = "+request.getParameter("exam_id")+";")){
			out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Exam Updated Successfully.</b></div>')</script>");        
            con.commitData();
		}
		else{
			out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Update Exam Again. Try Using Different Exam Name.</div>')</script>");
            con.rollbackData();
		}
	}
%>
    <script type="text/javascript">
    $(document).on("click change select","#selectExam",function(){
		var e = document.getElementById("selectExam");
		var values=e.value.split("-");
        $("#batch").attr("value",values[0]);
        $("#subject_id").attr("value",values[1]);
        $("#exam_id").attr("value",values[2]);
    });
    $(document).on("change","#exam_id",function(){
        if($("#exam_id").value!=null){
            $("#next").attr("disabled","false");
        }
    });
    </script>
    </form>
<%@include file="/footer.jsp"%>
<%
    }
    else{
        out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("/dis/login.jsp");
    }
%>