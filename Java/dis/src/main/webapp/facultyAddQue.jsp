
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
<title>ADD QUESTION</title>
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
<div class="navigation" id="navbar">
	<div class="dropdown">
		<!-- navigation STARTS here -->
		<label for="show-menu" class="show-menu" style="margin-bottom: 0px"><i class="fa fa-bars mr-3"></i>Show
			Menu</label> <input type="checkbox" id="show-menu" role="button">
		<ul id="menu">
					<li><a href="facultyHome.jsp" class="main-link">HOME</a></li>
					<li><a href="#" class="main-link">INSERT &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="facultyAddCo.jsp" class="main-link">ADD CO</a></li>
					<li><a href="facultyAddExam.jsp" class="main-link">ADD
							EXAM</a></li>
					<li><a href="facultyAddQue.jsp" class="active main-link">ADD
							QUESTION</a></li>
					<li><a href="facultyAddMarks.jsp" class="main-link">ADD
							MARKS</a></li>
							</ul></li>
					<li><a href="#" class="main-link">UPDATE &nbsp;<i
							class="fa fa-caret-down"></i></a>
						<ul class="hidden">
					<li><a href="facultyUpdateCo.jsp" class="main-link">UPDATE CO</a></li>
					<li><a href="#" class="main-link">UPDATE
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
<%-- <a href="addCo.jsp">Add CO</a><br/>
        <a href="addExam.jsp">Add Exam</a><br/>
        <a href="addQue.jsp">Add Question</a><br/>
        <a href="addMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/> --%>

