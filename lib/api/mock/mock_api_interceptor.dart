import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'mock_data_provider.dart';

/// Intercepts Dio requests in Web/Demo mode and returns realistic mock data seamlessly.
class MockApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Simulate natural network delay (300ms)
    await Future.delayed(const Duration(milliseconds: 300));

    final path = options.path;

    debugPrint('⚡ [MockApiInterceptor] Intercepting request: ${options.method} $path');

    // 1. Authentication
    if (path.contains(EndPoints.signIn)) {
      final data = options.data is Map ? options.data as Map : {};
      final email = data['email']?.toString() ?? '';
      final isHr = email.contains('hr');

      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Login successful",
            "access_token": "mock_jwt_access_token_demo",
            "refresh_token": "mock_jwt_refresh_token_demo",
            "user": isHr ? MockDataProvider.currentUserHr : MockDataProvider.currentUserSeeker
          },
        ),
      );
    }

    if (path.contains(EndPoints.signup)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 201,
          data: {
            "message": "User registered successfully",
            "access_token": "mock_jwt_access_token_demo",
            "refresh_token": "mock_jwt_refresh_token_demo",
            "user": MockDataProvider.currentUserSeeker
          },
        ),
      );
    }

    if (path.contains(EndPoints.confirmEmail) ||
        path.contains(EndPoints.forgetPassword) ||
        path.contains(EndPoints.resetPassword)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {"message": "Success"},
        ),
      );
    }

    // 2. Profile
    if (path.contains(EndPoints.getProfile)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Profile fetched successfully",
            "user": MockDataProvider.currentUserSeeker
          },
        ),
      );
    }

    if (path.contains(EndPoints.updateProfile) ||
        path.contains(EndPoints.addExp) ||
        path.contains(EndPoints.addEd) ||
        path.contains(EndPoints.udateSkills)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Profile updated successfully",
            "user": MockDataProvider.currentUserSeeker
          },
        ),
      );
    }

    // 3. Jobs
    if (path.contains(EndPoints.getJobs)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Jobs retrieved successfully",
            "pagination": {"currentPage": 1, "totalPages": 1, "totalItems": MockDataProvider.mockJobs.length},
            "jobs": MockDataProvider.mockJobs
          },
        ),
      );
    }

    if (path.contains(EndPoints.getMyJobs)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "My jobs retrieved successfully",
            "jobs": MockDataProvider.mockJobs
          },
        ),
      );
    }

    if (path.contains(EndPoints.getSavedJobs)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Saved jobs retrieved successfully",
            "jobs": [MockDataProvider.mockJobs[0]]
          },
        ),
      );
    }

    if (path.contains(EndPoints.createJob)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 201,
          data: {
            "message": "Job created successfully",
            "job": MockDataProvider.mockJobs[0]
          },
        ),
      );
    }

    if (path.contains("jobs/")) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Job fetched successfully",
            "job": MockDataProvider.mockJobs[0]
          },
        ),
      );
    }

    // 4. Applications
    if (path.contains(EndPoints.getMyApplications)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Applications retrieved",
            "applications": MockDataProvider.mockApplications
          },
        ),
      );
    }

    if (path.contains(EndPoints.getApplicationStats)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Stats retrieved",
            "totalApplications": 42,
            "underReview": 12,
            "shortlisted": 8,
            "rejected": 5,
            "accepted": 17
          },
        ),
      );
    }

    if (path.contains(EndPoints.applyJob)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 201,
          data: {
            "message": "Applied successfully",
            "application": MockDataProvider.mockApplications[0]
          },
        ),
      );
    }

    // 5. Messages
    if (path.contains(EndPoints.getConversations)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Conversations retrieved",
            "conversations": MockDataProvider.mockConversations
          },
        ),
      );
    }

    if (path.contains(EndPoints.getConversation)) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "message": "Chat history retrieved",
            "messages": MockDataProvider.mockMessages
          },
        ),
      );
    }

    if (path.contains(EndPoints.sendMessage)) {
      final msgContent = options.data is Map ? (options.data['content'] ?? 'Hello!') : 'Hello!';
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 201,
          data: {
            "message": "Message sent",
            "data": {
              "_id": "msg_${DateTime.now().millisecondsSinceEpoch}",
              "senderId": "65f1a2b3c4d5e6f7a8b9c0d1",
              "receiverId": "65f987654321fedcba987654",
              "content": msgContent,
              "isRead": false,
              "createdAt": DateTime.now().toIso8601String()
            }
          },
        ),
      );
    }

    // Default Fallback Mock Response for any unhandled routes
    return handler.resolve(
      Response(
        requestOptions: options,
        statusCode: 200,
        data: {"message": "Success (Mock Data)"},
      ),
    );
  }
}
