# -*- coding: utf-8 -*-
"""
Created on Sun Jul  9 11:57:01 2023
Lab question 6 sample code

@author: jlowh
"""
#import pymongo
import pymongo

"""
Exercise 1
Create a mongo_db connection with pymongo to your database
"""
# create your connection string
connect_string = "mongodb+srv://suesusman:5VnllTXksmuqmKJe@cluster0.no2nrro.mongodb.net/?retryWrites=true&w=majority"

client = pymongo.MongoClient(connect_string)
"""


Exercise 2
Using your client created from exercise 1, connect to a new database, homework6. 
Once you have connected to the database set your collection to a new collection, students. 
https://pymongo.readthedocs.io/en/stable/tutorial.html --> getting database and getting collection
"""
db = client["homework"]
collection = db['students']
"""


Exercise 3
I have created a list of student data containing documents that you will need to insert into MongoDB. 
Using insert_many, insert the list of documents into the students collection. 
"""
student_data = [
    
    {"instructor":"Martin",
     "class":"Chemistry",
     "max_students":25,
     "term":"SP2",
     "students":["Bob Mackey","George Straight","Bill Cowher","Stanley Kubrick",'Martin Sheen',"Charlize Theron"]},
    {"instructor":"Lowhorn",
     "class":"Big Data",
     "max_students":10,
     "term":"SU1",
     "students":["Charles Barkely","Charlie Sheen","Tina Turner","Paul Walker",'Dwayne Johnson',"Courtney Cox", "Margot Robbie"]},
    {"instructor":"Carlin",
     "class":"Discrete Math",
     "max_students":25,
     "term":"SP2",
     "students":["Tim Couch","George Straight","Michael Douglas","Peyton Manning",'Wade Boggs',"Doc Rivers","Drew Bledsoe","Ray Bourque"]},
    {"instructor":"Lowhorn",
     "class":"Programming for DS",
     "max_students":25,
     "term":"SP2",
     "students":["Roger Clemens","Ray Allen","Marcus Smart","Kevin Garnett",'Mo Vaughn',"Uma Thurman","Conan O'Brien","Mark Wahlberg"]},
    ]

result = collection.insert_many(student_data)
"""


Exercise 4
What MongoDB type do Python lists get converted to? 
Submit a screen shot of your collection in MongoDB with this python file. 
"""
# array

"""


Exercise 5
George Straight accidentally registered for two courses in the SP2 Session. 
Using a pymongo.update(), remove him from Carlin's class
Note: Your key is instructor. 
Use the $pull method to extract the element from the array. 
https://www.geeksforgeeks.org/python-mongodb-update_one/
https://www.mongodb.com/docs/manual/reference/operator/update/pull/

"""
import pymongo

# Assuming you've already established a connection to your MongoDB
client = pymongo.MongoClient(connect_string)

db = client["homework"]
collection = db['students']

# Define the query
query = {"term": "SP2", "instructor": "Carlin", "students": "George Straight"}

# Update operation using $pull to remove George Strait from Carlin's class
update_query = {"$pull":{"students": "George Straight"}}

# Perform the update
result = collection.update_one(query, update_query)

# Check the result
if result.modified_count > 0:
    print("George Straight removed from Carlin's class in SP2 Term")
else:
    print("No changes made. George Straight might not be enrolled in Carlin's class in SP2 Term")
"""


Exercise 6
A new student has signed up for all three SP2 sessions, his name is Tom Brady. 
Update the SP2 classes by inserting the student Tom Brady into the students object. 
Note: Many not one. Push not pull. 
"""
# Update query for all SP2 sessions
query = {"term": "SP2"}

# Update operation using $push to insert Tom Brady into the students object
update_query = {"$push": {"students": "Tom Brady"}}

# Perform the update for all documents matching the query
result = collection.update_many(query, update_query)

# Check the result
if result.modified_count > 0:
    print("Tom Brady inserted into the students object for all SP2 sessions")
else:
    print("No changes made. No documents matched the criteria for SP2 sessions")
Exercise 7
The college has decided that Chemistry was not a good fit for the data science program. Delete it from the collection. 
https://www.geeksforgeeks.org/python-mongodb-delete_one/
"

"""


Exercise 7
The college has decided that Chemistry was not a good fit for the data science program. Delete it from the collection. 
https://www.geeksforgeeks.org/python-mongodb-delete_one/
"""
# Define the query to find the document for the "Chemistry" course
query = {"class": "Chemistry"}

# Delete the document representing the "Chemistry" course
result = collection.delete_one(query)

# Check the result of the deletion
if result.deleted_count > 0:
    print("Entry for Chemistry deleted successfully")
else:
    print("No document found for Chemistry course")
"""


Exercise 8
Using find, print all of the documents to the console. This should be a query against the MongoDB database.
"""
# Retrieve all documents from the collection
cursor = collection.find()

# Print all documents to the console
for document in cursor:
    print(document)

"""


Exercise 9
Instead of using the default hash _id, what would you recommend as a unique ID for each document?
"""
# There are several options if we want to use a unique ID for each document instead of the default hash _id:

# Custom Generated Unique ID: We can generate our own unique IDs using a specific format or algorithm. This can be a combination of different fields or properties from the document, such as a timestamp, a random number, or a specific identifier. Creating unique IDs based on our document's attributes, we can ensure uniqueness while also providing meaningful information about the document itself.

# UUID (Universally Unique Identifier): Another option is to use a UUID, which is a 128-bit value that guarantees uniqueness across all documents in our MongoDB collection. UUIDs are generated using a combination of timestamp, machine ID, and random numbers. They can be generated on the client-side or server-side and provide a globally unique identifier for each document.

# Sequential Number: If we require a monotonically increasing unique ID, we can use a sequential number. This can be achieved by maintaining a separate counter collection or using an atomic operation like findAndModify to increment a counter value for each new document. By assigning the incremented value as the unique ID, we can ensure a continuous sequence of IDs.

# External Unique ID: If we have an external system that generates unique IDs, we can use those IDs as the unique identifier for our MongoDB documents. This can be useful when integrating MongoDB with other systems or when we want to maintain consistency across different databases.

# References:
    Learn more:

# What Is Objectid in Mongodb and How to Generate It Manually: https://www.knowledgehut.com/blog/web-development/objectid-in-mongodb

# Generating Globally Unique Identifiers for Use with MongoDB | MongoDB Blog: https://www.mongodb.com/blog/post/generating-globally-unique-identifiers-for-use-with-mongodb

# javascript - How to generate unique id for each entry in mongoDB? - Stack Overflow: https://stackoverflow.com/questions/70928407/how-to-generate-unique-id-for-each-entry-in-mongodb
"""


Exercise 10
Drop the students collection from the database AND close your client.
"""
# Drop the "students" collection
db["students"].drop()

# Close the MongoDB client connection
client.close()
"""
