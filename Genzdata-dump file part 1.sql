use genzdataset;
show tables;
select count(*) from personalized_info;
-- ques1
select count(ResponseID) from personalized_info
where  Gender like 'Male%'  and CurrentCountry = 'India';

-- ques 2
select count(ResponseID) from personalized_info
where  Gender like '%Female%' and CurrentCountry = 'India';

-- ques3
select count(learning_aspirations.ResponseID) from learning_aspirations  inner join personalized_info on learning_aspirations.ResponseID = personalized_info.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%' ;

-- ques4 
select count(learning_aspirations.ResponseID) from learning_aspirations  inner join personalized_info on learning_aspirations.ResponseID = personalized_info.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%' and Gender like 'Male%' ;

-- ques5
select count(learning_aspirations.ResponseID) from learning_aspirations  inner join personalized_info on learning_aspirations.ResponseID = personalized_info.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%' and Gender like 'Female%' ;

-- ques6
SELECT
    SUM(CASE WHEN Gender LIKE 'Male%' THEN 1 ELSE 0 END) AS Male_GenZ_Affectedby_Parents,
    SUM(CASE WHEN Gender LIKE 'Female%' THEN 1 ELSE 0 END) AS Female_GenZ_Affectedby_Parents
FROM learning_aspirations 
INNER JOIN personalized_info ON learning_aspirations.ResponseID = personalized_info.ResponseID 
WHERE CareerInfluenceFactor LIKE 'My Parents%' AND CurrentCountry LIKE 'India%';

-- ques7 
SELECT COUNT(learning_aspirations.ResponseID) AS Influence_by_media_influencer_both
FROM learning_aspirations
INNER JOIN personalized_info ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor LIKE 'Influencers%'AND'Social Media%' AND CurrentCountry LIKE 'India%';

-- ques8
SELECT
    SUM(CASE WHEN Gender LIKE 'Male%' THEN 1 ELSE 0 END) AS Male_GenZ_Affectedby_Parents,
    SUM(CASE WHEN Gender LIKE 'Female%' THEN 1 ELSE 0 END) AS Female_GenZ_Affectedby_Parents
FROM learning_aspirations 
INNER JOIN personalized_info ON learning_aspirations.ResponseID = personalized_info.ResponseID 
WHERE CareerInfluenceFactor LIKE 'Influencers%' AND 'Social Media%' AND CurrentCountry LIKE 'India%';

-- ques9
SELECT
    SUM(CASE WHEN CareerInfluenceFactor LIKE 'Social Media%' AND HigherEducationAbroad LIKE 'Yes%' THEN 1 ELSE 0 END) AS Genz_Going_Abroad
FROM learning_aspirations; 

-- ques10
SELECT
    SUM(CASE WHEN CareerInfluenceFactor LIKE 'people in their circle%' AND HigherEducationAbroad LIKE 'Yes%' THEN 1 ELSE 0 END) AS Genz_Going_Abroad2
FROM learning_aspirations

