# DWBI-Project
DWBI Project NCI college


TOURISM
Data Warehouse and Business Intelligence Project 
This project will provide insight to Tourism industry, different data sources used for purpose of generating knowledge in respect of Tourism as my subject with the help of different tools.
Data Sources and Initial Cleaning 
   
Technologies
    

Business Analysis

Table of Contents
Introduction	3
Objective	3
Report consists of following parameters given below:	4
Methodology	4
Data Warehouse-Architecture	5
ETL	6
Drill Down Approach Snapshots	6
Date Drill Down	6
Geographical Drill Down	7
Dimensional/Data Modelling	7
Four Step of Data Modelling used in this project:	8
Data Modelling	8
Star Schema Design	9
Overview of Extract Transform and Load	10
Extracting:	10
Transformation:	12
Loading Data into Dimensions and Fact:	13
Fully Automated Control Flow:	13
Data Flow for Fact Table:	13
OLAP CUBE	14

Introduction

Objective 

Tourism Industry is growing at exponential rate so is the data increasing with tourism industry, tourism industry effecting both people and economy of country as whole, so in this project of Data Warehouse tried to fetch out some useful knowledge from data available on internet using some datasets, web scraping and using API’s in general.

Data warehouse project is project which give insight or confidence in decision making with relevant all-round information present with Company/Industry. It is an optimized version of operational database provide only relevant information for and also provide fast access to Data, Data Warehouse is subject oriented, Integrated, Time-variant, Non-Volatile Platform 

This report will cover architecture used and overall implementation approach followed for this exhaustive data warehouse project. This Project will Analyse key relationship Hotels their category and reviews. Project will also demonstrate about approach and platform used to deliver this project.
Report consists of following parameters given below: 

1.	Methodologies and Architecture used to build Data Warehouse.
2.	Data Modelling – Properly documenting the schema, usage of Datasets and Drill down approach usage in the model.
3.	Extract, Transform and Load(ETL) – Information about complexity of ETL, usage of Emerging Technologies in ETL, Automated ETL, describing methodologies used for ETL.
4.	Business Intelligence – Number of Business Queries will be explained in this document with methodologies used and how all datasets have been used in the process of building, critical evaluation of Business Queries using appropriate academics.

Methodology

Two methodologies are famous one is Bill Inmon and Other is Ralph Kimball, For this project Ralph Kimball methodologies was used because it suits the requirement of the this small scale project , here I will be discussing several comparison between the two which made me choose Ralph Kimball Approach , one of the main reason behind is Bill Inmon is suitable for large enterprise with Big Budget, Larger Time Scale, Corporate Environment, Changeable Sources with Top Down Approach and Relational 3NF
But I choose for Ralph Kimball because its suitability to Small Scale Projects, Small Business Area, User based, small budget with Bottom-up approach through informative bus architecture, Multi-Dimensional and Structure which can be easily understood by actual user.

My requirement for this project being minimum with not stable sources being used, easy to understand architecture and modelling to create database with perspective to user in mind, can be easily understood by the user, Star Schema and Snowflakes Schema structure are famous in Ralph Kimball approach, ill be using Star Schema because tables granularity is same for all the tables used in the implementation of Data Warehouse.

Data Warehouse-Architecture

Architecture used is of Ralph Kimball Architecture which can be explained by using diagram given below: -

Architecture of Data Warehouse consists of three-layer Data Source Layer, Operational Data Store Layer, Data Warehouse Layer.
1.	Data Sources Layer: Different Data Sources are used for building a Data Warehouse like relational and non-relational databases, structured or semi structured data sources, legacy flat files consist of historical data, OLTP operational Data sources consists of small business events and data which can also be used for building up of data warehouse.
Different Data Sources used in the project are: - 
•	Country – Geonames
http://www.geonames.org/countries/
•	Hotels – Github
https://github.com/lucasmonteiro001/free-world-hotel-database/blob/master/hotels.csv.zip
•	Sentimental Europe Data: Twitter 
https://developer.twitter.com/
•	Hotel Reviews Data- Kaggle
https://www.kaggle.com/jiashenliu/515k-hotel-reviews-data-in-europe

2.	Operational Data Store Layer: also called Data Staging area where all transformation and cleaning of data done to make it suitable for usage of Data warehouse Schema, this is place where all operations on data done, it will be discussed in detail later in this Document.
3.	Data warehouse: warehouse keep all records of historical data after proper transformation and integration which can be accessed by users using different analytical tools like OLAP to be processed into cube and using which analysis done by users.
ETL – Extract-transform and Load tools are for purpose of cleaning and transforming data and making it suitable for schema. ETL is done on data sources coming from outside and make it adaptable for Schema, ETL is done for finding duplicates, errors and inconsistency in data. SSIS tool is used for ETL process and deploying OLAP Cube.
	SQL Server 2017 used as database for storing and retrieving tables as required: -
Database engine to store fact and Dimensions in Database and Analysis Services is used to store processed Dimensions and Cube.

Drill Down Approach Snapshots

Date Drill Down

Geographical Drill Down

Dimensional/Data Modelling

So, for this project I used bottom up Approach of Ralph Kimball, according to Kimball Approach we can have either start or snowflake schema which can have one or more fact tables and some dimension tables, fact will give you all measures whereas dimensions contains information, dimensions contains a primary which is used by fact table as foreign key.

Four Step of Data Modelling used in this project:

