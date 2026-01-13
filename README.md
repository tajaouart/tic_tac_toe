# Tic Tac Toe

A Flutter implementation of the classic Tic-Tac-Toe game with Human vs CPU gameplay.

<p align="center">
  <img src="https://raw.githubusercontent.com/tajaouart/tic_tac_toe/main/screenshot.png" alt="Tic Tac Toe Screenshot" width="300"/>
</p>

## Features

- **3 Difficulty Levels**: Easy (random moves), Medium (smart play), Hard (unbeatable minimax)
- **Player Profile**: Customizable player name
- **Statistics Tracking**: Track your wins, losses, draws, and win streaks
- **Persistent Storage**: All progress saved locally
- **Settings Page**: Configure difficulty, theme, and player name
- **Clean Material 3 UI**: Modern design with animations
- **Dark Mode Support**: System, light, or dark theme
- **Multi-language Support**: English and French with flag selector
- **Responsive Layout**: Works on mobile, tablet, and web

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                 # Core utilities and abstractions
│   ├── constants/        # App-wide constants
│   ├── error/            # Error handling (failures, exceptions, result)
│   ├── router/           # App navigation (go_router)
│   └── usecases/         # UseCase base class
├── domain/               # Business logic layer
│   ├── entities/         # Business entities (Player, Board, GameState, etc.)
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Application use cases
├── data/                 # Data layer
│   ├── repositories/     # Repository implementations
│   └── services/         # Storage service (SharedPreferences)
├── presentation/         # UI layer
│   ├── bloc/             # BLoC/Cubit state management (with Freezed)
│   ├── pages/            # Screen widgets (Game, Settings, Statistics)
│   └── widgets/          # Reusable UI components
├── shared/               # Shared utilities
│   └── utils/            # Extensions, constants
└── injection/            # Dependency injection setup (get_it + injectable)
```

### Key Technologies

- **State Management**: flutter_bloc (BLoC + Cubit) with Freezed
- **Dependency Injection**: get_it + injectable
- **Navigation**: go_router
- **Local Storage**: shared_preferences
- **Code Generation**: freezed, injectable_generator
- **Internationalization**: flutter_localizations, intl (ARB files)
- **Architecture Pattern**: Clean Architecture with BLoC

## Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK (3.x)

### Build

```bash
./build.sh
```

This will run: clean, pub get, code generation, analyze, and tests.

### Run

```bash
flutter run
```

## Screens

### Game Screen
- Play against the CPU
- See current difficulty level
- Quick access to settings and statistics

### Statistics Screen
- View your game history
- Track win rate and streaks
- See total games played

### Settings Screen
- Change player name
- Select difficulty level
- Choose theme (System/Light/Dark)
- Change language (English/French)
- Reset statistics

## AI Implementation

The CPU opponent has three difficulty modes:

- **Easy**: Makes completely random moves
- **Medium**: 50% optimal play, blocks wins, takes winning moves
- **Hard**: Uses the **Minimax algorithm** for perfect play (unbeatable)
