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
cd path\to\project
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


## UI Preview 📸

<table>
  <tr>
    <th>Welcome Screen</th>
    <th>Signup</th>
    <th>Login</th>
  </tr>
  <tr>
    <td valign="top"><img src="https://github.com/user-attachments/assets/f1563066-8866-4aff-824d-91d49dd2493b" /></td>
    <td valign="top"><img src="https://github.com/user-attachments/assets/5f98b11a-6018-4944-960e-5a758211fb26" /></td>
    <td valign="top"><img src="https://github.com/user-attachments/assets/02b1bf23-63dd-4d2a-a7bb-b43b4a108a90" /></td>
  </tr>
  <tr>
    <th>Home</th>
    <th>Bookmarks</th>
    <th>Recipe Details</th>
  </tr>
  <tr>
    <td valign="top"><img src="https://github.com/user-attachments/assets/27677af2-92d0-428b-885d-be3afe5357d1" /></td>
    <td valign="top"><img src="https://github.com/user-attachments/assets/91ea5868-e185-4966-a823-c092a46bc6b9" /></td>
    <td valign="top"><img src="https://github.com/user-attachments/assets/6f57c435-5034-41b6-b112-d02ac05f962e" /></td>
   </tr>
</table>

---

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
