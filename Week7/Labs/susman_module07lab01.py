# -*- coding: utf-8 -*-
"""
Created on Sat Jul 22 21:26:37 2023

@author: Lowhorn
"""

#import pymongo
import pymongo

"""
Exercise 1
Create a mongo_db connection with pymongo to your database
https://pymongo.readthedocs.io/en/stable/examples/authentication.html

For the homework we will be using the sample_restaurants.restaurants collection. 

Using find(), write a find query to extract the Italian restaurants in Manhattan to a Python list. 
Use len() to count the number of restaurants located in Manhattan. 

***Note*** All MongoDB functions and fields MUST be in quotes inside of the find() method. Ex $and should be "$and".

https://www.w3schools.com/python/python_mongodb_find.asp

"""

# create your connection string
connect_string = "mongodb+srv://suesusman:5VnllTXksmuqmKJe@cluster0.no2nrro.mongodb.net/?retryWrites=true&w=majority"

#create a connection to your Atlas cluster
client = pymongo.MongoClient(connect_string)

#connect to the sample_restaraunts database
restaurants_db = client.sample_restaurants

#establish a connection to the restarants collection
rest_coll = restaurants_db["restaurants"]

# Define the query
query = {
    "$and": [
        {"cuisine": "Italian"},
        {"borough": "Manhattan"}
    ]
}


# Execute the query and store the result in a list
italian_restaurants = list(rest_coll.find(query))


# Count the number of Italian restaurants in Manhattan
count = len(italian_restaurants)


# Print the result
print(f"Number of Italian restaurants in Manhattan: {count}")
  

"""
Exercise 2
Using find, determine how many Japanese and Italian restaurants have an A rating in Queens.
"""

import pymongo


# Define the query
query = {
    "$and": [
        {"$or": [{"cuisine": "Japanese"}, {"cuisine": "Italian"}]},
        {"borough": "Queens"},
        {"grade": "A"}
    ]
}


# Execute the query and count the number of matching restaurants
count = rest_coll.count_documents(query)

# Print the result
print(f"Number of Japanese and Italian restaurants with an A rating in Queens: {count}")

"""
Exercise 3
The following MongoDB aggregation query is missing an aggregation expression that will calculate the BSON size of the documents. 
A list of these can be found at the end of this week's notes. Identify the missing aggregation expression.
Print the 10 document ids and sizes that have the highest BSON size. 
"""

res = rest_coll.aggregate([
    { "$addFields": {
        "bsonsize": { "$bsonSize": "$$ROOT" }
    }},
    { "$sort": { "bsonsize": -1 }},
    { "$limit": 5 },  # You can replace '5' with the desired limit value
    { "$project": {
        "_id": 1,  # Assuming you want to include '_id' field
        "bsonsize": 1
    }}
])


"""
Exercise 4
Find all of the restaurants that have NOT had an 'A', 'B', and 'Not Yet Graded' rating. How many restaurants is this?
"""

import pymongo

# Define the query
query = {
    "grade": {
        "$nin": ["A", "B", "Not Yet Graded"]
    }
}


# Execute the query and count the number of restaurants
count = rest_coll.count_documents(query)

# Print the result
print(f"Number of restaurants without an 'A', 'B', or 'Not Yet Graded' rating: {count}")

    