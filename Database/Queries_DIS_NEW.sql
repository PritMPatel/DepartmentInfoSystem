SELECT * FROM finalyearproject.marks_obtained_master, question_master where marks_obtained_master.questionID=question_master.questionID and coID=2;

SELECT distinct enrollmentno FROM finalyearproject.marks_obtained_master, question_master where marks_obtained_master.questionID=question_master.questionID and coID=2;

/*FIND BATCH PRESENT IN DB*/
select distinct batch from student_master;


select * from exam_master em, question_master qm where em.examID=qm.examID and qm.coID=2 and batch=2017;

select coID,sum(queMaxWeighMarks) from exam_master em, question_master qm where em.examID=qm.examID and batch=2017 and subjectID=1 group by coID order by coID;

select sum(queMaxWeighMarks) from exam_master em, question_master qm where em.examID=qm.examID and batch=2017 and subjectID=1;

select enrollmentno,question_master.coID, sum(obtainedWeighMarks) from marks_obtained_master,question_master,exam_master where marks_obtained_master.questionID=question_master.questionID and question_master.examID = exam_master.examID and batch=2017 and exam_master.subjectID=1 group by enrollmentno,coID order by enrollmentno; 

SELECT * FROM finalyearproject.marks_obtained_master, question_master where marks_obtained_master.questionID=question_master.questionID and coID=2;

select enrollmentno,t1.typeDescription,t1.examName,qm.queDesc,coSrNo,obtainedWeighMarks from marks_obtained_master mm,question_master qm,co_master cm,(select examID,typeDescription,examName from examtype_master etm,exam_master em where etm.examtypeID=em.examtypeID) as t1 where qm.examID=t1.examID and mm.questionID=qm.questionID and qm.coID=cm.coID and mm.questionID in(select questionID from question_master where examID in (select examID from exam_master where batch=2017 and subjectID=1)) order by enrollmentno,typeDescription,examName,queDesc; 

select examID,typeDescription,examName from examtype_master etm,exam_master em where etm.examtypeID=em.examtypeID and em.subjectID=1 and batch=2017;

select typeDescription,count(em.examID) as colspan from examtype_master etm,exam_master em,question_master qm where qm.examID=em.examID and etm.examtypeID=em.examtypeID and em.subjectID=1 and batch=2017 group by typeDescription;
select examName,count(em.examID) as colspan, examtypeID from exam_master em,question_master qm where em.subjectID=1 and batch=2017 group by em.examID order by examtypeID;
select examName,queDesc, examtypeID from exam_master em,question_master qm where em.subjectID=1 and batch=2017 order by examtypeID;

select coSrNo,examtype_master.typeDescription,examName,queDesc from question_master,exam_master,examtype_master,co_master where question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND co_master.subjectID order by coSrNo,typeDescription,examName,queDesc;
select coSrNo,count(coSrNo) as colspan from question_master,exam_master,examtype_master,co_master where question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 group by coSrNo order by coSrNo,typeDescription,examName,queDesc;
	select typeDescription,count(exam_master.examTypeID) as colspan from question_master,exam_master,examtype_master,co_master where question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 group by coSrNo order by coSrNo,typeDescription,examName,queDesc;
select examName,count(exam_master.examID) as colspan from question_master,exam_master,examtype_master,co_master where question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 group by coSrNo order by coSrNo,typeDescription,examName,queDesc;
select enrollmentno,coSrNo,typeDescription,examName,queDesc,question_master.questionID,obtainedMarks,obtainedWeighMarks from question_master,exam_master,examtype_master,co_master,marks_obtained_master where marks_obtained_master.questionID=question_master.questionID and question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 and enrollmentno=1 order by enrollmentno,coSrNo,typeDescription,examName,queDesc;

select enrollmentno,question_master.questionID,obtainedMarks,obtainedWeighMarks from question_master,exam_master,examtype_master,co_master,marks_obtained_master where marks_obtained_master.questionID=question_master.questionID and question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 and enrollmentno=1 and question_master.questionID in (select distinct questionID from marks_obtained_master) and coSrNo=1 order by enrollmentno,coSrNo,typeDescription,examName,queDesc;
select enrollmentno,coSrNo,sum(obtainedWeighMarks) from question_master,exam_master,examtype_master,co_master,marks_obtained_master where marks_obtained_master.questionID=question_master.questionID and question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 and enrollmentno=1 and question_master.questionID in (select distinct questionID from marks_obtained_master) group by coSrNo order by enrollmentno,coSrNo,typeDescription,examName,queDesc;

select examName,count(exam_master.examID)*2 as colspan from question_master,exam_master,examtype_master,co_master where question_master.coID=co_master.coID	AND exam_master.examID=question_master.examID AND examtype_master.examTypeID=exam_master.examTypeID AND exam_master.subjectID=1 and exam_master.batch=2017 and question_master.questionID in (select distinct questionID from marks_obtained_master) group by coSrNo order by coSrNo,typeDescription,examName,queDesc;

select * from question_master where coID1 and coID2 in(select coID from co_master where subjectID=1);

