import 'dart:async';

/// Comprehensive Mock Data Provider for Jobify Web Demo
class MockDataProvider {
  static final Map<String, dynamic> currentUserSeeker = {
    "_id": "65f1a2b3c4d5e6f7a8b9c0d1",
    "id": "65f1a2b3c4d5e6f7a8b9c0d1",
    "firstName": "Anas",
    "lastName": "Mohamed",
    "email": "anas.demo@jobify.com",
    "provider": "system",
    "age": 25,
    "gender": "male",
    "phoneNumber": "+201012345678",
    "location": "Cairo, Egypt",
    "role": "JobSeeker",
    "skills": ["Flutter", "Dart", "Clean Architecture", "MVI", "BLoC", "REST API", "Git"],
    "jobTypePreferences": ["Full-Time", "Remote", "Hybrid"],
    "savedJobs": ["job_101", "job_103"],
    "confirmed": true,
    "friends": [],
    "blockedUsers": [],
    "isActive": true,
    "notificationsEnabled": true,
    "experience": [
      {
        "_id": "exp_1",
        "companyName": "TechSolutions Egypt",
        "jobTitle": "Senior Flutter Developer",
        "startDate": "2023-01-15T00:00:00.000Z",
        "endDate": "Present",
        "isCurrent": true,
        "description": "Architecting and developing cross-platform mobile & web enterprise apps using Clean Architecture and MVI/Cubit."
      },
      {
        "_id": "exp_2",
        "companyName": "Innovate Mobile Studio",
        "jobTitle": "Flutter Engineer",
        "startDate": "2021-06-01T00:00:00.000Z",
        "endDate": "2022-12-31T00:00:00.000Z",
        "isCurrent": false,
        "description": "Built scalable Flutter applications, implemented CI/CD pipelines, and integrated state management solutions."
      }
    ],
    "education": [
      {
        "_id": "edu_1",
        "institutionName": "Faculty of Computers and Artificial Intelligence",
        "degree": "Bachelor of Computer Science",
        "fieldOfStudy": "Software Engineering",
        "startDate": "2018-09-01T00:00:00.000Z",
        "endDate": "2022-06-30T00:00:00.000Z"
      }
    ],
    "resume": "https://mahy-s3-bucket-2025.s3.us-east-1.amazonaws.com/demo_resume.pdf",
    "profileImage": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80",
    "createdAt": "2024-01-01T10:00:00.000Z",
    "updatedAt": "2024-07-20T12:00:00.000Z",
    "__v": 0,
    "userName": "anas_dev",
    "bio": "Passionate Flutter & Mobile App Architect building production-ready enterprise solutions."
  };

  static final Map<String, dynamic> currentUserHr = {
    "_id": "65f987654321fedcba987654",
    "id": "65f987654321fedcba987654",
    "firstName": "Sarah",
    "lastName": "Al-Mansoor",
    "email": "hr.sarah@globaltech.com",
    "provider": "system",
    "age": 30,
    "gender": "female",
    "phoneNumber": "+201098765432",
    "location": "Dubai, UAE",
    "role": "HR",
    "skills": ["Talent Acquisition", "Technical Recruiting", "HR Operations"],
    "jobTypePreferences": [],
    "savedJobs": [],
    "confirmed": true,
    "friends": [],
    "blockedUsers": [],
    "isActive": true,
    "notificationsEnabled": true,
    "experience": [],
    "education": [],
    "profileImage": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&q=80",
    "createdAt": "2023-11-15T09:00:00.000Z",
    "updatedAt": "2024-07-15T15:00:00.000Z",
    "__v": 0,
    "userName": "sarah_recruiter",
    "bio": "Lead Technical Recruiter at GlobalTech. Connecting elite engineering talent with impactful opportunities."
  };

