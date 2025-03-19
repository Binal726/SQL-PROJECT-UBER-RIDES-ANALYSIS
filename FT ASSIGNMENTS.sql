create database uber;

show databases;

use uber;

select * from uber1;
select * from  uber2;
select * from uber3;

#Basic Level:

#1.           What are & how many unique pickup locations are there in the dataset?

select distinct pickup_location from uber2;

#2.           What is the total number of rides in the dataset?

select count(ride_id) from uber2;

#3.           Calculate the average ride duration.

select avg(ride_duration) from uber2;

#4.           List the top 5 drivers based on their total earnings.

#select max(earnings) from uber3; #4999.99
#select max(earnings) from uber3 where earnings<4999.99; #4999.57
#select max(earnings) from uber3 where earnings<4999.57; #4998.2
#select max(earnings) from uber3 where earnings<4998.2; #4998.04
#select max(earnings) from uber3 where earnings<4998.04; #4997.86

select driver_name , sum(earnings) from uber3
group by driver_name
order by sum(earnings) desc 
limit 5;

#5.           Calculate the total number of rides for each payment method.
select distinct payment_method from uber2;

select count(ride_id) from uber2 where payment_method="Cash"; #24,929
select count(ride_id) from uber2 where payment_method="Credit Card"; #25,071

#6.           Retrieve rides with a fare amount greater than 20.

#select ride_id,fare_amount from uber2 where fare_amount>20;
select * from uber2 where fare_amount>20
order by fare_amount desc;

#7.           Identify the most common pickup location.--------------------------------------

select pickup_location from uber2
group by pickup_location 
order by count(*) desc
limit 1;

#8.           Calculate the average fare amount.

select avg(fare_amount) from uber2;

#9.           List the top 10 drivers with the highest average ratings.

select driver_name , avg(rating) from uber3
group by driver_name
order by avg(rating) desc 
limit 10;


#10.      Calculate the total earnings for all drivers.
select sum(earnings) from uber3;

select driver_name , sum(earnings) from uber3
group by driver_name
order by sum(earnings)desc ;

#11.      How many rides were paid using the "Cash" payment method?

select count(ride_id) from uber2 where payment_method="Cash";

#12.      Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.

select distinct(pickup_location),count(ride_id) ,avg(ride_distance) from uber2 where pickup_location ="Dhanbad";

#13.      Retrieve rides with a ride duration less than 10 minutes.

select ride_id , ride_duration from uber2 where ride_duration <10;

#14.      List the passengers who have taken the most number of rides.

select max(total_rides) from uber1;

select passenger_name,total_rides from uber1 where total_rides>=100;

#15.      Calculate the total number of rides for each driver in descending order.

select driver_name , count(total_rides) from uber3
group by driver_name 
order by count(total_rides) desc;

#16.      Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.

select distinct(pickup_location) , payment_method ,passenger_id  from uber2 where pickup_location ="Gandhinagar";

#17.      Calculate the average fare amount for rides with a ride distance greater than 10.

select ride_distance ,avg(fare_amount) from uber2 where ride_distance >10
group by ride_distance
order by avg(fare_amount) desc ;


#18.      List the drivers in descending order accordinh to their total number of rides.


select driver_name ,count(total_rides) from uber3
group by driver_name 
order by count(total_rides) desc;

select driver_name ,total_rides from uber3 
order by total_rides desc;

#19.      Calculate the percentage distribution of rides for each pickup location.

select pickup_location , count(distinct pickup_location)* 100 / count(*) from uber2 
group by pickup_location ;


#20.      Retrieve rides where both pickup and dropoff locations are the same.

select pickup_location , dropoff_location from uber2 where pickup_location = dropoff_location;











#Intermediate Level:     

                 

#1.           List the passengers who have taken rides from at least 300 different pickup locations.

select uber1.passenger_id , uber1.passenger_name , count(distinct uber2.pickup_location) from uber2
join uber1 on uber2.ride_id=uber1.passenger_id 
group by uber1.passenger_id  , uber1.passenger_name 
having count(distinct uber2.pickup_location) <=300;


#2.           Calculate the average fare amount for rides taken on weekdays.

-- select avg(fare_amount) from uber2
-- where WEEKDAY(ride_timestamp);
select avg(fare_amount) from uber2
where WEEKDAY(STR_TO_DATE(ride_timestamp, '%d-%m-%Y %H:%i')) BETWEEN 0 AND 4;

DESC uber2;


#3.           Identify the drivers who have taken rides with distances greater than 19.

select *from uber2;
select driver_id, ride_distance from uber2 where ride_distance >19.00;

#4.           Calculate the total earnings for drivers who have completed more than 100 rides.


select * from uber3;
select driver_id,driver_name,total_rides ,earnings from uber3 where total_rides >=100
order by earnings desc ;

#5.           Retrieve rides where the fare amount is less than the average fare amount.

select avg(fare_amount) from uber2; #2051.0678048

