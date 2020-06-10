# Easy Assignments

A Flutter + Firebase project for easy sharing of Assignments

## Description

This Project is been made to facilitate easy sharing of Assignments between the 10 Pointers and the normies.  

## Screenshots
<p align="middle">
  <img src="https://github.com/AJAYK-01/EasyAssignments/blob/master/Screenshots/Screenshot_2020-06-10-22-15-53-857_com.ajayk.cloud_storage.jpg" width="180" height="360" />
  <img src="https://github.com/AJAYK-01/EasyAssignments/blob/master/Screenshots/Screenshot_2020-06-08-18-01-06-931_com.ajayk.cloud_storage.jpg" width="180" height="360" /> 
  <img src="https://github.com/AJAYK-01/EasyAssignments/blob/master/Screenshots/Screenshot_2020-06-10-18-54-10-991_com.ajayk.cloud_storage.jpg" width="180" height="360"" />
  <img src="https://github.com/AJAYK-01/EasyAssignments/blob/master/Screenshots/Screenshot_2020-06-05-22-57-12-394_com.ajayk.cloud_storage.jpg" width="180" height="360"" />
</p>

## Features
- Cloud based Notifications to alert user when a new assignment gets Uploaded
- Option for the to send assignment requests
- Separate accounts for uploader and user to avoid spamming
- Users can be added or removed anytime using the firebase database

## How to use
- Clone the repo
- Create a Firebase account and link project with it
- Create databases 'clouddata', 'requests', 'subjects' and 'uploaders' in Firebase
- Add your Uploader accounts and Subjects to the respective databases
- Create Firebase Cloud Function with Typescript 
- Replace the src/index.ts in your functions folder with the file from functions folder of this repo
- Deploy your functions into Firebase for getting seamless CLoud Based Notifications
- Build the App and voila!!
