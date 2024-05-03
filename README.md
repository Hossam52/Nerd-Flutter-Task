# Flutter Recipes App Task (NERD)

This project is a comprehensive Flutter application for browsing, managing, and viewing recipes. It features robust offline capabilities and utilizes a clean and scalable architecture.

## Features

- **Login Screen**: Users can log in with hardcoded credentials. The screen provides feedback for both valid and invalid credentials.
- **Home Screen**:
  - Displays all recipes and favorites.
  - Users can refresh recipes manually.
  - Provides a logout option via a floating action button.
- **Recipe Details Screen**:
  - Showcases detailed information including images, headlines, ratings, nutritional details, descriptions, and cooking steps.
  - Allows users to favorite/unfavorite recipes.
  - Favorites are stored locally using Hive for offline access.
- **Offline Storage**: Recipes that users mark as favorites are saved locally, enabling offline viewing.
- **DI**: Add depndancy injection in app and use `get_it` package for handling it.

## Project Structure

The project follows a clean architecture with the following key directories:

- `lib/config`: Configuration settings and utilities.
- `lib/cubits`: State management using Cubit for different functionalities like authentication and recipe management.
- `lib/models`: Data models including the recipe model.
- `lib/screens`: UI screens for login, home, and recipe details.
- `lib/shared`: Shared resources and utilities including network and local services for API interaction and local data management.
- `lib/widgets`: Reusable widget components used across the app.

## State Management

This app uses **Cubit** for state management, providing a separate cubit for authentication and recipe operations, ensuring a clean separation of concerns and easier state management.

## Offline Storage

**Hive** is used for offline storage, specifically for storing favorite recipes locally. This allows the app to access user favorites even when offline.

## Installation

To get this project up and running on your local machine, follow these steps:

1. Clone the repository:
git clone https://github.com/Hossam52/Nerd-Flutter-Task

2. Navigate to the project directory:
cd Nerd-Flutter-Task

3. Install dependencies:
flutter pub get

4. Run the app:
flutter run


## Dependencies

This project uses several dependencies to enhance its functionality:

- `flutter_screenutil`: For responsive sizing.
- `hive` & `hive_flutter`: For local storage operations.
- `flutter_bloc`: For implementing the BLoC/Cubit pattern.
- Other UI and utility packages like `flutter_rating_bar`, `cached_network_image`, etc.

See `pubspec.yaml` for a full list of dependencies.
