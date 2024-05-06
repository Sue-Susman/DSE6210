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

For the homework we will be using the sample_mflix.movies collection. 

What is the title of the movie with the highest IMDB rating?

***Note*** match, sort, limit, project.
collection.aggregate(query) is the syntax for aggregation pipelines in Python. 

https://pymongo.readthedocs.io/en/stable/examples/aggregation.html
"""

# create your connection string
connect_string = "mongodb+srv://suesusman:5VnllTXksmuqmKJe@cluster0.no2nrro.mongodb.net/?retryWrites=true&w=majority"

#create a connection to your Atlas cluster
client = pymongo.MongoClient(connect_string)

#connect to the sample_mflix database
movies_db = client.sample_mflix

#establish a connection to the movies collection
mov_coll = movies_db["movies"]

pipeline = [
    {"$sort": {"imdb.rating": -1}},
    {"$limit": 1},
    {"$project": {"_id": 0, "title": 1}}
]

result = mov_coll.aggregate(pipeline)
for doc in result:
    print(doc["title"])


"""
Exercise 2
Which year had the most titles released? 
***Note*** group, sort, limit

"""
pipeline = [
    {"$group": {"_id": "$year", "count": {"$sum": 1}}},
    {"$sort": {"count": -1}},
    {"$limit": 1},
    {"$project": {"_id": 0, "year": "$_id"}}
]

result = mov_coll.aggregate(pipeline)
for doc in result:
    print(doc["year"])

  
"""
Exercise 3
What are the four directors with the most titles accredited to them? 
***Note*** project, unwind, group, sort, limit

"""
pipeline = [
    {"$unwind": "$directors"},
    {"$group": {"_id": "$directors", "count": {"$sum": 1}}},
    {"$sort": {"count": -1}},
    {"$limit": 4},
    {"$project": {"_id": 0, "director": "$_id", "count": 1}}
]

result = mov_coll.aggregate(pipeline)
for doc in result:
    print(doc["director"], doc["count"])

  
"""
Exercise 4
Show the title and number of languages the movie was produced in for the following: Year:2013, genre:'Action'


"""
pipeline = [
    {"$match": {"year": 2013, "genre": "Action"}},
    {"$project": {"_id": 0, "title": 1, "num_languages": {"$size": "$languages"}}}
]

result = mov_coll.aggregate(pipeline)
for doc in result:
    print(doc["title"], doc["num_languages"])

