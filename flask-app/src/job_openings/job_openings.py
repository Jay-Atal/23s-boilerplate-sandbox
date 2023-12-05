import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

job_openings = Blueprint('job_openings', __name__)

# Get all the products from the database
@job_openings.route('/job_openings', methods=['GET'])
def get_job_openings():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT JobID, CompanyPageID, Name, RoleDescription,Difficulty, GradeYearRequirement FROM Job_Openings')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@job_openings.route('/job_openings', methods=['POST'])
def add_new_job_opening():

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    company_page_id = the_data['CompanyPageId']
    job_id = random.randint(0,999999999)
    name = the_data['Name']
    role_description = the_data['RoleDescription']
    difficulty = the_data['Difficulty']
    grade_year_requirement = the_data['GradeYearRequirement']

    # Constructing the query
    query = 'insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values ('
    query += str(company_page_id) + ', '
    query += str(job_id) + ', "'
    query += name + '", "'
    query += role_description + '", "'
    query += difficulty + '", "'
    query += grade_year_requirement + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'


@job_openings.route('/job_openings/<jobID>', methods=['GET'])
def get_product_detail (jobID):

    query = 'SELECT CompanyPageID, JobID, Name, RoleDescription,Difficulty, GradeYearRequirement FROM Job_Openings WHERE JobID = ' + str(jobID)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)