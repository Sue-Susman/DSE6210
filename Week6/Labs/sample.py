#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan  8 17:30:10 2024

@author: sue_susman
"""

import pymongo

# create your connection string
connect_string = "mongodb+srv://suesusman:5VnllTXksmuqmKJe@cluster0.no2nrro.mongodb.net/?retryWrites=true&w=majority"

client = pymongo.MongoClient(connect_string)

db = client["test"]
test_collection = db['test']

test_record = {'_id':1,
               'name':'John Adams', 
               'address': '123 Main Street'}

test_collection.insert_one(test_record)

test_record2 = {'_id':2,
                'fruit':'carrot',
                'vitamin':'beta-carrotine'}

test_collection.insert_one(test_record2)

test_record3 = [{'_id':3,
                 'name':'Tom Brady'},
                {'_id':4,
                 'name':'George Pickens'}
                
    ]

test_collection.insert_many(test_record3)


find_arg = {"fruit": "carrot"}
change_arg = {'$set':{'vitamin':'vitamin A'}}


test_collection.update_one(find_arg,change_arg)

test_collection.drop()