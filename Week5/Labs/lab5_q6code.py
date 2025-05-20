# -*- coding: utf-8 -*-
"""
Created on Sun Jul  9 11:57:01 2023
Lab question 6 sample code

@author: jlowh
"""

import pymongo

from pymongo import MongoClient

# create your connection string
connect_string = "mongodb+srv://suesusman:5VnllTXksmuqmKJe@cluster0.no2nrro.mongodb.net/?retryWrites=true&w=majority"

client = MongoClient(
    "mongodb://suesusman:5VnllTXksmuqmKJe@ac-gqkxhba-shard-00-00.no2nrro.mongodb.net:27017/?ssl=false")

# create a connection to your Atlas cluster
client = pymongo.MongoClient(connect_string)

# connect to the sample_restaraunts database
restaurants_db = client.sample_restaurants

# establish a connection to the restarants collection
rest_coll = restaurants_db["restaurants"]

# find a document with the restaraunt name Nordic Delicacies
nordic = rest_coll.find_one({"name": "Nordic Delicacies"})

# find the type of the queried document
type(nordic)