select ride_id ,fare_amount from uber2 where fare_amount < 2051.0678048
order by fare_amount desc;

select ride_id ,fare_amount
from uber2 where fare_amount < (select avg(fare_amount) from uber2);


#6.           Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.


SELECT uber3.driver_id, uber3.driver_name , AVG(uber3.rating)
FROM uber3
JOIN uber2 ON uber3.driver_id = uber2.driver_id
WHERE uber2.payment_method IN ('Credit Card', 'Cash')
GROUP BY uber3.driver_id, uber3.driver_name
HAVING COUNT(DISTINCT uber2.payment_method) = 2;


#7.           List the top 3 passengers with the highest total spending.

select passenger_name , max(total_spent) from uber1
group by passenger_name 
order by max(total_spent) desc 
limit 3;

#8.           Calculate the average fare amount for rides taken during different months of the year.
SELECT 
    MONTH(STR_TO_DATE(ride_timestamp, '%d-%m-%Y %H:%i')) AS ride_month,
    AVG(fare_amount) AS avg_fare
FROM uber2
GROUP BY ride_month
ORDER BY ride_month;


#9.           Identify the most common pair of pickup and dropoff locations

select pickup_location ,dropoff_location , count(*) from uber2
group by pickup_location ,dropoff_location 
order by count(*) desc
limit 1;

#10.      Calculate the total earnings for each driver and order them by earnings in descending order.

select driver_id,driver_name, sum(earnings) from uber3
group by driver_id ,driver_name 
order by sum(earnings) desc;


#11.      List the passengers who have taken rides on their signup date.


select uber1.passenger_name ,uber1.signup_date , uber2.ride_timestamp from uber1 
inner join uber2 on uber1.passenger_id=uber2.passenger_id 
where uber1.signup_date=uber2.ride_timestamp ;

#12.      Calculate the average earnings for each driver and order them by earnings in descending order.

select driver_id ,driver_name, avg(earnings) from uber3
group by driver_id , driver_name 
order by avg(earnings) desc;

#13.      Retrieve rides with distances less than the average ride distance.

select avg(ride_distance) from uber2; #10.4738194

select ride_distance from uber2 where ride_distance < (select avg(ride_distance)from uber2)

#14.      List the drivers who have completed the least number of rides.

select min(total_rides) from uber3;
select min(total_rides) from uber3 where total_rides <50;

#15.      Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.


select avg(fare_amount) from uber2;
select total_rides,passenger_id,passenger_name from uber1 where total_rides >=20;


select avg(uber2.fare_amount) from uber2 join (select passenger_id from uber2 group by passenger_id having count(ride_id)>=20 )
uber1 on uber2.passenger_id =uber1.passenger_id ;

#16.      Identify the pickup location with the highest average fare amount.

select avg(fare_amount) from uber2; #2051.0678048

select pickup_location, avg(fare_amount) from uber2 
group by pickup_location
order by avg(fare_amount) desc
limit 1;


#17.      Calculate the average rating of drivers who completed at least 100 rides.

select passenger_name , avg(rating) from uber1
where total_rides >=100
group by passenger_name ;

#18.      List the passengers who have taken rides from at least 5 different pickup locations.

select passenger_id, count(pickup_location) from uber2
group by passenger_id 
having count(pickup_location)>5;


#19.      Calculate the average fare amount for rides taken by passengers with ratings above 4.


select avg(uber2.fare_amount) from uber2 
join uber1 on uber2.passenger_id =uber1.passenger_id where uber1.rating >4;

#20.      Retrieve rides with the shortest ride duration in each pickup location.


select uber2.ride_id , uber2.pickup_location , uber2.dropoff_location ,uber2.ride_duration ,uber2.fare_amount from uber2
where uber2.ride_duration =(select min(uber2.ride_duration)from uber2
where uber2.pickup_location =uber2.pickup_location );











#Advanced Level:

#1.           List the drivers who have driven rides in all pickup locations.

select  driver_id , count(distinct pickup_location) from uber2 
group by driver_id
having count(distinct pickup_location) = 316;

#2.           Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.

select avg(fare_amount) from uber2
join uber1 on uber1.passenger_id =uber2.passenger_id where uber1.total_spent >300;

#3.           List the bottom 5 drivers based on their average earnings.

select driver_name, avg(earnings) from uber3
group by driver_name 
order by avg(earnings)
limit 5;

#4.           Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.

select passenger_id ,sum(fare_amount ) from uber2
where payment_method in ("Cash" , "Credit Card")
group  by passenger_id;

#5.           Retrieve rides where the fare amount is significantly above the average fare amount.

select *from uber2
where fare_amount > (select avg(fare_amount) from uber2) * 1.5;

#6.           List the drivers who have completed rides on the same day they joined.

#7.           Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.

#8.           Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.

#9.           Retrieve rides where the dropoff location is the same as the pickup location.

#10.           Calculate the average rating of drivers who have driven rides with varying pickup locations.


