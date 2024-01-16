use genzdataset;
-- ques 1 
select count(responseID) from learning_aspirations
where PreferredWorkingEnvironment like '%every day office%';
-- ques 1
select sum(case when Gender like 'Male%' then 1 else 0 end) as male_learning ,
	   sum(case when Gender like 'Female%' then 1 else 0 end) as female_learning
from learning_aspirations inner join personalized_info on personalized_info.ResponseID = learning_aspirations.ResponseID
where PreferredWorkingEnvironment like '%every day office%';
-- ques 2
select (count(ResponseID)/(select count(*) from learning_aspirations ))* 100 as percentage from learning_Aspirations
 where CareerInfluenceFactor like '%parents%' and ClosestAspirationalCareer like 'business operations%';
 -- ques 3
 select (count( case when p.Gender like 'Male%' then 1 end)/count(*))*100 as Males_aspirant,
		(count(case when p.Gender like 'Female%' then 1 end )/count(*))*100 as Females_aspir
 from learning_aspirations l
 inner join personalized_info p on l.ResponseID = p.ResponseID
 where HigherEducationAbroad like '%Yes%' ;
 -- ques 4
 select (count( case when p.Gender like 'Male%' then 1 end)/count(*))*100 as Males_WanttoWork,
		(count(case when p.Gender like 'Female%' then 1 end )/count(*))*100 as Females_WanttoWork
        from mission_aspirations m inner join personalized_info p on m.ResponseID = p.ResponseID
        where MisalignedMissionLikelihood like 'will work%';
        
select (count( case when p.Gender like 'Male%' then 1 end)/count(*))*100 as Males_notWanttoWork,
		(count(case when p.Gender like 'Female%' then 1 end )/count(*))*100 as Females_notWanttoWork
        from mission_aspirations m inner join personalized_info p on m.ResponseID = p.ResponseID
        where MisalignedMissionLikelihood like 'will not work%';
-- ques 5
SELECT DISTINCT(l.PreferredWorkingEnvironment), count(*) as freq
FROM learning_aspirations l
INNER JOIN personalized_info p
ON l.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%'
GROUP BY l.PreferredWorkingEnvironment
ORDER BY freq DESC;
-- ques 6
 SELECT count(p.Gender)
FROM mission_aspirations m
INNER JOIN personalized_info p ON m.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%' AND m.NoSocialImpactLikelihood BETWEEN 1 AND 5;
-- query 7 
 select count( case when p.Gender like 'Male%' then 1 end) as Males_aspirant
 from learning_aspirations l
 inner join personalized_info p on l.ResponseID = p.ResponseID
 where l.HigherEducationAbroad like '%Yes%' and l.CareerInfluenceFactor like '%parents%' ;
 -- query 8 
 SELECT 
  (count(case when p.gender like 'Male%' then 1 end)/count(*))*100 as Total_male,
  (count(case when p.gender like 'Female%' then 1 end)/count(*))*100 as Total_Female
FROM mission_aspirations m
INNER JOIN personalized_info p ON m.ResponseID = p.ResponseID
inner join learning_aspirations l on l.ResponseID=m.ResponseID
WHERE  m.NoSocialImpactLikelihood BETWEEN 8 AND 10 and l.HigherEducationAbroad like '%yes%';
 
-- query 9 
WITH GenderCounts AS (
    SELECT 
        p.Gender,
        ma.PreferredWorkSetup,
        COUNT(*) AS Count
    FROM 
        manager_aspirations ma
    INNER JOIN 
        personalized_info p ON ma.ResponseID = p.ResponseID
    WHERE 
        ma.PreferredWorkSetup LIKE '%team%'
    GROUP BY 
        p.Gender, ma.PreferredWorkSetup
)

SELECT 
    Gender,
    PreferredWorkSetup,
    Count,
    ROUND(Count * 100.0 / SUM(Count) OVER (PARTITION BY PreferredWorkSetup), 2) AS Percentage
FROM 
    GenderCounts
ORDER BY 
    PreferredWorkSetup, Gender;
-- query  10 
SELECT DISTINCT(WorkLikelihood3Years)
FROM manager_aspirations;

SELECT COUNT(ma.WorkLikelihood3Years) AS Female_will_work
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%' AND ma.WorkLikelihood3Years LIKE 'Will work%'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Female_will_be_hard
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%' AND ma.WorkLikelihood3Years LIKE 'This will%'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Female_No_way
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%' AND ma.WorkLikelihood3Years LIKE 'No way'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Female_No_way_crazy
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Female%' AND ma.WorkLikelihood3Years LIKE 'No way%'; 

/* Now for Male */
SELECT COUNT(ma.WorkLikelihood3Years) AS Male_will_work
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Male%' AND ma.WorkLikelihood3Years LIKE 'Will work%'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Male_will_be_hard
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Male%' AND ma.WorkLikelihood3Years LIKE 'This will%'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Male_No_way
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Male%' AND ma.WorkLikelihood3Years LIKE 'No way'; 

SELECT COUNT(ma.WorkLikelihood3Years) AS Male_No_way_crazy
FROM manager_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID
WHERE p.Gender LIKE 'Male%' AND ma.WorkLikelihood3Years LIKE 'No way%'; 

-- query 11
SELECT p.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary3Years, 'k', 1) AS SIGNED)) AS Avg_Starting_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
GROUP BY p.Gender;
-- query 12 
SELECT p.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) AS SIGNED)) AS Avg_Starting_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
GROUP BY p.Gender;
-- query 13
SELECT p.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
GROUP BY p.Gender;

-- query 14
SELECT p.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary5Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
GROUP BY p.Gender;

-- query 15
SELECT p.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary3Years, 'k', 1) AS SIGNED)) AS Avg_Starting_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
WHERE p.CurrentCountry LIKE 'India%'
GROUP BY p.Gender;

-- query 16
SELECT p.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) AS SIGNED)) AS Avg_Starting_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
WHERE p.CurrentCountry LIKE 'India%'
GROUP BY p.Gender;


-- query 17
SELECT p.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
WHERE p.CurrentCountry LIKE 'India%'
GROUP BY p.Gender;



-- query 18
SELECT p.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary5Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info p
INNER JOIN mission_aspirations m2 
ON p.ResponseID = m2.ResponseID
WHERE p.CurrentCountry LIKE 'India%'
GROUP BY p.Gender;

-- query 19
SELECT 
     COUNT(CASE WHEN p.Gender LIKE 'Male%' THEN 1 END) AS Male_GenZ,
     COUNT(CASE WHEN p.Gender LIKE 'Female%' THEN 1 END) AS Female_GenZ
FROM mission_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID 
WHERE p.CurrentCountry LIKE 'India%' AND ma.MisalignedMissionLikelihood LIKE 'Will work%';

-- these people will not work for comapnies whose mission is misaligned     
SELECT 
     COUNT(CASE WHEN p.Gender LIKE 'Male%' THEN 1 END) AS Male_GenZ,
     COUNT(CASE WHEN p.Gender LIKE 'Female%' THEN 1 END) AS Female_GenZ
FROM mission_aspirations ma
INNER JOIN personalized_info p ON ma.ResponseID = p.ResponseID 
WHERE p.CurrentCountry LIKE 'India%' AND ma.MisalignedMissionLikelihood LIKE 'Will NOT%';
