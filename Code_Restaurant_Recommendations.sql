-- CREATE DATABASE RESTAURANT_RECOMMENDATIONS;

-- USE RESTAURANT_RECOMMENDATIONS;

-- 1)  Group all users according to Age Group and count Age Count and Name Age Group as
--     18 - 28 Youth
--     29 - 38 Young Adult
--     39 - 48 Adult
--     Other

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 28 THEN 'Youth' 
        WHEN age BETWEEN 29 AND 38 THEN 'Young Adult' 
        WHEN age BETWEEN 39 AND 48 THEN 'Adult'
        ELSE 'Other'
    END AS Age_Group,
    COUNT(*) AS Age_Count
FROM USERS
GROUP BY Age_Group
ORDER BY Age_Count;

-- 2) List 10 Users whose Preferred_cuisine as Indian

SELECT U.*,R.CUISINE
FROM USERS AS U INNER JOIN
RESTAURANTS AS R ON U.PREFERRED_CUISINE_ID = R.CUISINE_ID
WHERE R.CUISINE = 'Indian'
LIMIT 10;

-- 3) List Gender wise User count

SELECT GENDER, COUNT(USER_ID) AS USER_COUNT
FROM USERS
GROUP BY GENDER;

-- 4) List all users who have Interaction_Type 'like'

SELECT *
FROM INTERACTIONS
WHERE INTERACTION_TYPE = 'like'
ORDER BY USER_ID;

-- 5) List all users who visited Restaurant on 1-Jan-2024

SELECT *
FROM INTERACTIONS
WHERE TIMESTAMP = '2024-01-01';

-- 6) List all Restaurant whose name starts with 'B'

SELECT *
FROM RESTAURANTS
WHERE RESTAURANT_NAME LIKE 'B%';

-- 7) List cuisine wise restaurant count

SELECT DISTINCT CUISINE, COUNT(RESTAURANT_ID) AS NO_OF_RESTAURANT
FROM RESTAURANTS
GROUP BY CUISINE;

-- 8) List all restaurant whose rating is greater than 4

SELECT *
FROM RESTAURANTS
WHERE RATING > 4;

-- 9) Count No of Restaurant based on Price_Rating

SELECT DISTINCT PRICE_RANGE, COUNT(RESTAURANT_ID) AS NO_OF_RESTAURANT
FROM RESTAURANTS
GROUP BY PRICE_RANGE
ORDER BY PRICE_RANGE;

-- 10) List Restaurant_Id, Restaurant_Name, Cuisine, Rating, Price_Range, Location where location is Los Angeles

SELECT Restaurant_Id, Restaurant_Name, Cuisine, Rating, Price_Range, Location
FROM RESTAURANTS
WHERE LOCATION = 'Los Angeles';

-- 11) Count restaurant based on Location

SELECT LOCATION, COUNT(RESTAURANT_ID) AS NO_OF_RESTAURANT
FROM RESTAURANTS
GROUP BY LOCATION
ORDER BY NO_OF_RESTAURANT;

-- 12) List all restaurant name where weather is Sunny and time of day is Night

SELECT R.RESTAURANT_ID, R.RESTAURANT_NAME, C.TIME_OF_DAY, C.WEATHER
FROM RESTAURANTS AS R INNER JOIN
CONTEXT AS C ON R.RESTAURANT_ID = C.RESTAURANT_ID
WHERE TIME_OF_DAY = 'Night' AND WEATHER = 'Sunny';

-- 13) List User 314 User_Id, Age, Gender, Restaurant_Id, Interaction_Type, 
-- Timestamp, Restaurant_Name, Cuisine, Rating, Price_Range, Location, Interaction_Id, Time of day, Weather

SELECT U.User_Id, U.Age, U.Gender, I.Restaurant_Id,
I.Interaction_Type, I.Timestamp, R.Restaurant_Name, R.Cuisine,
R.Rating, R.Price_Range, R.Location, C.Interaction_Id, C.Time_Of_Day, C.Weather
FROM USERS AS U INNER JOIN
INTERACTIONS AS I ON U.USER_ID = I.USER_ID 
INNER JOIN RESTAURANTS AS R ON R.RESTAURANT_ID = I.RESTAURANT_ID
INNER JOIN CONTEXT AS C ON C.RESTAURANT_ID = R.RESTAURANT_ID
WHERE U.USER_ID = 314
ORDER BY I.TIMESTAMP;

-- 14) List User 551 date wise all restaurant details

SELECT R.*, I.INTERACTION_TYPE, I.TIMESTAMP
FROM RESTAURANTS AS R INNER JOIN
INTERACTIONS AS I ON I.RESTAURANT_ID = R.RESTAURANT_ID
WHERE I.USER_ID = 551
ORDER BY I.TIMESTAMP;

-- 15) Which restaurant has most user

SELECT I.RESTAURANT_ID, COUNT(I.USER_ID) AS NO_OF_USER, 
R.Restaurant_Name, R.Cuisine, R.Rating, R.Price_Range, R.Location
FROM INTERACTIONS AS I INNER JOIN
RESTAURANTS AS R ON I.RESTAURANT_ID = R.RESTAURANT_ID
GROUP BY I.RESTAURANT_ID
ORDER BY NO_OF_USER DESC
LIMIT 1;
