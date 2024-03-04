
# Weather App

This Weather App is a simple iOS application that allows users to check the latest weather forecasts for their location. It utilizes Apple's frameworks and libraries without any third-party dependencies. The app provides features such as caching weather data locally using CoreData, managing favorites, and displaying accurate weather information. Additionally, the app supports both Dark Mode and Light Mode to enhance the user experience.

## Features
- Local Caching: Weather data is cached locally using CoreData to provide offline access and improve app performance.
- Favorites Management: Users can add and remove their favorite locations to easily access weather forecasts for those locations.
- Accurate Weather Forecasts: The app fetches weather data from reliable sources to provide users with up-to-date and accurate weather information.
- Pagination: Pagination is implemented for efficient data loading, ensuring smooth navigation and performance when browsing through weather forecasts.
- Dark Mode and Light Mode Support: The app seamlessly adapts to the user's preferred appearance, providing a comfortable viewing experience in both Dark Mode and Light Mode.
- Apple Frameworks: The app is built entirely using Apple's frameworks and libraries, ensuring reliability and compatibility with iOS devices.

## App Requirements
- iOS 13.0+
- Xcode 11.0+
- Swift 5.0


## Screenshots

### Light
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/e8e4e6f2-f65a-4be0-9cda-3893bd21d834" width=400/>
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/6e7c5760-e226-4909-a255-3dad24b15fe2" width=400/>
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/ac38356d-6b0c-4ab3-b388-fedee7ffc435" width=400/>

### Dark
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/64fba0f8-e53d-4150-a6b6-0c19265f9757" width=400/>
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/1f56d3c3-aae9-40b7-b012-ba06c8f64ef8" width=400/>
<img src="https://github.com/mkemalgokce/PSWeatherApp/assets/46056478/12af3a8c-7549-4c14-a2e7-f184033e4cac" width=400/>

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

## Scheme Images:

### Loader
<img src="https://github.com/mkemalgokce/PSWeatherApp/blob/main/Images/LoaderDrawing.png" width=400/>

### Screens
<img src="https://github.com/mkemalgokce/PSWeatherApp/blob/main/Images/PSWeatherScreens.png" width=400/>


### Cache
<img src="https://github.com/mkemalgokce/PSWeatherApp/blob/main/Images/PSWeather.png" width=400/>
