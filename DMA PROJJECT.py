#!/usr/bin/env python
# coding: utf-8

# In[1]:


pip install mysql-connector


# In[68]:


import mysql.connector


# In[69]:


pip install pymysql


# In[70]:


db_name='fitnesswellnessdb'
db_host='127.0.0.1'
db_username='root'


# In[71]:


import pymysql


# In[72]:


from getpass import getpass
def sql_connection():
    try:
        connection=pymysql.connect(
            host=db_host,
            port=int(3306),
            user=db_username,
            password=getpass('Enter password:'),
            db=db_name
        )
        if connection:
            print('Database connected successfully')
            return connection
        else:
            print('Not connected')
    except Exception as e:
        print(e)


# --connecting the database

# In[80]:


conn=sql_connection()
conn


# In[81]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt 


# In[19]:


df=pd.read_sql_query("select * from user",conn)
df


# --checking null values

# In[20]:


df.isnull().sum()


# In[21]:


df.info()


# --Finding users from New York

# In[26]:


df1=pd.read_sql_query("select name,location from user_record where Location='New York';",conn)
df1


# -- creating plot to observe the BMI pattern of all the users

# In[35]:


df2=pd.read_sql_query('select * from healthmetrics',conn)
plt.figure(figsize=(10, 6))
plt.plot(df2['Metric_Record_ID'], df2['BMI'], color='blue', marker='o', linestyle='-')
plt.title('Scatter Plot of Metric ID vs BMI')
plt.xlabel('Metric ID')
plt.ylabel('BMI')
plt.grid(True)
plt.show()


# -- Finding the Average BMI of users according to their fitness level

# In[36]:


average_bmi_by_fitness = df2.groupby('FitnessLevel')['BMI'].mean().reset_index()

plt.figure(figsize=(8, 6))
plt.bar(average_bmi_by_fitness['FitnessLevel'], average_bmi_by_fitness['BMI'], color='skyblue')


plt.title('Average BMI by Fitness Level')
plt.xlabel('Fitness Level')
plt.ylabel('Average BMI')


plt.xticks(rotation=45)
plt.grid(axis='y')
plt.show()


# --Retrieving the names of who are the female users above the age 28

# In[39]:


df3=pd.read_sql_query("select name,Age from user_record where age >28 and Gender='Female'",conn)
df3


# --Finding the number of Males and Females in Each Age Group

# In[45]:


df4=pd.read_sql_query('select * from user_record',conn)

bins = [20, 30, 40, 50]  # Define age group boundaries
labels = ['20-29', '30-39', '40-49']  # Labels for age groups
df4['AgeGroup'] = pd.cut(df4['Age'], bins=bins, labels=labels, right=False)

age_gender_counts = df4.groupby(['AgeGroup', 'Gender']).size().unstack(fill_value=0)


age_gender_counts.plot(kind='bar', figsize=(10, 6))
plt.title('Number of Males and Females in Each Age Group')
plt.xlabel('Age Group')
plt.ylabel('Number of People')
plt.xticks(rotation=0)
plt.legend(title='Gender')
plt.tight_layout()
plt.show()


# --Retrieving devices with less charge

# In[46]:


df5=pd.read_sql_query('select  Device_ID,Battery_Level from device where Battery_Level<20;',conn)
df5


# --selecting instructors with more than 4.5 raring

# In[50]:


df6=pd.read_sql_query('select Instructor_name,Rating from instructor where Rating>4.5',conn)
df6


# --Visualizing the percenatge of type of device used using a pie chart

# In[82]:


df7=pd.read_sql_query('select * from device',conn)
workout_counts = df7['Type'].value_counts()
plt.figure(figsize=(8, 8))
plt.pie(workout_counts, labels=workout_counts.index, autopct='%1.1f%%', startangle=140)
plt.title('Percentage of Each Type of Device')
plt.axis('equal')
plt.show()


# -Retrieving user details who are paying greater than the average fee for their plans.

# In[83]:


sql_query = """
SELECT u.User_ID, u.Name, m.Pricing 
FROM membership_plan m
JOIN user u ON m.Membership_ID = u.Membership_ID
WHERE m.Pricing > (SELECT AVG(Pricing) FROM membership_plan);
"""

df = pd.read_sql_query(sql_query, conn)

print(df)