<div class="container" style="width: 80%; margin-bottom: 100px">
	<div id="head"></div>
	<h3 style="text-align: center; padding-bottom: 10px;">ADD
		QUESTION</h3>
	<form method="POST">

		<%-- <div id="selectexam">
			<div class="form-row">
				<div class="col-sm">
					<label for="subjectID">SubjectID:</label><input type="number"
						class="uk-input" id="subjectid" name="subjectid"
						placeholder="Subject ID" />
				</div>
				<div class="col-sm-1"></div>
				<div class="col-sm">
					<label for="batch">Batch:</label><input type="number"
						class="uk-input" id="batch1" name="batch1" placeholder="Batch" />
				</div>
			</div>
			<center class="mt-3">
				<button name="examselect" class="btn" value="examselect">Select
					Exam</button>
				<br />
			</center>
		</div> --%>
		<%
				Connect con = null;
					ResultSet rs = null;
					ResultSet rs2 = null;
					ResultSet rsSubject=null;
					ResultSetMetaData mtdt = null;
					String s = "";
					con = new Connect();
					if(request.getParameter("next")==null){%>
						<%@include file="/subjectBatchForm.jsp"%>
					<%}
					if (request.getParameter("next") != null) {
						rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
						rsSubject.next();
						rs = con.SelectData("select * from exam_master where subjectID=" + request.getParameter("subjectid")
								+ " and batch=" + request.getParameter("batch1") + " and examID not in (select examID from question_master where subjectID=" + request.getParameter("subjectid")
								+ " and batch=" + request.getParameter("batch1") + ");");
						out.println(
								"<div class='form-row'><div class='col-sm'><label for='subjectID'>Subject:</label><input type='number' class='uk-input' id='subject_id' name='subject_id' value='"+request.getParameter("subjectid")+"' hidden/><input type='text' class='uk-input' id='subjectName' name='subjectName' value='"+ rsSubject.getString("subjectName")+"' readonly/></div>");
						out.println(
								"<div class='col-sm'><label for='batch'>Batch:</label><input type='number' name='batch1' class='uk-input' id='batch1' value='"
										+ request.getParameter("batch1") + "' readonly/></div></div> ");
						out.println(
								"<div class='form-row'><div class='col-sm'><label for='examID'>Exam:</label><select class='uk-select' id='exam_id' name='exam_id' required><option value='' selected disabled>Select Exam</option>");
						while (rs.next()) {
							out.println("<option value='" + rs.getInt("examID") + "'>"
									+ rs.getString("examName") + "</option>");
						}
						out.println("</select></div>");
						out.println(""+
								"<div class=\"col-sm\">"+
									"<label for=\"noQues\"> No of Questions: </label> <input type=\"number\""+
										"class='uk-input' id='qno' name=\"qno\" id=\"qno\" placeholder='No of Questions' min=\"1\"/>"+
								"</div>"+
							"</div><div id=\"ques\"></div>"+
							"<center class=\"mt-3\">"+
								"<button type=\"submit\" class=\"btn\" id='submit' name=\"submit\" value=\"submit\" disabled>Submit</button>"+
							"</center>");
					}
			%>
		
		<%-- :::Question Normalized Max Marks Calculated From Multiply QuesMarks with exam_master nMaxMarks/MaxMarks:::<br/><br/>
            :::Question Weighted Max Marks Calculated From Multiply nQuesMarks with exam_master maxWeighMarks/nMaxMarks:::<br/><br/> --%>
		
		<%
				if (request.getParameter("submit") != null) {
						int qunos = Integer.parseInt(request.getParameter("qno"));
						ResultSet rs3 = con.SelectData(
								"SELECT em.examID,em.examTypeID, em.weightage, em.totalMaxMarks, etm.percentWeight FROM exam_master em, examtype_master etm where em.examTypeID=etm.examTypeID and examID="
										+ request.getParameter("exam_id") + ";");
						
						float fetchWeight = 0;
						float fetchTotalMarks = 0;
						int examTypeID = 0;
						float percentWeight = 0;
						float calcQuesMaxMarks = 0;
						float nCalcQuesMaxMarks = 0;
						if (rs3.next()) {
							fetchWeight = rs3.getFloat("weightage");
							fetchTotalMarks = rs3.getFloat("totalMaxMarks");
							examTypeID = rs3.getInt("examTypeID");
							percentWeight = rs3.getFloat("percentWeight");
						}
						String value="";
						int x = 1;
						while (x <= qunos) {
							String coVal = "";
							String coHead = "";
							int m = Integer.parseInt(request.getParameter("map" + x));
							float a = Float.parseFloat(request.getParameter("qMarks" + x)) * fetchWeight;
							float b = Float.parseFloat(request.getParameter("map" + x)) * fetchTotalMarks;
							calcQuesMaxMarks = a / b;
							nCalcQuesMaxMarks = calcQuesMaxMarks * percentWeight;

							for (int i = 1; i <= 7; i++){
								if (i <= m) {
									coVal = coVal + request.getParameter("qmap" + x + "co" + i);
								}
								else{
									coVal += "NULL";
								}
								if(i!=7){
									coVal += ',';
								}
							}
							value += "('"+request.getParameter("q"+x)+"',"+request.getParameter("qMarks"+x)+","+request.getParameter("map"+x)+","+calcQuesMaxMarks+","+nCalcQuesMaxMarks+","+request.getParameter("exam_id")+","+coVal+")";	
							if(x!=qunos){
								value+=",";
							}
							x++;
						}
						if (con.Ins_Upd_Del("insert into question_master(queDesc,queMaxMarks,multipleMap,calcQuesMaxMarks,nCalcQuesMaxMarks,examID,coID1,coID2,coID3,coID4,coID5,coID6,coID7) values "+value)) {
													out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Questions Inserted Successfully.</b></div>')</script>");        
													con.commitData();
							} else {
								out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Insert All Questions Again.</div>')</script>");
								con.rollbackData();
							}
				
				}
			%>


	</form>

	<script type="text/javascript">
        var st = '<%if (request.getParameter("next") != null) {
					rs2 = con.SelectData(
							"select * from co_master where subjectID=" + request.getParameter("subjectid") +" and batch=" + request.getParameter("batch1") + ";");
					while (rs2.next()) {
						s = s + "<option value=\"" + rs2.getInt("coID") + "\">CO " + rs2.getInt("coSrNo") + " - "
								+ rs2.getString("coStatement") + "</option>";
					}
					out.print(s);
				}
			%>';
        var n=1;
		
		$(document).on("change","#qno",function(){
			var qno= this.value;
			var appendLoc = $("#ques");
			appendLoc.text('');
			var i=1;
			var n=1;
			while(n<=qno){
                console.log( "ready!" );
                var i=1;
                $(appendLoc).append('\
				<div name="dQ'+n+'">\
					<div class="form-row" style="padding-bottom:0px !important;"><label style="padding-left:30px !important;">Question '+n+'</lable></div>\
                    <div class="form-row" style="padding-top:0px !important;"><div class="col-sm"><label for="questionDesc">Description:</label><input type="text" class="uk-input" id="q'+n+'" name="q'+n+'" required></div>\
                    <div class="col-sm"><div class="form-row" style="padding:0px; margin:0px;"><div class="col-sm" style="padding:0px !important;"><label for="questionMarks">Marks:</label><input type="number" class="uk-input" id="qMarks'+(n)+'" name="qMarks'+(n)+'" required></div><div class="col-sm-1"></div>\
                        <div class="col-sm" style="padding: 0px !important;"><label for="multiMap">Multiple Mapping:</label><input class="uk-input multiMap" type="number" min="1" id="map'+n+'" name="map'+n+'" required></div></div></div></div>\
                        \
                        <div class="form-row" id="map'+n+'Co" style="padding-bottom:0px;">\
                        </div></div><br/>');
                n++;
			}
		});
		$(document).on("change","#qno",function(){
                    var no = this.value;
                    if (no>0) {
						$('#submit').removeAttr("disabled");
					} else {
						$('#submit').attr("disabled","true");
					}
        });

        $(document).on("change",".multiMap",function(){
                    var i= document.getElementById(this.id+"Co");
                    var no = this.value;
                    var j=1;
                    $(i).text('');
                    while(j<=no){
                        $(i).append('<div class="col-sm-6" style="padding-bottom:10px; padding-left:30px;padding-right:30px;"><label for="coselect">'+j+'. CO:</label><select class="uk-input" id="q'+(this.id)+'co'+j+'" name="q'+(this.id)+'co'+j+'" required><option value="" disabled selected>Select CO</option>'+st+'</select></div>');
                        j++;
                    }
        });
    </script>
<%@include file="/footer.jsp"%>
<%
}
	else
	{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("/dis/login.jsp");		
	}
%>