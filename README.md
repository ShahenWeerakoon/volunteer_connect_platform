# Volunteer Connect Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A cross-platform mobile application built with **Flutter** and **Firebase** that connects passionate volunteers with community organizations and event organizers. The platform provides tailored experiences for both volunteers and organizers, featuring real-time event discovery, registrations, team communication, and participation analytics.

---

## 🌟 Key Features

### 👥 Dual-Role System & Role-Based Routing
- **Automatic Role Routing**: Intelligent `AuthWrapper` listens to Firebase authentication state and directs users to either the **Volunteer Dashboard** or **Organizer Dashboard** based on their profile role in Cloud Firestore.
- **Unified Authentication**: Clean email and password authentication, registration with role assignment, and logout flows.

---

### 🏢 Organizer Portal
- **Interactive Dashboard**:
  - High-level KPI summary cards (Total Events, Active Events, Total Registered Volunteers).
  - Quick action shortcuts to event management, roster tracking, chatrooms, and reports.
- **Event Lifecycle Management**:
  - **Create Events**: Set event title, description, location, and date using native date pickers.
  - **Edit & Update**: Real-time updates to event details, venue, and scheduling.
  - **Delete Events**: Remove completed or cancelled events directly from the management view.
- **Volunteer Management**:
  - View registered volunteers per event with their emergency contacts, contact numbers, and declared skills.
- **Real-Time Chatroom & Announcements**:
  - Two-way real-time messaging between organizers and participants.
  - Dedicated Announcement feed with emoji reaction support.
- **Analytics & Reporting**:
  - View aggregate event participation and volunteer turnout.
- **Organizer Profile**:
  - Organization branding, bio, contact details, and custom avatar upload powered by Firebase Storage.

---

### 🤝 Volunteer Portal
- **Personalized Volunteer Dashboard**:
  - Activity summary tracking joined events, contributed hours, and earned badges.
  - Quick access to profile information and action centers.
- **Event Discovery**:
  - Browse available volunteer opportunities in real time.
  - View event specifics: organizer name, venue, schedule, and mission description.
- **One-Tap Event Registration**:
  - Seamless signup flow collecting emergency contact info and relevant skills for the organizers.
- **Participation History**:
  - Keep track of joined and completed events in one unified list.

---

## 🛠️ Architecture & Tech Stack

- **Frontend / Framework**: [Flutter](https://flutter.dev/) (Material 3 UI, custom widgets, gradients, and responsive layouts)
- **Programming Language**: [Dart](https://dart.dev/) (Null-safety enabled)
- **Backend-as-a-Service (BaaS)**: [Firebase](https://firebase.google.com/)
  - **Firebase Authentication**: User sign-in, account creation, and session persistence.
  - **Cloud Firestore**: Real-time NoSQL database for events, registrations, user roles, chat messages, and announcements.
  - **Firebase Storage**: Secure cloud asset storage for user and organization profile avatars.
- **Key Plugins & Dependencies**:
  - `firebase_core`: Firebase SDK initialization.
  - `firebase_auth`: Secure user authentication.
  - `cloud_firestore`: Real-time reactive data streaming.
  - `firebase_storage`: Cloud asset storage.
  - `image_picker`: Device gallery integration for profile uploads.
  - `google_sign_in`: Social authentication provider support.
  - `cupertino_icons`: iOS-style icons.

---

## 📂 Project Structure

```text
volunteer_connect_platform/
├── android/                         # Android native project files & Gradle scripts
├── ios/                             # iOS native configuration
├── lib/
│   ├── firebase_options.dart        # Platform-specific Firebase credentials
│   ├── main.dart                    # App entry point & Firebase initialization
│   │
│   ├── core/                        # Core utilities and shared helpers
│   │
│   ├── models/                      # Data models & JSON serialization
│   │   ├── event_model.dart         # Event entity schema (fromMap / toMap)
│   │   └── user_model.dart          # User profile model
│   │
│   ├── screens/                     # UI Views & Screens
│   │   ├── auth/                    # Authentication flows
│   │   │   ├── login_screen.dart    # Login interface
│   │   │   └── register_screen.dart # Registration with role selector
│   │   │
│   │   ├── common/                  # Shared screens
│   │   │   └── home_screen.dart     # Fallback & profile view
│   │   │
│   │   ├── organization/            # Organizer flow
│   │   │   ├── organizer_home.dart  # Organizer dashboard & KPI overview
│   │   │   ├── add_event_screen.dart# Create new event form
│   │   │   ├── edit_event_screen.dart # Edit event details
│   │   │   ├── my_events_screen.dart# Organizer's event list & actions
│   │   │   ├── EventRegistrationsScreen.dart # Event registration overview
│   │   │   ├── volunteers_list_screen.dart # Attendee details per event
│   │   │   ├── chatroom_screen.dart # Real-time event chat & announcements
│   │   │   ├── reports_screen.dart  # Analytics & metrics
│   │   │   └── organizer_profile_screen.dart # Profile edit & image upload
│   │   │
│   │   └── volunteer/               # Volunteer flow
│   │       ├── volunteer_home.dart  # Volunteer dashboard & stats
│   │       ├── available_events.dart# Event catalog & registration dialog
│   │       └── participation_history.dart # Volunteer history log
│   │
│   ├── services/                    # Business logic & Firebase APIs
│   │   ├── auth_service.dart        # Registration, login, & session management
│   │   └── firestore_service.dart   # CRUD operations for events, users, chat, etc.
│   │
│   └── widgets/                     # Reusable widgets
│       └── auth_wrapper.dart        # StreamBuilder listening to auth state & roles
│
├── test/                            # Unit and widget tests
│   └── widget_test.dart
├── pubspec.yaml                     # Dependencies and project metadata
└── README.md                        # Project documentation
```

---

## 🗄️ Firestore Database Schema

The application organizes data across the following primary Firestore collections:

| Collection | Document ID | Description / Fields |
| :--- | :--- | :--- |
| **`users`** | `uid` | User profile: `email`, `name`, `phone`, `role` (`Volunteer` \| `Organizer`), `organizerType`, `organizationName`, `bio`, `profileImage`, `createdAt` |
| **`events`** | Auto ID | Event details: `title`, `description`, `location`, `date`, `organizerId`, `organizerName`, `clubId`, `createdAt`, `updatedAt` |
| **`events/{id}/messages`** | Auto ID | Sub-collection: Event group messages (`senderId`, `senderName`, `message`, `createdAt`) |
| **`events/{id}/announcements`** | Auto ID | Sub-collection: Organizer announcements (`senderId`, `senderName`, `message`, `reactions`, `createdAt`) |
| **`registrations`** | Auto ID | Event registrations: `eventId`, `userId`, `name`, `email`, `phone`, `emergencyContact`, `skills`, `status`, `createdAt` |
| **`clubs`** *(optional)* | Auto ID | Community clubs and membership information |

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.10.4` or later)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension
- An Android device or emulator (Android API 21+) / iOS simulator (macOS required)
- [Firebase CLI](https://firebase.google.com/docs/cli) (optional, if modifying backend configs)

---

### Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/volunteer_connect_platform.git
   cd volunteer_connect_platform
   ```

2. **Install Flutter packages**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - The project is configured with Firebase options via `lib/firebase_options.dart` and `android/app/google-services.json`.
   - If connecting to your own Firebase project:
     ```bash
     flutterfire configure
     ```
   - Ensure **Email/Password** provider is enabled in Firebase Console > Authentication.
   - Ensure **Cloud Firestore** and **Firebase Storage** are created and active.

4. **Run the Application**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Code Quality

Run tests and static analysis:

```bash
# Run static analysis
flutter analyze

# Run unit and widget tests
flutter test
```

---

## 🔒 Security Best Practices

- Make sure to review and apply production security rules in **Cloud Firestore** and **Firebase Storage** before deploying to production.
- Ensure that organizers can only edit or delete events they created (`request.auth.uid == resource.data.organizerId`).
- Restrict volunteer registration updates to the registered volunteer and event organizer.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
