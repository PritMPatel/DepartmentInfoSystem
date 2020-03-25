
<%
	String userRole = new String("SUPERSTAR");

	if (session.getAttribute("role") != null) {
		userRole = (String) session.getAttribute("role");
	}
	if (userRole.equals("faculty")) {
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="/headerFaculty.jsp"%>
<title>ADD MARKS</title>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
td{
    padding: 0px !important;
}
th{
    background-color: lightgreen !important;
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
.uk-table{
    width: auto !important;
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
			<li><a href="addMarks.jsp" class="active main-link">ADD
					MARKS</a></li>
			<li><a href="calculateAttainment.jsp" class="main-link">VIEW
					ATTAINMENT</a></li>
			<li><a href="#" class="main-link">LOGOUT</a></li>
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
	<h3 id="head" style="text-align: center; padding-bottom: 10px;">ADD
		MARKS</h3>
	<form method="POST">
		<%-- <div class="form-row">
			<div class="col-sm">
				<label for="subjectID"> SubjectID:</label><input type="number"
					class="uk-input" id="subject1" name="subject1"
					placeholder="Subject ID" />
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm">
				<label for="batch"> Batch:</label><input type="number"
					class="uk-input" id="batch1" name="batch1" placeholder="Batch" />
			</div>
		</div>
		<center class="mt-3">
			<button name="examselect" class="btn" value="examselect">Select
				Exam</button>
		</center>
	</form> --%>
	<%
                Connect con=null;
                ResultSet rs=null;
                ResultSet rs2=null;
                ResultSet rs3=null;
                ResultSet rs4=null;
                ResultSet rs5=null;
                ResultSet rsSubject=null;
                ResultSetMetaData mtdt=null;
                String s = "ESE";
                int nOfQue=0;
                int nOfStudents=0;
                int x=0;
                int x2=0;
                int eid=0;
                con=new Connect();
                if(request.getParameter("next")==null && request.getParameter("addMarks")==null){%>
                <%@include file="/subjectBatchForm.jsp"%>
                <%}
                if(request.getParameter("next")!=null){
                    rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
                    rsSubject.next();
                    rs=con.SelectData("select * from exam_master where examID in (select distinct examID from question_master where questionID not in (select questionID from marks_obtained_master)) and subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+";");
                    out.println(
                            "<div class='form-row'><div class='col-sm'><label for='subjectID'>Subject:</label><input type='number' class='uk-input' id='subject_id' name='subject_id' value='"+request.getParameter("subjectid")+"' hidden/><input type='text' class='uk-input' id='subjectName' name='subjectName' value='"+ rsSubject.getString("subjectName")+"' readonly/></div>");
                    out.println(
                            "<div class='col-sm'><label for='batch'>Batch:</label><input type='number' name='batch' class='uk-input' id='batch' value='"
                                    + request.getParameter("batch1") + "' readonly/></div></div> ");
                    out.println(
                            "<div class='form-row'><div class='col-sm'><label for='examID'>Exam:</label><select class='uk-select' id='exam_id' name='exam_id'><option value='0' selected disabled>SELECT EXAM</option>");
                    while (rs.next()) {
                        out.println("<option value='" + rs.getInt("examID") + "'>"
                                + rs.getString("examName") + "</option>");
                    }
                    out.println("</select></div></div>");
                    out.println("<center class=\"mt-3\"><button class='btn' id='addMarks' name='addMarks' value='addMarks' disabled>Add Marks</button></center></form><br/>");
                }  
                if(request.getParameter("addMarks")!=null){
                rs4=con.SelectData("select typeDescription,examName from exam_master,examtype_master where exam_master.examtypeID=examtype_master.examtypeID and examID="+request.getParameter("exam_id")+";");
                rs4.next();
                if(s.equals(rs4.getString("typeDescription"))){
                    out.println("<form method='POST'><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/>");
                    out.println("<div class=\"form-row\">"
                        +"<div class=\"col-sm\"></div>"
                        +"<div class=\"col-sm\"><label for='exam'>Exam:</label><input type='text' value='"+rs4.getString("examName")+"' name='examName' readonly/></div>"
                        +"<div class=\"col-sm\"></div>"
                    +"</div><div class=\"form-row\"><div class=\"col-sm\"></div><div class=\"col-sm\"><div class=\"form-row\" style=\"margin:0px !important;\"><div class=\"col-sm\" style='padding:0px !important;'><label><input class=\"uk-radio\" type=\"radio\" id='import' name=\"import\" value='importdata'> Import</label></div><div class=\"col-sm\" style='padding:0px !important;'><label><input class=\"uk-radio\" type=\"radio\" id='import' name=\"import\" value='insertdata'> Insert</label></div></div></div><div class=\"col-sm\"></div></div>");
                    out.println("<div class='form-row' id='importAuto' style='display: none;'><div class='col-sm'><div class='form-row'><b>Instructions for IMPORT:</b></div><div class='form-row'><li>Upload .csv File Only</li></div><div class='form-row'><li>Enrollment should be same as mentioned below.</li></div><div class='form-row'><li>Column Order Should be same as Below</li></div><div class='form-row'><li>First Row will be considered as a HEADING</li></div><div class='form-row'><li>Please <b>VERIFY</b> the Data before SUBMIT</li></div></div><div class='col-sm'><div class='uk-form-custom'><input type=\"file\" id=\"fileUpload\"><button class=\"uk-button uk-button-default\" type=\"button\">SELECT FILE</button></div><button class=\"uk-button uk-button-default\" type=\"button\" id=\"upload\" value=\"Import\" onclick=\"UploadESE()\">Import</button></div></div>");
                    out.println("<div id='insertManual' style='display: none;'><div class=\"form-row\"></div><center><table class='uk-table uk-table-hover uk-table-divider uk-table-small' border='1'><tr><th class='uk-table-small'>Enrollment</th><th class='uk-width-auto'>Obtained Marks</th></tr>");
                    rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("exam_id")+");");
                    rs3.last();
                    nOfStudents=rs3.getRow();
                    rs3.beforeFirst();
                    x2=1;
                    while(x2<=nOfStudents && rs3.next()){
                        out.println("<tr><td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small' type='text' name='enroll"+x2+"' value='"+rs3.getString("enrollmentno")+"' readonly></td>");
                        out.println("<td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small uk-form-width-small' type='text' id='"+x2+"marks' name='"+x2+"marks' required></td></tr>");
                        x2++; 
                    }
                    out.println("</table><button class='btn' type='submit' name='submit' value='submit'>Submit</button></center></div></form>");  
                }




                else{    
                
                out.println("<form method='POST'><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/>");
                rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,calcQuesMaxMarks,nCalcQuesMaxMarks FROM question_master qm where examID="+request.getParameter("exam_id")+" order by questionID;");
                rs2.last();
                nOfQue = rs2.getRow();
                x=1;
                x2=1;
                rs2.beforeFirst();
                out.println("<div class=\"form-row\">"
                        +"<div class=\"col-sm\"></div>"
                        +"<div class=\"col-sm\"><label for='exam'>Exam:</label><input type='text' value='"+rs4.getString("examName")+"' name='examName' readonly/></div>"
                        +"<div class=\"col-sm\"></div>"
                    +"</div><div class=\"form-row\"><div class=\"col-sm\"></div><div class=\"col-sm\"><div class=\"form-row\" style=\"margin:0px !important;\"><div class=\"col-sm\" style='padding:0px !important;'><label><input class=\"uk-radio\" type=\"radio\" id='import' name=\"import\" value='importdata'> Import</label></div><div class=\"col-sm\" style='padding:0px !important;'><label><input class=\"uk-radio\" type=\"radio\" id='import' name=\"import\" value='insertdata'> Insert</label></div></div></div><div class=\"col-sm\"></div></div>");
                out.println("<div class='form-row' id='importAuto' style='display: none;'><div class='col-sm'><div class='form-row'><b>Instructions for IMPORT:</b></div><div class='form-row'><li>Upload .csv File Only</li></div><div class='form-row'><li>Enrollment should be same as mentioned below.</li></div><div class='form-row'><li>Column Order Should be same as Below</li></div><div class='form-row'><li>First Row will be considered as a HEADING</li></div><div class='form-row'><li>Please <b>VERIFY</b> the Data before SUBMIT</li></div></div><div class='col-sm'><div class='uk-form-custom'><input type=\"file\" id=\"fileUpload\"><button class=\"uk-button uk-button-default\" type=\"button\">SELECT FILE</button></div><button class=\"uk-button uk-button-default\" type=\"button\" id=\"upload\" value=\"Import\" onclick=\"Upload()\">Import</button></div></div>");
                out.println("<div id='insertManual' style='display: none;'><div class=\"form-row\"></div><center><table class='uk-table uk-table-hover uk-table-divider uk-table-small' border='1'><tr><th class='uk-table-small'>Enrollment</th>");
                while(x<=nOfQue && rs2.next()){
                    out.println("<th class='uk-width-auto'>"+rs2.getString("queDesc")+"</th>");
                    x++;
                }
                out.println("</tr>");
                rs2.beforeFirst();
                x=1;
                rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("exam_id")+");");
                rs3.last();
                nOfStudents=rs3.getRow();
                rs3.beforeFirst();
                while(x2<=nOfStudents && rs3.next()){
                    out.println("<tr><td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small' type='text' name='enroll"+x2+"' value='"+rs3.getString("enrollmentno")+"' readonly></td>");
                    while(x<=nOfQue){
                        out.println("<td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small uk-form-width-small' type='text' id='"+x2+"que"+x+"' name='"+x2+"que"+x+"' required></td>");
                        x++;
                    }
                    x=1;
                    out.println("</tr>");
                    x2++;
                }
                out.println("</table><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/><button class='btn' type='submit' name='submit' value='submit'>Submit</button></center></div></form>");  
            }}%>

	<%
                if(request.getParameter("submit")!=null){
                    
                    rs4=con.SelectData("select typeDescription from exam_master,examtype_master where exam_master.examtypeID=examtype_master.examtypeID and examID="+request.getParameter("examid2")+";");
                    rs4.next();
                    rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,calcQuesMaxMarks,nCalcQuesMaxMarks FROM question_master qm where examID="+request.getParameter("examid2")+" order by questionID;");
                    rs2.last();
                    nOfQue = rs2.getRow();
                    //out.println(nOfQue);
                    rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("examid2")+") order by enrollmentno;");
                    rs3.last();
                    nOfStudents = rs3.getRow();
                    //out.println(nOfStudents);
                    if(s.equals(rs4.getString("typeDescription"))){
                        rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,calcQuesMaxMarks,nCalcQuesMaxMarks FROM question_master qm where examID="+request.getParameter("examid2")+" order by questionID;");
                        rs2.last();
                        nOfQue = rs2.getRow();
                        rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("examid2")+") order by enrollmentno;");
                        rs3.last();
                        nOfStudents = rs3.getRow();
                        x=1;
                        x2=1;
                        rs3.beforeFirst();
                        rs5=con.SelectData("select * from exam_master where examID="+request.getParameter("examid2")+";");
                        rs5.next();
                        float examMaxMarks = rs5.getFloat("totalMaxMarks");
                        while(x2<=nOfStudents && rs3.next()){
                            rs2.beforeFirst();
                            x=1;
                            float marks = Float.parseFloat(request.getParameter(x2+"marks"));
                            while(x<=nOfQue && rs2.next()){
                                float nFact = rs2.getFloat("calcQuesMaxMarks")/rs2.getFloat("queMaxMarks");
                                float wFact = rs2.getFloat("nCalcQuesMaxMarks")/rs2.getFloat("queMaxMarks");                               
                                float obtMarks = marks*rs2.getFloat("queMaxMarks")/examMaxMarks;
                                float calcObtMarks = obtMarks*nFact;
                                float nCalcObtMarks = obtMarks*wFact;
                                if(con.Ins_Upd_Del("insert into marks_obtained_master(enrollmentno,questionID,obtainedMarks,calcObtainedMarks,nCalcObtainedMarks) values("+rs3.getString("enrollmentno")+","+rs2.getInt("questionID")+","+obtMarks+","+calcObtMarks+","+nCalcObtMarks+");")){
                                    if(x2==nOfStudents && x==nOfQue){
                                        out.println("<script>$('.container').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a>Marks Inserted Successfully.</div>')</script>");        
                                        con.commitData();
                                    }
                                }
                                else{
                                    out.println("<script>$('.container').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a>ERROR : @"+request.getParameter("enroll"+x2)+" FOR QUESTION "+x+": Please Insert All the Marks Again.</div>')</script>");
                                    con.rollbackData();
                                }
                                x++;
                            }
                            x2++;    
                        }
                    
                    }
                    else{
                    x=1;
                    x2=1;
                    rs3.beforeFirst();
                    while(x2<=nOfStudents && rs3.next()){
                        //out.println("It reach inside first loop");
                        rs2.beforeFirst();
                        x=1;
                        while(x<=nOfQue && rs2.next()){
                            //out.println("It reach inside Second loop");
                            if(request.getParameter(x2+"que"+x)==""){
                                float nFact = rs2.getFloat("calcQuesMaxMarks")/rs2.getFloat("queMaxMarks");
                                float wFact = rs2.getFloat("nCalcQuesMaxMarks")/rs2.getFloat("queMaxMarks");
                                float calcObtMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*nFact;
                                float nCalcObtMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*wFact;
                                //float obtWeighMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*wFact;
                                //float obtNormMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*nFact;
                                //out.println("<br><br>n w oN oW"+"-"+nFact+"-"+wFact+"-"+obtNormMarks+"-"+obtWeighMarks+"<br><br>");
                                if(con.Ins_Upd_Del("insert into marks_obtained_master(enrollmentno,questionID,obtainedMarks,calcObtainedMarks,nCalcObtainedMarks) values("+rs3.getString("enrollmentno")+","+rs2.getInt("questionID")+","+Float.parseFloat(request.getParameter(x2+"que"+x))+","+calcObtMarks+","+nCalcObtMarks+");")){
                                    if(x2==nOfStudents && x==nOfQue){
                                        out.println("<script>$('.container').prepend('<div class=\"uk-alert-success uk-alert\" ><a class=\"uk-alert-close uk-close\" ></a>Marks Inserted Successfully.</div>')</script>");       
                                        con.commitData();
                                    }
                                }
                            }
                            else{
                                out.println("<script>$('.container').prepend('<div class=\"uk-alert-danger uk-alert\" ><a class=\"uk-alert-close uk-close\" ></a>ERROR : @"+request.getParameter("enroll"+x2)+" FOR QUESTION "+x+"</div>')</script>");
                                con.rollbackData();
                                break;
                            }
                            x++;

                        }
                        x2++;
                    }
                    }
                }
    
            %>
	<script type="text/javascript">
    function Upload() {
        var fileUpload = document.getElementById("fileUpload");
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
                            for (var j = 0; j < cells.length; j++) {
                                var cell = row.insertCell(-1);
                                if(j!=0){
                                    var inTable = document.getElementById((i)+"que"+(j));
                                    console.log(inTable.value);
                                    if(inTable!=null)
                                    inTable.value = cells[j];
                                }
                                else{
                                    //var inTable = document.getElementById("enroll"+(i));
                                    //if(inTable!=null)
                                    //    inTable.value = cells[j];
                                }
                                
                            }
                        }}
                    }
                }
                reader.readAsText(fileUpload.files[0]);
            } else {
                alert("This browser does not support HTML5.");
            }
        } else {
            alert("Please upload a valid CSV file.");
        }
    }
        function UploadESE() {
        var fileUpload = document.getElementById("fileUpload");
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
                            for (var j = 0; j < cells.length; j++) {
                                var cell = row.insertCell(-1);
                                if(j!=0){
                                    var inTable = document.getElementById((i)+"marks");
                                    if(inTable!=null)
                                        inTable.value = cells[j];
                                }
                                else{
                                    //var inTable = document.getElementById("enroll"+(i));
                                    //if(inTable!=null)
                                    //    inTable.value = cells[j];
                                }
                            }
                        }}
                    }
                }
                reader.readAsText(fileUpload.files[0]);
            } else {
                alert("This browser does not support HTML5.");
            }
        } else {
            alert("Please upload a valid CSV file.");
        }
    }
    $(document).on("change","table > input", function(){
        if($(this).value>=0){
            $('#submit').removeAttr('disabled');
        }
        else{
            $('#submit').attr('disabled','true');
        }
    });
    $(document).on("change","#exam_id",function(){
        var id = this.value;
        if(id>0){
            $("#addMarks").removeAttr("disabled");}
        else{
            $("#addMarks").attr("disabled","true");}
    });
    $(document).on("click","#import",function(){
        var state=this.value;
        console.log(state);
        if(state=='importdata'){
            $('#importAuto').show();
            $('#insertManual').show();
        }
        else{
            $('#importAuto').hide();
            $('#insertManual').show();
        }
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