/*Calculates Total Weighted Marks CO Wise and Attainment of that in Percentage for each student*/
SELECT 
    enrollmentno,
    table1.coSrNo,
    TotalObtWeiMarks,
    MaxTotalWeighMarks,
    (TotalObtWeiMarks * 100 / MaxTotalWeighMarks) AS CO_ATTAINMENT
FROM
    (SELECT 
        enrollmentno,
            coSrNo,
            SUM(obtainedWeighMarks) AS TotalObtWeiMarks
    FROM
        marks_obtained_master, question_master, exam_master, co_master
    WHERE
        marks_obtained_master.questionID = question_master.questionID
			AND question_master.coID = co_master.coID
            AND question_master.examID = exam_master.examID
            AND batch = 2017
            AND exam_master.subjectID = 1
            AND enrollmentno = 1
    GROUP BY enrollmentno , question_master.coID
    ORDER BY enrollmentno) AS table1,
    (SELECT 
        qm.coID,coSrNo, SUM(queMaxWeighMarks) AS MaxTotalWeighMarks
    FROM
        exam_master em, question_master qm, co_master cm
    WHERE
        em.examID = qm.examID AND qm.coID = cm.coID AND batch = 2017 AND em.subjectID = 1
    GROUP BY qm.coID) AS table2
WHERE
    table1.coSrNo = table2.coSrNo
ORDER BY enrollmentno , table1.coSrNo;

/*CO WISE AVG ATTAINMENT OF CLASS*/
SELECT 
    coID, AVG(CO_ATTAINMENT)
FROM
    (SELECT 
        enrollmentno,
            table1.coID,
            TotalObtWeiMarks,
            MaxTotalWeighMarks,
            (TotalObtWeiMarks * 100 / MaxTotalWeighMarks) AS CO_ATTAINMENT
    FROM
        (SELECT 
        enrollmentno,
            question_master.coID,
            SUM(obtainedWeighMarks) AS TotalObtWeiMarks
    FROM
        marks_obtained_master, question_master, exam_master
    WHERE
        marks_obtained_master.questionID = question_master.questionID
            AND question_master.examID = exam_master.examID
            AND batch = 2017
            AND exam_master.subjectID = 1
    GROUP BY enrollmentno , coID
    ORDER BY enrollmentno) AS table1, (SELECT 
        coID, SUM(queMaxWeighMarks) AS MaxTotalWeighMarks
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1
    GROUP BY coID) AS table2
    WHERE
        table1.coID = table2.coID
    ORDER BY enrollmentno , table1.coID) AS t3
GROUP BY coID
ORDER BY coID;

/*Weightage of Each CO*/
SELECT 
	coID,
    (COWiseMax * 100 / TotalAllCO) AS WeightageOfCo
FROM
    (SELECT 
        coID, SUM(queMaxWeighMarks) AS COWiseMax
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1
    GROUP BY coID) AS t1,
    (SELECT 
        SUM(queMaxWeighMarks) AS TotalAllCO
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1) AS t2
ORDER BY coID;

/*CO WISE ATTAINMENT FOR EACH ENROLLMENT*/
select 
	enrollmentno,t0.coID,t0.CO_ATTAINMENT,t00.WeightageOfCo,(t0.CO_ATTAINMENT*t00.WeightageOfCo/100) as COWiseAttainment
from (SELECT 
    enrollmentno,
    table1.coID,
    TotalObtWeiMarks,
    MaxTotalWeighMarks,
    (TotalObtWeiMarks * 100 / MaxTotalWeighMarks) AS CO_ATTAINMENT
FROM
    (SELECT 
        enrollmentno,
            question_master.coID,
            SUM(obtainedWeighMarks) AS TotalObtWeiMarks
    FROM
        marks_obtained_master, question_master, exam_master
    WHERE
        marks_obtained_master.questionID = question_master.questionID
            AND question_master.examID = exam_master.examID
            AND batch = 2017
            AND exam_master.subjectID = 1
    GROUP BY enrollmentno , coID
    ORDER BY enrollmentno) AS table1,
    (SELECT 
        coID, SUM(queMaxWeighMarks) AS MaxTotalWeighMarks
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017 AND subjectID = 1
    GROUP BY coID) AS table2
WHERE
    table1.coID = table2.coID
ORDER BY enrollmentno , table1.coID) as t0,
(SELECT 
	coID,
    (COWiseMax * 100 / TotalAllCO) AS WeightageOfCo
FROM
    (SELECT 
        coID, SUM(queMaxWeighMarks) AS COWiseMax
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1
    GROUP BY coID) AS t1,
    (SELECT 
        SUM(queMaxWeighMarks) AS TotalAllCO
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1) AS t2
ORDER BY coID) as t00 where t0.coID = t00.coID order by enrollmentno,t0.coID; 

