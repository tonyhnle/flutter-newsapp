# NewsFeed App

## Description
The NewsFeed app is a mobile application built using Google Flutter. It allows users to view a list of posts, add new posts with text and images, like/unlike posts, and add/view comments on posts. The app uses Firebase for backend services and Hive for local data persistence.

## Features
- **View Newsfeed**: Displays a list of posts with user’s name, post content, timestamp, like count, and like button.
- **Add New Post**: Users can add text content and images. New posts appear at the top of the newsfeed.
- **Like Post**: Users can like/unlike posts. The like count updates accordingly.
- **Comments**: Users can add and view comments on posts.
- **Data Persistence**: Saves posts and like counts locally using Hive. Data remains available after the app is closed and reopened.
- **User Interface**: Utilizes Flutter’s Material Design components for a clean and intuitive UI.

## Requirements
- Flutter SDK
- Dart
- Android Studio with an emulator (Pixel 8 API 35)

## Setup Instructions

### Prerequisites
1. **Flutter SDK**: Install the Flutter SDK from [here](https://flutter.dev/docs/get-started/install).
2. **Android Studio**: Download and install Android Studio from [here](https://developer.android.com/studio).

### Installation
1. **Clone the Repository**:
    ```sh
    git clone <repository-url>
    cd news_app
    ```

2. **Install Dependencies**:
    ```sh
    flutter pub get
    ```

3. **Firebase Setup**:
    - The `google-services.json` file is already included in the `android/app` directory.
    - Ensure your `build.gradle` files are configured correctly with Firebase dependencies.

4. **Generate Hive Adapters**:
    ```sh
    flutter pub run build_runner build
    ```

### Running the App
1. **Open the Project in Android Studio**:
    - Open Android Studio and select `Open an Existing Project`.
    - Navigate to the cloned repository and open it.

2. **Run the Emulator**:
    - In Android Studio, create a new virtual device (Pixel 8 API 35) if you don't have one.
    - Start the emulator.

3. **Run the App**:
    - In Android Studio, click the `Run` button.
    - Alternatively, use the terminal:
        ```sh
        flutter run
        ```

### Design Choices
- **State Management**: The app uses the `Provider` package for state management, ensuring a clean and efficient way to handle app state.
- **Local Storage**: Hive is used for local storage to persist data, making the app functional even when offline.
- **Backend Integration**: Firebase is integrated for backend services like storing posts and images, providing real-time updates and scalable backend support.

