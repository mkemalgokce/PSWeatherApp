
# Weather App

## Requirements:

### Screens:

#### Weather List Screen:

- Display a list of weather elements fetched from the provided JSON
  data with pagination functionality.
- Each weather element should display the following parameters:
- Country
- City
- Temperature
- Weather description
- Humidity
- Wind speed
- Include a search bar at the top to allow users to search for weather information by city name.

#### Weather Details Screen:

- Display detailed weather information about a selected city from the list.
- Include a forecast section that displays weather forecasts for the next
  two days.

#### Favourite Screen:

- Display a list of cities that the user has marked as favourites.
- Allow users to add or remove cities from their favourites list.
- Users should be able to navigate to the Weather Details Screen by
  selecting a city from the favourites list.

## Bonus Features:

### Architecture:

- Implement either MVVM (Model-View-ViewModel) or VIPER
  (View-Interactor-Presenter-Entity-Router) architecture to structure your
  application.

### Offline Usage:

- Implement offline caching of weather data to allow users to view previously fetched data without an internet connection.

### Unit Tests:

- Write unit tests to ensure the reliability and correctness of your
  application's code.

### Pagination:

- Implement pagination functionality on the Weather List Screen to efficiently display large sets of data.

### Functionality:

- Implement networking to fetch weather data from the provided JSON URL: https://freetestapi.com/api/v1/weathers.
- Implement error handling to manage any issues that may occur during data fetching.
- Implement search functionality to filter weather information based on the city name entered by the user.
- Implement the ability for users to mark cities as favourites and view them on the Favourite Screen.
- Ensure the application provides a user-friendly interface with smooth navigation between screens.

## Evaluation Criteria:

Your assignment will be evaluated based on the following criteria:
Technical Implementation:

- Proper use of iOS frameworks and libraries.
- Efficient data fetching and handling.
- Proper error handling and user feedback.

### User Experience:

- Intuitive and responsive user interface.
- Smooth navigation between screens.
- Effective use of search functionality, favourites management, and
  pagination.

### Bonus Features Implementation:

- Proper implementation of the chosen architecture (MVVM or VIPER).
- Effective offline usage capabilities.
- Comprehensive unit test coverage.
- Efficient pagination of displaying data.

### Code Quality:

- Clean and well-structured code.
- Proper commenting and documentation.
- Adherence to coding best practices and standards.

## Submission:

Please submit your assignment as a complete iOS project, including all source code, resources, unit tests, and any additional documentation or instructions required to build and run the application.

> Note: This assignment is intended to assess your mobile application development skills and your ability to create a functional, user-friendly, and well-structured iOS application. Make sure to follow the requirements and evaluation criteria carefully and demonstrate your best work. Good luck!
