select * from marketing_dataset
select count(*) from marketing_dataset

--Checking null values
select 
sum(case when Age is null then 1 else 0 end) as Age_Nulls,
sum(case when Job is null then 1 else 0 end) as Job_Nulls,
Sum(case when Marital is null then 1 else 0 end) as Marital_Nulls,
Sum(case when Education is null then 1 else 0 end) as education_Nulls,
Sum(case when Default is null then 1 else 0 end) as default_Nulls,
sum(case when Balance is null then 1 else 0 end) as Balance_Nulls,
sum(case when Housing is null then 1 else 0 end)as Housing_Nulls,
sum(case when Loan is null then 1 else 0 end) as Loan_Nulls,
sum(case when Contact is null then 1 else 0 end) as Contact_Nulls,
sum(case when Outcome is null then 1 else 0 end) as Outtcome_Nulls
from marketing_dataset

--Customer segmentation
--Segmentation by Age
select 
case 
when Age < 25 then 'Youth'
when Age between 25 and 40 then 'Young Adults'
when Age between 41 and 60 then 'Middle Aged'
else 'Senior Citizens'
end as Age_Group,
count(*) as total_Customers
from marketing_dataset
group by case
when Age < 25 then 'Youth'
when Age between 25 and 40 then 'Young Adults'
when Age between 41 and 60 then 'Middle Aged'
else 'Senior Citizens'
end
order by Total_Customers desc;

--segmentation by balance range
select 
case
when Balance <0 then 'Negative Balance'
when Balance between 0 and 20000 then 'Low Balance'
when Balance between 20001 and 60000 then 'Medium Balance'
else 'High Balance'
end as Balance_Group,
count(*) as Total_Customers
from marketing_dataset
group by case 
when Balance <0 then 'Negative Balance'
when Balance between 0 and 20000 then 'Low Balance'
when Balance between 20001 and 60000 then 'Medium Balance'
else 'High Balance'
end
order by Total_Customers

--Segmentation by job category
select Job, count(*) as Total_Customers
from marketing_dataset
group by Job
order by Total_Customers desc;

--segmentation by Marital Status
select Marital, count(*) as Total_Customers
from marketing_dataset
group by Marital
order by total_Customers desc;

--Campaign effectiveness
--Overall Campaign Analysis
select count(*) as Total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
sum(case when Outcome = 'failure' then 1 else 0 end) as Failure_Responses,
sum(case when Outcome = 'unknown' then 1 else 0 end) as Unknown_Responses
from marketing_dataset

--Overall campaign success rate
select count(*) as Total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate
from marketing_dataset

--campaign effectiveness by Contact channel
select 
count(*) as total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate
from marketing_dataset
group by Contact
order by Campaign_Success_Rate desc;

--effectiveness by Job Segment
select 
count(*) as total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate
from marketing_dataset
group by Contact
order by Campaign_Success_Rate desc;

--Effectiveness by Marital status
select 
count(*) as total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate
from marketing_dataset
group by Marital
order by Campaign_Success_Rate desc;

--Effectiveness by  Education
select 
count(*) as total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate
from marketing_dataset
group by Education
order by Campaign_Success_Rate desc;

--effectiveness by Balance Group
select 
case
when Balance <0 then 'Negative Balance'
when Balance between 0 and 20000 then 'Low Balance'
when Balance between 20001 and 60000 then 'Medium Balance'
else 'High Balance'
end as Balance_Group,
count(*) as Total_Customers,
sum(case when Outcome = 'success' then 1 else 0 end) as Successfull_Responses,
round(((sum(case when Outcome = 'success' then 1 else 0 end) * 100 ) / count(*)),2) as Campaign_Success_Rate 
from marketing_dataset
group by Balance_Group
order by Campaign_Success_Rate desc;

--Churn Prediction
--Add churn flag
select *,
case
when Outcome = 'success' then 0
else 1 
end as churn_Flag
from marketing_dataset;

--Overall churn rate
select 
count(*) as total_Customers,
sum(case when Outcome != 'success' then 1 else 0 end ) as Churned_Customers,
round(((sum(case when Outcome != 'success' then 1 else 0 end ) * 100 ) / count(*)),2) as Churn_Rate
from marketing_dataset 

--Churn rate by marital status
select Marital,
count(*) as Total_Customers,
sum(case when Outcome != 'success' then 1 else 0 end ) as Churned_Customers,
round(((sum(case when Outcome != 'success' then 1 else 0 end ) * 100 ) / count(*)),2) as Churn_Rate
from marketing_dataset 
group by Marital
order by Total_Customers desc;

--Churn rate by Job
select Job,
count(*) as Total_Customers,
sum(case when Outcome != 'success' then 1 else 0 end ) as Churned_Customers,
round(((sum(case when Outcome != 'success' then 1 else 0 end ) * 100 ) / count(*)),2) as Churn_Rate
from marketing_dataset 
group by Job
order by Total_Customers desc;

--Churn by balance group
select 
case
when Balance <0 then 'Negative Balance'
when Balance between 0 and 20000 then 'Low Balance'
when Balance between 20001 and 60000 then 'Medium Balance'
else 'High Balance'
end as Balance_Group,
count(*) as Total_Customers,
sum(case when Outcome != 'success' then 1 else 0 end ) as Churned_Customers,
round(((sum(case when Outcome != 'success' then 1 else 0 end ) * 100 ) / count(*)),2) as Churn_Rate
from marketing_dataset 
group by Balance_Group
order by Total_Customers desc;

--churn by Education, loan, housing
select Education,Housing, Loan,
count(*) as Total_Customers,
sum(case when Outcome != 'success' then 1 else 0 end ) as Churned_Customers,
round(((sum(case when Outcome != 'success' then 1 else 0 end ) * 100 ) / count(*)),2) as Churn_Rate
from marketing_dataset 
group by education,housing,Loan
order by Total_Customers desc;