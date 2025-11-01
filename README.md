# Flutter GSG — Recipe App

A simple Flutter recipe app (learning project) that demonstrates:

- Local persistence with SQLite (sqflite)
- Simple authentication stored with `SharedPreferences`
- State management with Cubit (flutter_bloc)

This README explains how to set up, run, and troubleshoot common issues
encountered while developing and building the app.

## Features

- Browse recipes by category
- View recipe details and instructions
- Bookmark recipes (persisted to local DB)
- Sign up / Login flow (local only)

## Repository layout (important files)

- `lib/main.dart` — app entry, bloc providers
- `lib/cubit/` — Cubits and state definitions (`auth_cubit`, `recipes_cubit`, ...)
- `lib/data/` — data layer: `recipes_app_sqlite_db.dart`, `recipe_repository.dart`, models
- `lib/UI/screens/` — screens and navigation
- `android/`, `ios/`, `windows/`, `linux/`, `macos/` — platform projects

## Prerequisites

- Flutter SDK (stable) installed and on your PATH
- Android SDK + command-line tools (for Android builds)
- Valid device/emulator or desktop target

Optional for desktop SQLite debugging:
- `sqflite_common_ffi` (see "Notes: Desktop")

## Quick setup (Windows PowerShell)

Run the following from the project root:

```powershell
cd "c:\\flutter_project_1"
flutter pub get
flutter analyze
flutter run
```

## Running and building

- Run on connected device / emulator:

```powershell
flutter run
```

- Build APK:

```powershell
flutter build apk --release
```

## Notes: Database & desktop

- The app uses `sqflite` on mobile. If you plan to run the app on desktop
	for development, add and initialize `sqflite_common_ffi` in `main()` before
	opening the DB (set `databaseFactory = databaseFactoryFfi`).

## Contributing

If you'd like to contribute:

1. Fork the repo
2. Create a feature branch
3. Run tests and `flutter analyze`
4. Open a PR with a short description of the change