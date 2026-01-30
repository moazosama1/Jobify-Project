# 🚀 Jobify Mobile App

A smart, user-friendly, and interactive cross-platform mobile application designed to simplify and enhance the job search and recruitment process.

## ✨ Overview

[cite_start]Jobify aims to bridge the gap between job seekers and employers by providing a seamless, real-time platform for managing job listings, applications, and direct communication[cite: 19, 26].

[cite_start]The project addresses the current challenges of time-consuming, inefficient job searching, and manual application management by offering a dedicated, reliable, and personalized solution[cite: 28, 29, 30].

## 🎯 Objectives

* [cite_start]Develop a **cross-platform mobile application** using Flutter for Android and iOS[cite: 32].
* [cite_start]Implement separate, specialized modules for **Job Seekers** and **HR/Recruiter** users[cite: 32].
* [cite_start]Build a **secure and scalable backend** using Node.js and MongoDB[cite: 34].
* [cite_start]Ensure **seamless, real-time communication** between both user roles[cite: 35].
* [cite_start]Design an **intuitive, attractive, and responsive UI/UX** using Figma[cite: 25, 34].

## 🛠️ Technology Stack

| Category | Tools / Technologies |
| :--- | :--- |
| **Frontend** | [cite_start]Flutter, Dart [cite: 105, 106] |
| **Backend** | [cite_start]Node.js, Express.js [cite: 107, 108] |
| **Database** | [cite_start]MongoDB [cite: 109, 110] |
| **UI/UX** | [cite_start]Figma [cite: 111, 112] |
| **Version Control** | [cite_start]Git, GitHub [cite: 115, 117] |

## 🌟 Key Features

[cite_start]The system serves two main user roles: Job Seekers and HR or Company Owners[cite: 20].

### 👤 Common Features

* [cite_start]**User Authentication**: Secure register, login, logout, and password reset functionality using JWT tokens[cite: 52, 53].
* [cite_start]**Profile Management**: Users can update personal information, profile photo, and account details[cite: 54, 55].

### 🔍 Job Seeker Features

* [cite_start]**Browse and Search Jobs**: Filter job opportunities by title, category, location, or company[cite: 21, 57, 58].
* [cite_start]**Job Application**: Apply directly for jobs and upload CVs/documents[cite: 21, 59, 60].
* [cite_start]**Save Jobs**: Save favorite jobs for later reference[cite: 62, 63].
* [cite_start]**Chat with Recruiters**: Send and receive messages from HR users[cite: 21, 64, 65].
* [cite_start]**View Application Status**: Track application status (accepted, rejected, or under review)[cite: 66, 67].

### 💼 HR/Recruiter Features

* [cite_start]**Post Job Announcements**: Create new job posts with a title, description, and requirements[cite: 22, 73, 75].
* [cite_start]**Manage Applications**: View received applications, attached CVs, and accept or reject candidates through the app[cite: 22, 76, 77, 78].
* [cite_start]**Profile Management**: Display company name, logo, and contact information[cite: 79, 80].
* [cite_start]**Chat with Applicants**: Communicate directly with job seekers[cite: 23, 81, 82].
* [cite_start]**Job Management**: Edit, delete, or close existing job posts[cite: 83, 84].

## ⚙️ System Architecture

The Jobify system is structured into two main layers:

1.  [cite_start]**Frontend (Mobile App)**[cite: 38]:
    * [cite_start]Developed using **Flutter**[cite: 41].
    * [cite_start]Provides all UI screens (login, job feed, profile, chat)[cite: 42].
    * [cite_start]Communicates with the backend via secure **RESTful APIs**[cite: 43].
2.  [cite_start]**Backend (Server)**[cite: 44]:
    * [cite_start]Built using **Node.js and Express.js**[cite: 45].
    * [cite_start]Handles authentication, job posting, search, application processing, and chat services[cite: 46].
    * [cite_start]Utilizes **MongoDB** for data storage, ensuring flexibility and scalability[cite: 47].

## 💻 Installation and Setup

### Prerequisites

* Flutter SDK
* Node.js & npm (or yarn)
* MongoDB instance (local or Atlas)
* Git

### 1. Clone the repository

```bash
git clone [Your Repository URL]
cd jobify-mobile-app