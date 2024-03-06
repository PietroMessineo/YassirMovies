# YassirMoviesApp Documentation

## Overview
YassirMoviesApp is a Swift-based iOS application that provides users with the ability to browse, search, and view detailed information about movies. The app leverages The Movie Database (TMDB) API to fetch movies data. This documentation covers the app's architecture, setup instructions, and more.

## Architecture
The app is structured into several key components:

- **Views**: UI components for displaying content to the user.
    - `CarouselView.swift`: Displays a scrolling list of featured movies.
    - `HomeView.swift`: The main view where users land, featuring movie categories and a search bar.
    - `MovieDetailView.swift`: Shows detailed information about a specific movie.
    - `SearchView.swift`: Allows users to search for movies, actors, shows based on keywords.
- **Networking**: Handles API requests and responses.
    - `HTTPClient.swift`: Core networking client for making HTTP requests.
    - `TmdbEndpoint.swift`: Defines the endpoints for TMDB API requests.
    - `TmdbService.swift`: Service layer for fetching data from TMDB API.
    - `MockTmdbService.swift`: Mock service for testing without actual API calls.
- **Utilities and Managers**:
    - `TmdbManager.swift`: Manages interactions between the UI and networking layers, serving as a facade for data fetching.
- **App Entry Point**:
    - `YassirMoviesApp.swift`: The starting point of the application, setting up the main view.

## Setup Instructions

1. **Clone the Repository**
    ```
    git clone https://github.com/PietroMessineo/YassirMovies
    cd YassirMoviesApp
    ```
2. **Install Dependencies**
    - Dependencies should install automagically via SPM
3. **API Key Configuration**
    - Obtain an API key from TMDB and add it to the appropriate place in `TmdbManager.swift` - In our case we already specified it.
4. **Build and Run**
    - Open `YassirMoviesApp.xcworkspace` in Xcode.
    - Select a simulator or a connected iOS device (for connected device you need to have Team).
    - Hit the Run button or `Cmd + R` to build and run the app.

## Testing
- Run unit and UI tests in Xcode by selecting the test navigator and hitting the play button next to each test suite.
