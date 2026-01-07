# Tic Tac Toe

A Flutter implementation of the classic Tic-Tac-Toe game with Human vs CPU gameplay.

## Features

- Play against an unbeatable AI opponent (minimax algorithm)
- Clean, modern Material 3 UI
- Dark mode support
- Animated game interactions
- Win detection with visual feedback

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                 # Core utilities and abstractions
│   └── usecases/         # UseCase base class
├── domain/               # Business logic layer
│   ├── entities/         # Business entities (Player, Board, GameState)
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Application use cases
├── data/                 # Data layer
│   └── repositories/     # Repository implementations
├── presentation/         # UI layer
│   ├── bloc/             # BLoC state management
│   ├── pages/            # Screen widgets
│   └── widgets/          # Reusable UI components
└── injection/            # Dependency injection setup
```

### Key Technologies

- **State Management**: flutter_bloc
- **Dependency Injection**: get_it + injectable
- **Architecture Pattern**: Clean Architecture with BLoC

## Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK (3.x)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

```bash
flutter run
```

### Running Tests

```bash
flutter test
```

## Game Rules

- Player (X) always goes first
- Tap on an empty cell to make your move
- The CPU (O) will respond automatically
- First to get 3 in a row (horizontal, vertical, or diagonal) wins
- If all cells are filled with no winner, it's a draw

## AI Implementation

The CPU opponent uses the **Minimax algorithm**, making it an unbeatable opponent. The AI evaluates all possible game states and chooses the optimal move to either win or force a draw.
