# Flutter Chat Assessment

A Flutter chat application that demonstrates speech-to-text functionality with a simple bot response system. The app uses Riverpod for state management and local storage for message history by saving the conversation to SharedPreferences. This app also implements a clean architecture approach with separate data, domain, and presentation layers, so it's easier to maintain and extend.

## Features

- Speech-to-Text input for user messages
- Automated bot responses (randomly replies with "yes", "ok", or "no")
- Local message persistence using SharedPreferences
- Modern Material Design UI
- Chat history with refresh capability
- List of previous chat sessions
- State management using Riverpod

## Getting Started

### Prerequisites

- Flutter SDK (>=3.4.4)
- Dart SDK (>=3.0.0)

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the code generation:
```bash
flutter pub run build_runner build
```

3. Run the app:
```bash
flutter run
```

## How to Use

1. Launch the app
2. Tap the '+' button to start a new chat
3. Tap the microphone button and speak your message
4. The bot will automatically respond with a random answer
5. Previous chats can be accessed from the home screen
6. Pull to refresh the chat history list

## Project Structure

The project follows clean architecture principles:

- Data Layer: Handles data operations
- Domain Layer: Contains business logic
- Presentation Layer: Manages UI and state

## Dependencies

Main dependencies used in this project:
- flutter_riverpod: State management
- auto_route: Navigation
- speech_to_text: Speech recognition
- shared_preferences: Local storage
- injectable: Dependency injection

