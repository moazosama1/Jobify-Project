import 'package:flutter/material.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashNavigateToHome extends SplashState {}

class SplashNavigateToOnboarding extends SplashState {}
