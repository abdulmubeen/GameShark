# GameShark

GameShark is an iOS app that helps users discover and save their favorite games. It allows users to look up game details, including game name, thumbnail, and other key information, and add them to a favorites list for quick access. Built using Core Data for local storage and integrated with a network manager for fetching game details, GameShark offers a smooth and enjoyable experience for gaming enthusiasts.

## Features

- **Game Search**: Search for games by their Steam app ID.
- **Game Details**: View detailed information about a game, including its name, thumbnail image, and other key data.
- **Favorites**: Save games to your favorites list, with the ability to check if a game is already added.
- **User-Friendly Interface**: Modern UI components that provide a clean and intuitive experience.
- **Core Data Integration**: Store favorite games locally for quick access.

## Requirements

- iOS 12.0 or later
- Xcode 12 or later
- Swift 5.0 or later

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/abdulmubeen/GameShark.git
    ```

2. Open the project in Xcode:

    ```bash
    open GameShark.xcodeproj
    ```

3. Build and run the app in the simulator or on a device.

## Core Technologies

- **UIKit**: For building the app's user interface.
- **Core Data**: For managing and persisting data locally.
- **NetworkManager**: For fetching game details from an API.
- **Swift**: Programming language used for development.

## App Architecture

The app follows a simple Model-View-Controller (MVC) pattern:
- **Model**: The data layer is managed using Core Data to persist game information.
- **View**: Views are built using UIKit and populated with data fetched via the `NetworkManager`.
- **Controller**: Each view controller manages user interactions and updates the UI accordingly.

## How It Works

1. **Game Search**: The user enters a game name and selects the game from the list, and the app fetches detailed information about the game.
2. **Add to Favorites**: Users can add a game to their favorites list, which is persisted using Core Data.
3. **View Favorites**: The favorites list is displayed in a table view, showing saved games with their name and thumbnail image.


