# STT Chat App

STT Chat App is a Flutter-based application that use speech-to-text technology for communication. This project was created to fulfill the final assessment test.

## Features

- **Speech-to-Text (STT):** Convert voice input into text using the `speech_to_text` package.
- **Real-Time Chat Interface:** Chat messages appear in a user-friendly layout with bubbles.
- **Auto Reply** Chat messages sent will be automatically replied to as a dummy.
- **State Management:** Utilizes the Flutter Riverpod package for scalable and reactive state management.
- **Dependency Injection:** Implements `get_it` for better dependency management.
- **Theme Support:** Customizable themes with defined colors and styles.
- **Clean Architecture:** Structured with clear separation of concerns across layers (presentation, domain, data).

## Folder Structure
```
lib
├── core
│   ├── di                # Dependency Injection setup
│   ├── theme             # App-wide theme settings
│   └── usecase           # Reusable use case contracts
├── data
│   ├── datasources       # External data sources (e.g., STT)
│   ├── models            # Data models
│   └── repositories      # Data repository implementations
├── domain
│   ├── entities          # Core business models
│   ├── repositories      # Domain-level repository contracts
│   └── usecases          # Application-specific use cases
├── presentation
│   ├── providers         # Riverpod providers
│   ├── screens           # UI screens (e.g., HomeScreen, ChatScreen)
│   └── widgets           # Reusable UI components
└── main.dart             # App entry point
```

## Key Packages
The app uses the following Flutter packages:
- flutter_riverpod for state management.
- get_it for dependency injection.
- speech_to_text for voice recognition.
- chat_bubbles for chat UI components.

## Getting Started

Follow these steps to set up and run the project on your local machine:

### Prerequisites

- Flutter SDK (version `3.22.2` or later)
- Dart SDK
- Android Studio or Xcode for emulation
- A connected physical device or emulator

### Installation
- flutter pub get
- flutter run




