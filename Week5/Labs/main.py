#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec 29 16:31:34 2023

@author: sue_susman
"""

from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Welcome to the PyMongo tutorial!"}