  static final List<Map<String, dynamic>> mockJobs = [
    {
      "_id": "job_101",
      "id": "job_101",
      "title": "Senior Flutter Architect",
      "companySnapshot": {
        "companyName": "GlobalTech Solutions",
        "companyLogo": "https://images.unsplash.com/photo-1549923746-c502d488b3ea?w=300&q=80",
        "industry": "Software Engineering & AI",
        "companySize": "250-500 Employees"
      },
      "postedBy": "65f987654321fedcba987654",
      "description": "We are seeking a visionary Senior Flutter Architect to lead our mobile engineering team in designing scalable, clean MVI enterprise applications.",
      "responsibilities": [
        "Architect and implement production Flutter apps using Clean Architecture and MVI pattern.",
        "Lead code reviews, enforce design systems, and maintain high test coverage.",
        "Optimize web & mobile performance, animations, and micro-interactions.",
        "Collaborate closely with UI/UX designers and backend service teams."
      ],
      "requirements": [
        "4+ years of professional Flutter & Dart software development experience.",
        "Mastery of state management (Bloc/Cubit, MVI architecture).",
        "Deep understanding of CI/CD, Retrofit, Dio, and dependency injection.",
        "Strong experience in cross-platform web and mobile deployment."
      ],
      "preferredQualifications": [
        "Experience with GraphQL, Firebase, and Socket.IO.",
        "Published top-tier apps on Google Play and Apple App Store."
      ],
      "location": "Dubai / Remote",
      "employmentType": "Full-Time",
      "experienceLevel": "Senior",
      "salaryRange": {"min": 4000, "max": 6500, "currency": "USD", "period": "Monthly"},
      "applicationDeadline": "2026-12-31T23:59:59.000Z",
      "skillsRequired": ["Flutter", "Dart", "Clean Architecture", "Bloc", "CI/CD"],
      "category": "Mobile Development",
      "openings": 2,
      "status": "Active",
      "applicationsCount": 18,
      "isRemote": true,
      "createdAt": "2026-07-01T10:00:00.000Z",
      "updatedAt": "2026-07-20T12:00:00.000Z",
      "__v": 0
    },
    {
      "_id": "job_102",
      "id": "job_102",
      "title": "Lead UI/UX Mobile Designer",
      "companySnapshot": {
        "companyName": "Creative Studio",
        "companyLogo": "https://images.unsplash.com/photo-1572021335469-31706a17aaef?w=300&q=80",
        "industry": "Design & Product UX",
        "companySize": "50-100 Employees"
      },
      "postedBy": "65f987654321fedcba987654",
      "description": "Join our studio to design modern, luxurious mobile user interfaces and glassmorphic micro-animations for flagship apps.",
      "responsibilities": [
        "Craft pixel-perfect mobile and web app UI prototypes in Figma.",
        "Define comprehensive visual design systems and component libraries.",
        "Work directly with Flutter developers to ensure seamless UI execution."
      ],
      "requirements": [
        "3+ years designing iOS, Android, and Web interfaces.",
        "Expertise in Figma, Adobe XD, and interactive prototyping."
      ],
      "preferredQualifications": ["Basic understanding of Flutter widget trees."],
      "location": "Riyadh, Saudi Arabia",
      "employmentType": "Full-Time",
      "experienceLevel": "Mid-Senior",
      "salaryRange": {"min": 3500, "max": 5000, "currency": "USD", "period": "Monthly"},
      "applicationDeadline": "2026-11-30T23:59:59.000Z",
      "skillsRequired": ["Figma", "UI Design", "UX Research", "Design Systems"],
      "category": "Design",
      "openings": 1,
      "status": "Active",
      "applicationsCount": 24,
      "isRemote": false,
      "createdAt": "2026-07-05T14:30:00.000Z",
      "updatedAt": "2026-07-21T09:00:00.000Z",
      "__v": 0
    },
    {
      "_id": "job_103",
      "id": "job_103",
      "title": "Full Stack Node.js & Flutter Engineer",
      "companySnapshot": {
        "companyName": "Nexus AI Labs",
        "companyLogo": "https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=300&q=80",
        "industry": "Artificial Intelligence",
        "companySize": "100-250 Employees"
      },
      "postedBy": "65f987654321fedcba987654",
      "description": "Build high-concurrency microservices with Node.js and real-time frontend interfaces in Flutter.",
      "responsibilities": [
        "Develop RESTful & WebSocket APIs using Node.js, Express, and MongoDB.",
        "Integrate mobile apps with LLMs and real-time streaming services."
      ],
      "requirements": [
        "3+ years experience with Node.js, TypeScript, and MongoDB.",
        "Experience building Flutter cross-platform applications."
      ],
      "preferredQualifications": ["Experience with WebSockets & Socket.IO."],
      "location": "Cairo, Egypt / Remote",
      "employmentType": "Full-Time",
      "experienceLevel": "Mid-Level",
      "salaryRange": {"min": 2500, "max": 4000, "currency": "USD", "period": "Monthly"},
      "applicationDeadline": "2026-10-15T23:59:59.000Z",
      "skillsRequired": ["Node.js", "Flutter", "MongoDB", "TypeScript", "REST API"],
      "category": "Backend & Mobile",
      "openings": 3,
      "status": "Active",
      "applicationsCount": 42,
      "isRemote": true,
      "createdAt": "2026-07-10T11:20:00.000Z",
      "updatedAt": "2026-07-22T08:00:00.000Z",
      "__v": 0
    }
  ];