/*ENROLLMENT NO WISE ATTAINMENT OF SUBJECT*/
select enrollmentno, sum(COWiseAttainment) as OverallAttainment from (select 
	enrollmentno,t0.coID,t0.CO_ATTAINMENT,t00.WeightageOfCo,(t0.CO_ATTAINMENT*t00.WeightageOfCo/100) as COWiseAttainment
from (SELECT 
    enrollmentno,
    table1.coID,
    TotalObtWeiMarks,
    MaxTotalWeighMarks,
    (TotalObtWeiMarks * 100 / MaxTotalWeighMarks) AS CO_ATTAINMENT
FROM
    (SELECT 
        enrollmentno,
            question_master.coID,
            SUM(obtainedWeighMarks) AS TotalObtWeiMarks
    FROM
        marks_obtained_master, question_master, exam_master
    WHERE
        marks_obtained_master.questionID = question_master.questionID
            AND question_master.examID = exam_master.examID
            AND batch = 2017
            AND exam_master.subjectID = 1
    GROUP BY enrollmentno , coID
    ORDER BY enrollmentno) AS table1,
    (SELECT 
        coID, SUM(queMaxWeighMarks) AS MaxTotalWeighMarks
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017 AND subjectID = 1
    GROUP BY coID) AS table2
WHERE
    table1.coID = table2.coID
ORDER BY enrollmentno , table1.coID) as t0,
(SELECT 
	coID,
    (COWiseMax * 100 / TotalAllCO) AS WeightageOfCo
FROM
    (SELECT 
        coID, SUM(queMaxWeighMarks) AS COWiseMax
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1
    GROUP BY coID) AS t1,
    (SELECT 
        SUM(queMaxWeighMarks) AS TotalAllCO
    FROM
        exam_master em, question_master qm
    WHERE
        em.examID = qm.examID AND batch = 2017
            AND subjectID = 1) AS t2
ORDER BY coID) as t00 where t0.coID = t00.coID order by enrollmentno,t0.coID) as t000 group by enrollmentno; 


SELECT * FROM finalyearproject.question_master
WHERE
    coID1 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR 
    coID2 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR
    coID3 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR
    coID4 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR
    coID5 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR
    coID6 IN (SELECT coID FROM co_master WHERE subjectID = 1) OR
    coID7 IN (SELECT coID FROM co_master WHERE subjectID = 1);
    
    select question_master.questionID,typeDescription,examName,calcQuesMaxMarks from question_master,exam_master,examtype_master where (select coID from co_master where coID=1) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID;
    
select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1);

/*HEADING FOR CALCULATE ATTAINMENT*/
select count(typeDescription) as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=2) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1) order by enrollmentno,typeDescription,examName,QueDesc) as t;
select typeDescription,count(examName) as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by typeDescription order by typeDescription,examName,QueDesc;
select examName,count(queDesc) as colspan from (select distinctrow typeDescription,examName,queDesc from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by examName order by typeDescription,examName,QueDesc;
select distinctrow typeDescription,examName,queDesc,calcQuesMaxMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=2) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1) order by enrollmentno,typeDescription,examName,QueDesc;    

select enrollmentno,typeDescription,examName,queDesc,calcObtainedMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where enrollmentno="170170116001" and question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)  order by enrollmentno,typeDescription,examName,QueDesc;



select enrollmentno,sum(calcQuesMaxMarks),sum(calcObtainedMarks) as totalCalcObt,sum(nCalcQuesMaxMarks) as maxNCalcObt,sum(nCalcObtainedMarks) as totalNCalcObt from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc;

select enrollmentno,totalCalcObt,totalNCalcObt,totalNCalcObt*100/maxNCalcObt as attainPercent from (select enrollmentno,sum(calcQuesMaxMarks),sum(calcObtainedMarks) as totalCalcObt,sum(nCalcQuesMaxMarks) as maxNCalcObt,sum(nCalcObtainedMarks) as totalNCalcObt from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where enrollmentno="170170116001" and question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc) as t;


select distinct sum(calcQuesMaxMarks) from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc;
select distinct sum(nCalcQuesMaxMarks) from (select enrollmentno,typeDescription,examName,queDesc,calcQuesMaxMarks,calcObtainedMarks,nCalcQuesMaxMarks,nCalcObtainedMarks from marks_obtained_master,question_master,exam_master,examtype_master where question_master.examID=exam_master.examID and exam_master.examtypeID=examtype_master.examtypeID and question_master.questionID=marks_obtained_master.questionID and marks_obtained_master.questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1)) as t group by enrollmentno order by enrollmentno,typeDescription,examName,QueDesc;
	
select enrollmentno,sum(calcObtainedMarks),sum(nCalcObtainedMarks) from marks_obtained_master where questionID in (select question_master.questionID from question_master,exam_master,examtype_master where (select coID from co_master where coID=4) IN (coID1,coID2,coID3,coID4,coID5,coID6,coID7) and enrollmentno="170170116001" and question_master.examID=exam_master.examID and exam_master.examTypeID=examtype_master.examTypeID and exam_master.batch=2017 and exam_master.subjectID=1) group by enrollmentno;
/*DROPDOWN OF CO FOR CALCULATEATTAINMENT*/
select * from co_master where coID not in(SELECT coID FROM finalyearproject.attainment_co,student_master where attainment_co.enrollmentno=student_master.enrollmentno and subjectID=1 and batch=2017);

