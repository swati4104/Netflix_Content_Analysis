create database netflix_project;
use netflix_project;

select count(*) from netflix_titles;

select * from netflix_titles
where director is null or country is null or date_added is null;

select show_id, count(*)
from netflix_titles 
group by show_id
having count(*) >1;

create table netflix_clean as 
select distinct * from netflix_titles;
select * from netflix_clean;

update netflix_clean 
set  country = "Unknown"
where country is null;
set sql_safe_updates = 0;

delete from netflix_clean
where date_added is null;

alter table netflix_clean
add column date_added_new date;

update netflix_clean
set date_added_new = str_to_date(date_added , '%M %d, %Y');

alter table netflix_clean
drop column date_added;

alter table netflix_clean
change date_added_new date_added date;

alter table netflix_clean
add column year_added int;

update netflix_clean
set year_added = year(date_added);

alter table netflix_clean
add column month_added varchar(20);

update netflix_clean
set month_added = month(date_added);
