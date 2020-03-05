<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="Connection.Connect"%>
<%@page import="java.sql.ResultSetMetaData"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>ADD MARKS</title>
        <script src="js/jquery-3.2.1.min.js"></script>
    </head>
    <body>
        <a href="addCo.jsp">Add CO</a><br/>
        <a href="addExam.jsp">Add Exam</a><br/>
        <a href="addQue.jsp">Add Question</a><br/>
        <a href="addMarks.jsp">Add Marks</a><br/>
        <a href="calculateAttainment.jsp">Calculate Attainment</a><br/>
        <br/><br/>
        <form method="POST">
                SubjectID:<input type="number" name="subject1"/><br/> 
                Batch:<input type="number" name="batch1"/><br/><br/>
                <button name="examselect" value="examselect">Select Exam</button><br/></form>
            <%
                Connect con=null;
                ResultSet rs=null;
                ResultSet rs2=null;
                ResultSet rs3=null;
                ResultSetMetaData mtdt=null;
                String s = "";
                int nOfQue=0;
                int nOfStudents=0;
                int x=0;
                int x2=0;
                int eid=0;
                con=new Connect();
                if(request.getParameter("examselect")!=null){
                    rs=con.SelectData("select * from exam_master where subjectID="+request.getParameter("subject1")+" and batch="+request.getParameter("batch1")+";");
                    out.println("<br/><form method='POST'>SubjectID:<input type='number' name='subject1' value='"+request.getParameter("subject1")+"' disabled/><br/> ");
                    out.println("Batch:<input type='number' name='batch1' value='"+request.getParameter("batch1")+"' disabled/><br/> ");
                    out.println("ExamID:<select name='examid'>");
                    while(rs.next()){
                        out.println("<option value='"+rs.getInt("examID")+"'>"+rs.getInt("examID")+" - "+rs.getString("examName")+"</option>");
                    }
                    out.println("</select><br/><br/><button name='addMarks' value='addMarks'>Add Marks</button></form><br/><br/>");
                }  
                if(request.getParameter("addMarks")!=null){
                    out.println("<br/>ExamID: <input type='number' name='examid2' value='"+request.getParameter("examid")+"' disabled/>");
                    rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,nQueMaxMarks,queMaxWeighMarks,coSrNo FROM question_master qm,co_master cm where qm.coID=cm.coID and examID="+request.getParameter("examid")+" order by questionID;");
                    rs2.last();
                    nOfQue = rs2.getRow();
					x=1;
					x2=1;
                    rs2.beforeFirst();
                    out.println("<form method='POST'><table border='1'><tr><th>Exam</th><th colspan='"+nOfQue+"'><input type='number' value='"+request.getParameter("examid")+"' disabled/></th></tr><tr><th>Enrollment</th>");
					while(x<=nOfQue && rs2.next()){
						out.println("<th>Q"+x+" - CO "+rs2.getInt("coSrNo")+"</th>");
						x++;
					}
					out.println("</tr>");
					rs2.beforeFirst();
					x=1;
					rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("examid")+");");
					rs3.last();
					nOfStudents=rs3.getRow();
					rs3.beforeFirst();
					while(x2<=nOfStudents && rs3.next()){
						out.println("<tr><td><input type='number' name='enroll"+x2+"' value='"+rs3.getInt("enrollmentno")+"' disabled></td>");
						while(x<=nOfQue){
							out.println("<td><input type='number' name='"+x2+"que"+x+"'></td>");
							x++;
						}
                        x=1;
						out.println("</tr>");
						x2++;
					}
                    out.println("</table><br/>Confirm ExamID<input type='number' name='examid2'><br/><br/><button type='submit' name='submit' value='submit'>Submit</button></form>");  
                }%>
                
                <%
                if(request.getParameter("submit")!=null){
                    out.println(request.getParameter("examid2"));
                    rs2=con.SelectData("SELECT questionID,queDesc,queMaxMarks,nQueMaxMarks,queMaxWeighMarks,coSrNo FROM question_master qm ,co_master cm where qm.coID=cm.coID and examID="+request.getParameter("examid2")+" order by questionID;");
                    rs3=con.SelectData("select enrollmentno from student_master where batch in (select batch from exam_master where examID="+request.getParameter("examid2")+");");
                    rs3.last();
                    nOfStudents = rs3.getRow();
                    out.println(nOfStudents);
                    rs2.last();
                    nOfQue = rs2.getRow();
                    out.println(nOfQue);
                    x=1;
                    x2=1;
                    while(x2<=nOfStudents){
                        out.println("It reach inside first loop");
                        rs2.beforeFirst();
                        x=1;
                        while(x<=nOfQue && rs2.next()){
                            out.println("It reach inside Second loop");
                            float nFact = rs2.getFloat("nQueMaxMarks")/rs2.getFloat("queMaxMarks");
                            float wFact = rs2.getFloat("queMaxWeighMarks")/rs2.getFloat("queMaxMarks");
                            float obtWeighMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*wFact;
                            float obtNormMarks = Float.parseFloat(request.getParameter(x2+"que"+x))*nFact;
                            out.println("<br><br>n w oN oW"+"-"+nFact+"-"+wFact+"-"+obtNormMarks+"-"+obtWeighMarks+"<br><br>");
                            if(con.Ins_Upd_Del("insert into marks_obtained_master(enrollmentno,questionID,obtainedMarks,nObtainedMarks,obtainedWeighMarks) values("+request.getParameter("enroll"+x2)+","+rs2.getInt("questionID")+","+request.getParameter(x2+"que"+x)+","+obtNormMarks+","+obtWeighMarks+");")){}
                            else{
                                out.println("<script>alert('ERROR : @"+request.getParameter("enroll"+x2)+" FOR QUESTION "+x+"');</script>");
                            }
                            x++;
                        }
                        x2++;
                    }
                }
            %>
    </body>
</html>