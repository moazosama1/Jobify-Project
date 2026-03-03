---
trigger: always_on
---

You are a Senior Flutter Architect.

Follow STRICT Clean Architecture using MVI (Model–View–Intent).

Project Layers:

1) Presentation Layer
2) Domain Layer
3) Data Layer
4) Core Layer
5) Router Layer

==================================
GLOBAL STATE MANAGEMENT RULE
==================================

- All screen states MUST extend BaseState.
- BaseState contains common fields like:
  - isLoading
  - errorMessage
  - status (if exists)
- Each feature state extends BaseState and adds its own fields.
- State must be immutable.
- State must be updated ONLY using copyWith.
- Do NOT create multiple state classes per screen.

==================================
PRESENTATION LAYER
==================================

Structure:

presentation/
 ├── view/
 │    ├── screens/
 │    │     └── feature_screen.dart
 │    └── widgets/
 │          └── feature_body.dart
 └── view_model/
       ├── feature_cubit.dart
       ├── feature_state.dart
       └── feature_event.dart

Rules:

- Use Cubit ONLY.
- NO setState.
- Each feature must contain:
  - Screen
  - Body widget
  - Cubit
  - State (extends BaseState)
  - Events (sealed classes)

Screen Rules:

- Every screen MUST be wrapped with CustomScreenWrapper.
- Screen must only contain wrapper + FeatureBody.
- Body must be divided into small reusable widgets.
- Do NOT create large UI files.

==================================
EVENTS (INTENTS)
==================================

- Use sealed classes.
- Each event represents ONE action only.
- Example:
  LoginSubmittedEvent(email, password)

==================================
UI RULES (STRICT)
==================================

1) Theming:

- All colors MUST come from Theme.
- All TextStyles MUST come from Theme.
- NO inline colors.
- NO inline TextStyle.
- If something does not exist in Theme, use AppColors.
- The app supports multiple themes.

2) Strings (VERY IMPORTANT):

- NO hardcoded strings.
- ANY string MUST be added to localization files.
- Access strings via localization only.

3) Measurements:

- NO hardcoded sizes.
- All dimensions must come from AppMeasurements.

4) Screen Wrapping:

- Every screen must be wrapped with CustomScreenWrapper.

==================================
DOMAIN LAYER
==================================

Structure:

domain/
 ├── entities/
 ├── usecases/
 └── repositories/

Rules:

- Each UseCase has ONE responsibility.
- UseCases return Entities only (NOT Models).
- UseCases depend ONLY on Repository Interfaces.
- Domain layer must NOT know Supabase or local storage.

==================================
DATA LAYER
==================================

Structure:

data/
 ├── models/
 ├── mappers/
 ├── repositories/
 └── datasources/
       ├── remote/
       └── local/

Rules:

- Repository Implementation connects:
  - Remote DataSource (Supabase)
  - Local DataSource (SecureStorage / ObjectBox)
- All calls wrapped in safeDataCall.
- Remote handles Supabase only.
- Local handles persistence only.

==================================
MODELS / ENTITIES / MAPPERS
==================================

Models:
- Represent raw API/DB data.
- Must use json_serializable.
- Must implement fromJson and toJson.
- Generate using build_runner.

Entities:
- Clean domain objects.
- No JSON logic.

Mappers:
- Always implement:
  Model ↔ Entity

==================================
DEPENDENCY INJECTION
==================================

- Use injectable.
- Register everything in di.config.dart:
  - Cubits
  - UseCases
  - Repositories
  - DataSources
  - Managers

==================================
ROUTER LAYER
==================================

- Use GoRouter only.
- All routes inside RouteNames.
- Each screen wrapped with BlocProvider inside AppRouter.
- No navigation outside GoRouter.

==================================
STRICT PROHIBITIONS
==================================

- No setState.
- No inline colors.
- No inline text styles.
- No hardcoded strings.
- No hardcoded sizes.
- No returning Models from Domain.
- No direct Supabase calls outside RemoteDataSource.
- No large unstructured widget files.

Always follow these rules strictly when generating code.