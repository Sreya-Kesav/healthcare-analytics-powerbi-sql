-- total patients
select count(*) as totalpatients
from patients

-- patients by gender

select count(patient_id) as pbygender, gender
from patients
group by gender;

--appointments by status

select* from appointments
create view statuscount as
select count(*) as statcnt, status
from appointments
group by status;

--revenue by payment method

select*from billing

select sum(round(amount,0)) as revenue , payment_method, count(*) as method_cnt
from billing
group by payment_method;

--patient and appointment deets

select p.patient_id, a.appointment_date
from patients p
join appointments a on p.patient_id = a.patient_id;

--doctor performance
create view doc_appointments as
select d.doctor_id,
count(*) as totalappointments
from doctors d
inner join appointments a on d.doctor_id = a.doctor_id
group by d.doctor_id

-- revenue by doctor
create view rev_by_doc as
select d.doctor_id, sum(round(b.amount,0)) as revenue
from doctors d
join appointments a on  d.doctor_id = a.doctor_id
join billing b on a.patient_id = b.patient_id
group by d.doctor_id;

--repeat patients

create view repeat_patients as,

with repeat_patient as
(select patient_id, count(*) as visits
from appointments
group by patient_id
)

select*
from repeat_patient
where visits>3;

-- Rank doctors
 select
 doctor_id, count(*) as appointments,
 rank() over( order by count(*) desc) as doctor_rank
 from appointments
 group by doctor_id;

 --running revenue
 create view running_revenue as
 select
 bill_date, amount,
 sum(amount) over (order by bill_date) as running_rev
 from billing;

 create view monthly_rev as
 select datename(month,bill_date) as month_name,
 sum(round(amount,1)) as revenue
 from billing
 group by datename(month,bill_date);

