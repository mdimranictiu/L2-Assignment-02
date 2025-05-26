# Assignment-02

## 1. What is PostgreSQL?

**উত্তর**
PostgreSQL একটা  ওপেন  সোর্স  অবজেক্ট  relational database ম্যানেজমেন্ট  সিস্টেম ।  এটা  SQL ব্যবহার  করে  ডেটা  সংরক্ষণ, পরিচালনা ও পুনরুদ্ধার করে| 
PostgreSQL-এর বৈশিষ্ট্যসমূহঃ 
- ১। এটি  ওপেন  সোর্স , যে কেউ  ব্যবহার  করতে  পারে 
- ২। এটি  relational database ও  অবজেক্ট  ওরিয়েন্টেড ফিচারও সাপোর্ট করে
- ৩। PostgreSQL  ACID  নীতিমালা  অনুসরণ  করে  যা ডেটার নিরাপত্তা ও নির্ভরযোগ্যতা নিশ্চিত করে
- ৪। PostgresSQL Windows, Linux, Mac সহ বিভিন্ন অপারেটিং সিস্টেমে সাপোর্ট  করে 
- ৫। এটা  JSON  ফরম্যাট  ডাটা সাপোর্ট করে 
- ৬। একাধিক ব্যবহারকারী একসাথে ডেটার সাথে কাজ করলেও এটি কোনো সমস্যা ছাড়াই পরিচালনা করতে পারে। 

## 2. What is the purpose of a database schema in PostgreSQL?

**উত্তর**
Database Schema একটা  সুসজ্জিত কাঠামো  যা টেবিল , ভিউ , ফাংশন, ইনডেক্স, ট্রিগার ইত্যাদি একটি নির্দিষ্ট গ্রুপে সাজিয়ে রাখে | 

Database Schema প্রধান উদ্দেশ্য গুলো : 
- ১। তথ্যকে সংগঠিতভাবে  সংরক্ষণ  করা |  সাধারণত  একটা  Database টেবিল , ফাংশন, ট্রিগার থাকে , schema
 ব্যবহার  করে  সেগুলোকে বিভিন্ন ভাগে ভাগ করে গুছিয়ে রাখে 
- ২।   naming conflict  এড়ানোর  জন্য
- ৩। অ্যাক্সেস কন্ট্রোল , ভিন্ন ভিন্ন ইউজার বা রোলকে নির্দিষ্ট স্কিমা অ্যাক্সেস দেওয়ার ব্যবস্থা করা  যায় | 
- ৪। maintanance করতে  সুবিধা  হয়  |

Database Schema-এর প্রধান উপাদানসমূহঃ 
- ১। Tables : এটা  ডেটা সংরক্ষণের স্থান (rows & columns ফরম্যাটে) 
- ২। Relations : foreign কী  মাধ্যমে 
- ৩। Indexes 
- ৪। View  
- ৫। Sequences , Function , Triggers  ইত্যাদি 

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
Primary Key হচ্ছে একটি ইউনিক শনাক্তকারী (unique identifier), যা একটি ডেটাবেজ টেবিলের প্রতিটি রেকর্ডকে (record) আলাদা করে চিহ্নিত করে। 

Primary  কী  -এর বৈশিষ্ট্যসমূহঃ 
- ১। ইউনিক  — প্রতিটি রেকর্ডের জন্য মান আলাদা হতে হবে।
- ২। Null - মান গ্রহণযোগ্য নয়, 
- ৩। ডুপ্লিকেট  হতে  পারবে  না 
- ৪।  প্রতিটি টেবিলে মাত্র একটি Primary Key থাকতে পারে।

উদাহরণঃ
```
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name  Varchar(100)  ,
);

```
Foreign Key একটি কলাম যা অন্য একটি টেবিলের Primary Key-এর সাথে সম্পর্ক স্থাপন করে।
Foreign  কী  -এর বৈশিষ্ট্যসমূহঃ 
- ১। এটা  সম্পর্ক  make করে দুইটা  টেবিলর মধ্যে 
- ২। এটা  মূলত রেফারেন্স করে অন্য টেবিলের ডেটা, 
- ৩। ডেটার অখণ্ডতা  বজায় রাখে
- ৪।  একটা  টেবিল এ  একাধিক   ফরেন  কী  থাকতে  পারে 

উদাহরণঃ
```
CREATE TABLE sightings(sighting_id SERIAL PRIMARY KEY,
 ranger_id INTEGER REFERENCES rangers(ranger_id)
ON DELETE CASCADE) ;
```

এখানে  rangers টেবিল  ranger_id  sightings  টেবিল  এ  ফরেন  কী  হিসাবে  কাজ  করে |

 ## 4. How can you modify data using UPDATE statements? 

 **উত্তর**
PostgreSQL-এ ডেটা পরিবর্তন করার জন্য UPDATE স্টেটমেন্ট ব্যবহার করা হয় | 
Update স্টেটমেন্ট  ব্যবহার  করে টেবিলের নির্দিষ্ট রেকর্ড বা একাধিক রেকর্ডের এক বা একাধিক কলামের মান পরিবর্তন করা যায়।
Syntax
```
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```
উদাহরণঃ
```
UPDATE species SET conservation_status='Historic'
 WHERE extract(year from discovery_date)<1800;
```
এখানে species  টেবিল  এর  conservation_status  set হবে যখন condition মিলবে 

## 5. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

 **উত্তর**
PostgreSQL-এ COUNT(), SUM(), এবং AVG() হচ্ছে ‌aggregate functions, যেগুলো অনেকগুলো রেকর্ড (row) এর উপর ভিত্তি করে একটি সংক্ষিপ্ত ফলাফল দেয় — যেমন মোট সংখ্যা, যোগফল, বা গড়।

- Count() - মোট কয়টি রেকর্ড আছে তা গুনে
- Sum() - কোন একটি কলামের সব মান যোগ করে
- AVG()-  কোন কলামের গড়  মান  জন্য

উদাহরণসহ : 
```
SELECT COUNT(*) FROM students;

SELECT SUM(salary) FROM employees;

SELECT AVG(age) FROM students;

```