  static final List<Map<String, dynamic>> mockApplications = [
    {
      "_id": "app_201",
      "job": mockJobs[0],
      "applicant": currentUserSeeker,
      "status": "Under Review",
      "appliedAt": "2026-07-15T14:20:00.000Z",
      "coverLetter": "Extremely excited about the Senior Flutter Architect role! My background in Clean Architecture and MVI makes me a perfect fit."
    },
    {
      "_id": "app_202",
      "job": mockJobs[2],
      "applicant": currentUserSeeker,
      "status": "Shortlisted",
      "appliedAt": "2026-07-12T09:45:00.000Z",
      "coverLetter": "Passionate about full-stack Flutter and Node.js integrations."
    }
  ];

  static final List<Map<String, dynamic>> mockConversations = [
    {
      "_id": "conv_301",
      "participant": {
        "_id": "65f987654321fedcba987654",
        "firstName": "Sarah (HR)",
        "lastName": "GlobalTech",
        "profileImage": "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&q=80"
      },
      "lastMessage": "Hello Anas! We reviewed your application for Senior Flutter Architect and were very impressed.",
      "unreadCount": 1,
      "updatedAt": "2026-07-22T16:00:00.000Z"
    }
  ];

  static final List<Map<String, dynamic>> mockMessages = [
    {
      "_id": "msg_401",
      "senderId": "65f987654321fedcba987654",
      "receiverId": "65f1a2b3c4d5e6f7a8b9c0d1",
      "content": "Hello Anas! Thank you for applying to the Senior Flutter Architect role at GlobalTech.",
      "isRead": true,
      "createdAt": "2026-07-22T15:30:00.000Z"
    },
    {
      "_id": "msg_402",
      "senderId": "65f1a2b3c4d5e6f7a8b9c0d1",
      "receiverId": "65f987654321fedcba987654",
      "content": "Hi Sarah! Thank you so much. I look forward to discussing how I can contribute to your Flutter app ecosystem.",
      "isRead": true,
      "createdAt": "2026-07-22T15:45:00.000Z"
    },
    {
      "_id": "msg_403",
      "senderId": "65f987654321fedcba987654",
      "receiverId": "65f1a2b3c4d5e6f7a8b9c0d1",
      "content": "Hello Anas! We reviewed your application for Senior Flutter Architect and were very impressed.",
      "isRead": false,
      "createdAt": "2026-07-22T16:00:00.000Z"
    }
  ];
}