Define Business Process: - Business process used for this project is to provide effectiveness in work of hotels and to find in advance about the popularity of Hotel if going down, how many positive and negative words are generating on social media, hotel management to daily do daily analysis of review on social networking websites and according change the working style and improve in lacking area. Main motive of this analysis is to analyses social media data on daily basis comparing it with historical reviews and improve as required.
Today service Sector like hotel require to be active in terms of customer relationship and satisfaction of customer as whole. So, it is required to be efficient in terms of providing best services as whole and analysing the services given on time using reviews of people on social media or any data available with Hotel Management. So, I tried to provide a general Review Analysis Engine which can be used by all hotels in general to analyse their progress on daily basis.
Define grain of the Data Warehouse: Analysis will be done on daily basis, so it will provide us information on daily review and analysis can be done on granular level and take effective measure instantly. 
	Create Dimensions:  Identify the attributes from Data Tables and create separate dimension table for each of them.
Fact table: After creating facts create a fact table with all measures left, these measures further be used for purpose of analysis.

Data Modelling

Fact Table
Will store most granular measurement of business process, in this project review we are going to analysis will be of daily basis.
 
Dimension Table
Will provide information about who, what, where and whop about business process, in this project we are using Four-dimension tables (Hotel, Tweet, Geography, Date).
Date Dimension will be a Role-Playing Dimension used for many dates.
Degenerated Dimensions also used with no Dimension Table of their own like Hotel Category Table, City Table, Country Table, Continent Table.
SCD 2 Dimension used to add new row to dimension tables if any.
Hotel Dimension
 
Geography Dimension
 
Primary Key
Used by dimension table to uniquely identify the row in the table. Hotel_id, Geo_id are primary keys for dimension tables shown in above tables.
Foreign Key
Foreign Key is a Column in Fact Table to reference another to create a Join between Fact and Dimension Table.
Fact Table with Foreign Keys like Hotel_id, Geo_td, Tweet_id,Datekey
 

Auditing and Lineage
	Auditing and lineage used to store logs into database for purpose of auditing who made update, when it’s done, how many rows are updated.

Star Schema Design

Star Schema has a single table for each dimension, each table contains all attributes for that dimension, particularly a demoralized form. 
 
Star Join in Dimensional modelling is used to join both fact and Dimension tables, in start join facts are contained in fact table like average review score, total reviews score etc and information in Dimension table like geography dimension, time dimension, Tweet, Hotel dimension with category of hotel like Star of hotel.
Star join use both fact and dimension tables to answer any query related to dimension and facts and up to most granular level of join.
For example: 
1.	To know on which date maximum no. of negative reviews received by and hotel.
2.	Is there any relationship between Star category of hotel with no. of reviews received?
3.	Is hotel gaining or loosing in terms of popularity with number of tweets being negative and positive and comparing it with Historical reviews.

Overview of Extract Transform and Load
	ETL is process of Extracting Data from sources and Loading it into Data Warehouse.
	Extracting: 
	Sources which are used in Data Warehouse, Sources can be any type Structured, Semi structured, Unstructured.  In this project different sources of Data being used like 
Structured Data (CSV Files) downloaded from Websites, some data was scraped from website and some unstructured data is Extracted from twitter using R Code which then converted to csv.
Two Types of Extractions methods used: 
Logical:
I.	Full Extraction is extraction of data one time and no timestamps required in this extraction.
II.	Incremental Extraction is used when only changed data being extracted.
Physical:
I.	online Extraction is done directly from source.
II.	Offline Extraction is done from Flat File, Dump File.

In this project online Extraction done through R Code like Twitter Analysis and Web Scraping from Geonames using R Code. offline Extraction of Datasets Done using R Code, Some of Screenshots for extractions used in this project are given below: 
•	R Code used:
•	Some CSV also downloaded from websites like Kaggle and GitHub.
•	Data extracted is stored in SQL Server 2017 Database – Dimension Database for Dimensions and Facts, Stage Dimension is used as staging Area.
•	Some of the Screenshot followed for extractions given below:
Connection Manager for creating Connections connection with Flat files and Other Sources.
  

Transformation:
	Is most complex in terms of processing time, here we do simple data conversion to complex data aggregation, scrubbing.
	Number of transformations techniques are present in SQL Server Integration Services, but for this project tried to use minimum transformations as required for the project. Some Transformation done before staging Area and some before loading Data into dimensions and fact table.
	Different Transformations used are:
•	Multistage Data transfer.
•	Pipelined Transfer.
•	Create Table using SQL.
•	Use of Merge, Sort, Multicast, Aggregate, Conditional Split.
•	Multistage insert of Data.

	Some of the transformations used are given below:
 	  

Loading Data into Dimensions and Fact:
•	Using SQL, used SQL code to Populate Date Dimension (Code Taken online)
•	Using pipelined multistage insert of Data.
•	SCD 2 Dimensioning and loading of Data into dimension Tables.
Fully Automated Control Flow:

Data Flow for Fact Table:

OLAP CUBE

View of Cube in SQL Server Analysis Service and Analysis Server in SQL Server Management Studio
  
Attribute Relationships for Geography Dimension: 

Attribute Relationships for Date Dimension:

OLAP Cube Star Schema

Business Intelligence

Here in this project got number of opportunity to slice and Dice Cube and find answer to different Business queries , but in this project ill be representing four main Business Queries I found most attractive and provide insight in terms of choosing hotel before booking on basis of daily and historical data present for analysis.
Business Query 1:
Business Query 2:
Business Query 3:
Business Query 4:

Analysis of Project in general:

