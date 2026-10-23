# 📝 Tasky - Personal Task & Todo Manager

**Tasky** is a clean, modern, and feature-rich Flutter application designed to help users stay organized, boost productivity, and effortlessly manage daily tasks. With local persistence, customizable themes, priority filtering, and personal profile management, Tasky makes getting things done simple and delightful.

---

## ✨ Features

- 📋 **Task Management**: Create, edit, complete, and delete tasks with custom titles and descriptions.
- 🔥 **High Priority Tasks**: Mark important tasks as High Priority to highlight and manage them in a dedicated view.
- 📊 **Progress & Analytics**: Visual progress indicators showing completed tasks vs. pending tasks.
- 🗂️ **Categorized Views**: Separate dedicated screens for:
  - 📌 **To Do Tasks**: View and manage all active pending tasks.
  - ✅ **Completed Tasks**: Track finished goals and completed tasks.
  - ⭐ **High Priority Tasks**: Focus on urgent high-priority items.
- 👤 **Personalized Profile**:
  - Customize your username and daily motivational quote.
  - Change profile picture using **Camera** or **Gallery** with automatic local image persistence.
- 🌙 **Dark & Light Theme**: Seamlessly toggle between Light and Dark modes with instant theme persistence.
- 💾 **Local Data Persistence**: All tasks, user details, and profile images are saved locally using `SharedPreferences` and local file storage.

---

## 🛠️ Tech Stack & Packages

| Category | Technology / Package | Description |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) | Cross-platform UI toolkit built with Dart |
| **Icons & Typography** | `cupertino_icons`, `flutter_svg`, `google_fonts` | Modern vector graphics, icons, and typography |
| **Storage** | `shared_preferences`, `path_provider` | Persistent local key-value and app document storage |
| **Media** | `image_picker` | Camera capture and gallery image selection |

---

## 📁 Project Architecture

```text
lib/
├── core/
│   ├── enums/             # Task action enums
│   ├── services/          # PreferenceManager (SharedPreferences singleton)
│   ├── theme/             # LightTheme, DarkTheme, ThemeController
│   └── widgets/           # Reusable form fields, custom SVG pictures
├── models/
│   └── task_model.dart    # Task model & JSON serialization
├── screens/
│   ├── add_task.dart       # New task creation screen
│   ├── complete_tasks.dart # Completed tasks view
│   ├── high_priority_screen.dart # High priority task filter screen
│   ├── home_screen.dart    # Main dashboard screen
│   ├── profile_screen.dart # User profile & settings
│   ├── tasks_screen.dart   # All active To-Do tasks screen
│   ├── user_details.dart   # Username & quote edit screen
│   └── welcome.dart       # Onboarding / Welcome screen
└── widgets/
    ├── achieved_tasks.dart
    ├── custom_checkBox.dart
    ├── high_priority_tasks.dart
    ├── sliver_task_list_widget.dart
    ├── task_item_widget.dart
    └── task_list_widget.dart
```

---

## 🚀 Getting Started

Follow these steps to set up and run Tasky locally on your machine:

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.12` or higher)
- [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/)
- An Android Emulator, iOS Simulator, or connected physical device

### Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/Tasky.git
   cd Tasky
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📱 Features Overview

| Feature | Description |
| :--- | :--- |
| 🚀 **Add Task** | Easily add new tasks with name, description, and priority level. |
| ✏️ **Edit Task** | Update existing task details, description, or priority settings anytime. |
| 🗑️ **Delete Task** | Confirm and remove unwanted tasks with a single tap. |
| 📸 **Profile Picture** | Snap a new camera picture or select from gallery for your profile avatar. |
| 🌓 **Theme Switch** | Instant switch between clean Light and Dark UI themes. |

---

## 💡 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page or submit a pull request.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
