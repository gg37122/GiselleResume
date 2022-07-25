--Author-Giselle Gonzalez
--Description: the goal of this was to find what routes are most popular with different user types.

SELECT

  usertype, --this lets the database know that we want the 'usertype' column or field
  CONCAT(start_station_name, "to", end_station_name) AS route,--this created a new column called route that combined the data from the two columns
  COUNT(*) AS num_trips,--this counted up the number of rows in the data we selected to tell us the number of trips
  ROUND(AVG(CAST(tripduration as int64)/60),2) AS duration--the round function was included to round up because the exact average was not needed. the cast function was used to get the integer form of the trip duration.the 64 in int64 is used because Bigquery stores numbers in a 64 bit memory system. the 60 is because there are 60 seconds in a minute. the 2 is for the number of decimal places wanted. all of this gets the average trip duration for each route

FROM

  bigquery-public-data.new_york.citibike_trips

GROUP BY

  start_station_name, end_station_name, usertype--because the select clause uses the count and average functions, the group by function is needed to group together summary rows

ORDER BY

  num_trips DESC--this organzies the data by the number of trips in descending order to help achieve this query's goal of showing what routes are most popular

LIMIT

 10--this will return the top 10
