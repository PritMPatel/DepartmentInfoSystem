
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
<%
	Connect con = null;
	ResultSet rs = null;
	ResultSet rsAllSubject=null;
	ResultSet rsBatch=null;
    ResultSet rsCo=null;
	ResultSetMetaData mtdt = null;
	con = new Connect();
	int userDept = 0;
%>
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
<title>UPDATE CO STATEMENT</title>
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
					<li><a href="facultyUpdateCo.jsp" class="active main-link">UPDATE CO</a></li>
					<li><a href="facultyUpdateExam.jsp" class="main-link">UPDATE
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
		CO STATEMENT</h3>
	<form method="POST">
		<%
        if(request.getParameter("next")==null){%>
        <div id="subjectBatch">
            <div class="form-row">
                <div class="col-sm"></div>
                <div class="col-sm">
                    <label for="subjectID">Subject:</label> <select class="uk-select" name="subjectid" id="subjectid" required>
                        <option value="" disabled selected>Select Subject</option>
                        <%
                                    if (session.getAttribute("facultyDepartment") != null) {
                                        userDept = (int) session.getAttribute("facultyDepartment");
                                    }
                                    rsAllSubject=con.SelectData("select * from subject_master where subjectID in(select distinct subjectID from co_master where facultyID="+session.getAttribute("facultyID")+");");
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
                    <label for="batch">Batch:</label> <select class="uk-select" name="batch1" id="batch1" required>
                        <option value="" disabled selected>Select Batch</option>
                        <%
                                    rsBatch=con.SelectData("select distinct batch from student_master where studentDepartment="+session.getAttribute("facultyDepartment")+";");
                                    while(rsBatch.next()){
                                        out.println("<option value="+rsBatch.getInt("batch")+">"+rsBatch.getInt("batch")+"</option>");
                                    }
                                %>
                    </select>
                </div>
                <div class="col-sm"></div>
            </div>
            <center class="mt-3">
                <button name="next" class="btn" value="next">Next</button>
                <br/>
            </center>
        </div>
        <%}
        if(request.getParameter("next")!=null){
            rsCo=con.SelectData("select * from co_master where subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+" and facultyID="+(int)session.getAttribute("facultyID")+";");
            rs=con.SelectData("select * from co_master where subjectID="+request.getParameter("subjectid")+" and batch="+request.getParameter("batch1")+" and facultyID="+(int)session.getAttribute("facultyID")+" and coID not in (select distinct coID from attainment_co) order by coSrNo;");
            if(rsCo.next()){
                if(rs.next()){
                    rs.last();
                    int nOfCo = rs.getRow();
                    rs.beforeFirst();
                    out.println("<input type='number' name='subject_id' value='"+request.getParameter("subjectid")+"' readonly hidden>");
                    out.println("<input type='number' name='batch' value='"+request.getParameter("batch1")+"' readonly hidden>");
                    out.println("<input type='number' name='cono' value='"+nOfCo+"' readonly hidden>");
                    int x=1;
                    while(rs.next()){%>
                    <div class="form-row">
                        <div class="col-sm">
                            <label for="coStmt">CO Statement <%=rs.getInt("coSrNo")%> :</label>
                            <input type="text" class="uk-input" name="co<%=rs.getInt("coSrNo")%>" value="<%=rs.getString("coStatement")%>" required>
                        </div>
                    </div>  
                    <%
                    x++;
                    }
                    %>
                    <center class="mt-3">
                        <button name="update" class="btn" value="update">Update</button>
                    </center>
                    <%
                }
                else{
                    out.println("<script>UIkit.modal.alert('<p class=\"uk-modal-body uk-text-center\"><b>ERROR</b>: You can\\'t Update CO Statement. You have already Saved Attainment Calculations.</p>').then(function(){window.history.back();});</script>");
                }
            }
            else{
                out.println("<script>UIkit.modal.alert('<p class=\"uk-modal-body uk-text-center\"><b>ERROR</b>: No Data Found. Please Check Subject and Batch again.</p>').then(function(){window.history.back();});</script>");
            }
        }
        if(request.getParameter("update")!=null){
            rs=con.SelectData("select * from co_master where subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+" and facultyID="+(int)session.getAttribute("facultyID")+" and coID not in (select distinct coID from attainment_co) order by coSrNo;");
            rs.last();
            int conos = rs.getRow();
            rs.beforeFirst();
            int x = 1;
            String coStat="";
            while(rs.next()){
                coStat += "WHEN "+rs.getInt("coSrNo")+" THEN '"+request.getParameter("co"+rs.getInt("coSrNo"))+"' ";
            }
            if(con.Ins_Upd_Del("UPDATE co_master SET coStatement = CASE coSrNo "+coStat+"END WHERE subjectID="+request.getParameter("subject_id")+" and batch="+request.getParameter("batch")+" and facultyID="+(int)session.getAttribute("facultyID")+" and coID not in(select distinct coID from attainment_co);")){
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-success\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>CO Statements Updated Successfully.</b></div>')</script>");        
                con.commitData();
            }
            else{
                out.println("<script>$('#head').prepend('<div class=\"uk-alert-danger\" uk-alert><a class=\"uk-alert-close\" uk-close></a><b>ERROR</b>: Please Update CO Again.</div>')</script>");
                con.rollbackData();
            }
        }
        %>
</form>
<%@include file="/footer.jsp"%>
<%
    }
    else{
		out.println("<script>alert('SESSION INVALID!!! PLEASE LOGIN AGAIN!!!!!');</script>");
		response.sendRedirect("/dis/login.jsp");
	}
%>

