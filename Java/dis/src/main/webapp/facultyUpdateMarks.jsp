
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
<%@include file="/header.jsp"%>
<title>UPDATE MARKS</title>
<style>
.col-sm{
	padding-left: 30px !important;
	padding-right: 30px !important;
}
td:hover,tr:hover{
    background-color: white !important;
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
					<li><a href="facultyAddMarks.jsp" class="active main-link">ADD
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
	<h3 style="text-align: center; padding-bottom: 10px;">UPDATE
		MARKS</h3>
	<form method="POST" id="main">
    <%
    Connect con=null;
    ResultSet rs=null;
    ResultSet rs2=null;
    ResultSet rs3=null;
    ResultSet rs4=null;
    ResultSet rs5=null;
    ResultSet rsSubject=null;
    ResultSet rsMark=null;
    ResultSetMetaData mtdt=null;
    String s = "ESE";
    int nOfQue=0;
    int x=0;
    int x2=0;
    int eid=0;
    con=new Connect();
    if(request.getParameter("next")==null && request.getParameter("updateMarks")==null){%>
    <%@include file="/subjectBatchForm.jsp"%>
    <%}
    if(request.getParameter("next")!=null){
        rsSubject=con.SelectData("select subjectName from subject_master where subjectID="+request.getParameter("subjectid")+";");
                    rsSubject.next();
                    rs=con.SelectData("select * from exam_master where examID in (select distinct examID from question_master) and subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+";");
                    out.println(
                            "<div class='form-row'><div class='col-sm'><label for='subjectID'>Subject:</label><input type='number' class='uk-input' id='subject_id' name='subject_id' value='"+request.getParameter("subjectid")+"' hidden/><input type='text' class='uk-input' id='subjectName' name='subjectName' value='"+ rsSubject.getString("subjectName")+"' readonly/></div>");
                    out.println(
                            "<div class='col-sm'><label for='batch'>Batch:</label><input type='number' name='batch' class='uk-input' id='batch' value='"
                                    + request.getParameter("batch1") + "' readonly/></div></div> ");
                    out.println(
                            "<div class='form-row'><div class='col-sm'><label for='examID'>Exam:</label><select class='uk-select' id='exam_id' name='exam_id' required><option value='' selected disabled>SELECT EXAM</option>");
                    while (rs.next()) {
                        out.println("<option value='" + rs.getInt("examID") + "'>"
                                + rs.getString("examName") + "</option>");
                    }
                    out.println("</select></div><div class='col-sm'><label for='enrollmentno'>Enrollment No:</label><input type='text' name='enrollmentno' class='uk-input' maxlength='12' size='12' placeholder='Enter Enrollment No'/></div></div>");
                    out.println("<center class=\"mt-3\"><button class='btn' id='updateMarks' name='updateMarks' value='updateMarks'>Update Marks</button></center></form><br/>");
    }
    if(request.getParameter("updateMarks")!=null){
        rs4=con.SelectData("select typeDescription,examName from exam_master,examtype_master where exam_master.examtypeID=examtype_master.examtypeID and examID="+request.getParameter("exam_id")+";");
        rs4.next();
        if(con.CheckData("select distinct enrollmentno from attainment_co where enrollmentno="+request.getParameter("enrollmentno")+" and subjectID in (select subjectID from exam_master where examID="+request.getParameter("exam_id")+");")){
            //out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Can\\'t Update Marks. You already saved CO Attainment Calculations.</b></div>');window.location.reload();</script>");
            //out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Can't Update Marks. You already saved CO Attainment Calculations.</b></div>');</script>");
            out.println("<script>UIkit.modal.alert('<p class=\"uk-modal-body uk-text-center\"><b>ERROR</b>: Can\\'t Update Marks. You already saved CO Attainment Calculations.</p>').then(function(){window.history.back();});</script>");
            //response.sendRedirect("facultyUpdateMarks.jsp");
        }
        if(con.CheckData("select distinctrow enrollmentno from marks_obtained_master where questionID in (select questionID from question_master where examID = "+request.getParameter("exam_id")+") and enrollmentno="+request.getParameter("enrollmentno")+";")){
            if(s.equals(rs4.getString("typeDescription"))){
                out.println("<form method='POST'><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/>");
                        out.println("<div class=\"form-row\">"
                            +"<div class=\"col-sm\"></div>"
                            +"<div class=\"col-sm\"><label for='exam'>Exam:</label><input type='text' value='"+rs4.getString("examName")+"' name='examName' readonly/></div>"
                            +"<div class=\"col-sm\"></div>"
                        +"</div>");
                rsMark=con.SelectData("select enrollmentno, sum(obtainedMarks) as marks from marks_obtained_master where questionID in (select questionID from question_master where examID = "+request.getParameter("exam_id")+") and enrollmentno="+request.getParameter("enrollmentno")+";");
                rsMark.next();
                out.println("<center><table class='uk-table uk-table-hover uk-table-divider uk-table-small' border='1'><tr><th class='uk-table-small'>Enrollment</th><th class='uk-width-auto'>Obtained Marks</th></tr>");
                out.println("<tr><td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small' type='text' name='enrollment' value='"+rsMark.getString("enrollmentno")+"' readonly></td>");
                out.println("<td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small uk-form-width-small' type='number' step='0.01' id='marks' name='marks' value="+rsMark.getFloat("marks")+" required></td></tr>");
                out.println("</table><button class='btn' type='submit' name='submit' value='update'>Update</button></center></div></form>");  
            }
            else{
                out.println("<form method='POST'><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/>");
                rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,calcQuesMaxMarks,nCalcQuesMaxMarks FROM question_master qm where examID="+request.getParameter("exam_id")+" order by questionID;");
                rs2.last();
                nOfQue = rs2.getRow();
                rs2.beforeFirst();
                rsMark=con.SelectData("select enrollmentno, obtainedMarks from marks_obtained_master where questionID in (select questionID from question_master where examID = "+request.getParameter("exam_id")+") and enrollmentno="+request.getParameter("enrollmentno")+" order by questionID;");
                rsMark.next();
                x=1;
                out.println("<form method='POST'><input type='number' name='examid2' value='"+request.getParameter("exam_id")+"' hidden readonly/>");
                        out.println("<div class=\"form-row\">"
                            +"<div class=\"col-sm\"></div>"
                            +"<div class=\"col-sm\"><label for='exam'>Exam:</label><input type='text' value='"+rs4.getString("examName")+"' name='examName' readonly/></div>"
                            +"<div class=\"col-sm\"></div>"
                        +"</div>");
                out.println("<center><table class='uk-table uk-table-hover uk-table-divider uk-table-small' border='1'><tr><th class='uk-table-small'>Enrollment</th>");
                while(x<=nOfQue && rs2.next()){
                    out.println("<th class='uk-width-auto'>"+rs2.getString("queDesc")+"</th>");
                    x++;
                }
                rs2.close();
                x=1;
                out.println("<tr><td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small' type='text' name='enrollment' value='"+rsMark.getString("enrollmentno")+"' readonly></td>");
                while(x<=nOfQue){
                    out.println("<td class='uk-width-small'><input class='uk-input uk-form-blank uk-form-small uk-form-width-small' type='text' id='que"+x+"' name='que"+x+"' value='"+(float)rsMark.getFloat("obtainedMarks")+"' required></td>");
                    x++;
                }
                out.println("</tr>");
                out.println("</table><button class='btn' type='submit' name='submit' value='update'>Update</button></center></div></form>");  
            }
        }
        else{
            out.println("<script>UIkit.modal.alert('<p class=\"uk-modal-body uk-text-center\"><b>ERROR</b>: Enrollment No. Not Found.</p>').then(function(){window.history.back();});</script>");
        }
    }
    if(request.getParameter("submit")!=null){
        rs4=con.SelectData("select typeDescription from exam_master,examtype_master where exam_master.examtypeID=examtype_master.examtypeID and examID="+request.getParameter("examid2")+";");
        rs4.next();
        rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,calcQuesMaxMarks,nCalcQuesMaxMarks FROM question_master qm where examID="+request.getParameter("examid2")+" order by questionID;");
        rs2.last();
        nOfQue = rs2.getRow();
        rs2.beforeFirst();
        String value="";
        if(s.equals(rs4.getString("typeDescription"))){
            x=1;
            rs5=con.SelectData("select * from exam_master where examID="+request.getParameter("examid2")+";");
            rs5.next();
            float examMaxMarks = rs5.getFloat("totalMaxMarks");
            rs5.close();
            float marks = Float.parseFloat(request.getParameter("marks"));
            while(x<=nOfQue && rs2.next()){
                float nFact = rs2.getFloat("calcQuesMaxMarks")/rs2.getFloat("queMaxMarks");
                float wFact = rs2.getFloat("nCalcQuesMaxMarks")/rs2.getFloat("queMaxMarks");                               
                float obtMarks = marks*rs2.getFloat("queMaxMarks")/examMaxMarks;
                float calcObtMarks = obtMarks*nFact;
                float nCalcObtMarks = obtMarks*wFact;
                value += "('"+request.getParameter("enrollment")+"',"+rs2.getInt("questionID")+","+obtMarks+","+calcObtMarks+","+nCalcObtMarks+")";
                if(x!=nOfQue){
                    value+=",";
                }
                x++;
            }
            if(con.Ins_Upd_Del("delete from marks_obtained_master where enrollmentno='"+request.getParameter("enrollment")+"' and questionID in (select questionID from question_master where examID="+request.getParameter("examid2")+");") && con.Ins_Upd_Del("insert into marks_obtained_master(enrollmentno,questionID,obtainedMarks,calcObtainedMarks,nCalcObtainedMarks) values "+value+";")){
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Marks updateed Successfully.</b></div>')</script>");        
                con.commitData();
            }
            else{
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Update Marks Again.</div>')</script>");
                con.rollbackData();
            }
        }
        else{
            x=1;
            while(x<=nOfQue && rs2.next()){
                float nFact = rs2.getFloat("calcQuesMaxMarks")/rs2.getFloat("queMaxMarks");
                float wFact = rs2.getFloat("nCalcQuesMaxMarks")/rs2.getFloat("queMaxMarks");                               
                float obtMarks = Float.parseFloat(request.getParameter("que"+x));
                float calcObtMarks = obtMarks*nFact;
                float nCalcObtMarks = obtMarks*wFact;
                value += "('"+request.getParameter("enrollment")+"',"+rs2.getInt("questionID")+","+obtMarks+","+calcObtMarks+","+nCalcObtMarks+")";
                if(x!=nOfQue){
                    value+=",";
                }
                x++;
            }
            if(con.Ins_Upd_Del("delete from marks_obtained_master where enrollmentno='"+request.getParameter("enrollment")+"' and questionID in (select questionID from question_master where examID="+request.getParameter("examid2")+");") && con.Ins_Upd_Del("insert into marks_obtained_master(enrollmentno,questionID,obtainedMarks,calcObtainedMarks,nCalcObtainedMarks) values "+value+";")){
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>Marks Updated Successfully.</b></div>')</script>");        
                con.commitData();
            }
            else{
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Update Marks Again.</div>')</script>");
                con.rollbackData();
            }
        }
    }

    %>
    <%@include file="/footer.jsp"%>
<%
  }
  else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("login.jsp");
	}
%>