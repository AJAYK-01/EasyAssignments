# Easy Assignments

A Flutter + Firebase project for easy sharing of Assignments

## Description

This Project is been made to facilitate easy sharing of Assignments between the 10 Pointers and the normies.  

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
- Deploy the functions folder from the project into Firebase Cloud Functions for adding Notifications
- Build the App and voila!!
