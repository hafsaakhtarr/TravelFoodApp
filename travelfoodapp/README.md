# 🍽️ Travel Food Recommendation App

## 📌 Overview
The Travel Food Recommendation App is a Flutter-based application designed to help users discover restaurants based on their dietary preferences and cuisine interests. The app provides a smooth user experience from onboarding to personalized recommendations and favorite selection.

---

## 🎯 Key Features

- Splash screen with loading state  
- Onboarding screen for selecting dietary and cuisine preferences  
- Home screen displaying restaurant recommendations  
- Favorites feature to save preferred restaurants  
- Search functionality for filtering restaurants  
- Bottom navigation for easy screen transitions  

---

## 🛠️ Technologies Used

- **Flutter** – Cross-platform UI development  
- **Dart** – Programming language  
- **SQLite / Local Storage** – Data persistence  
- **Git & GitHub** – Version control and collaboration  

---

## 🧩 App Structure

The application follows a modular structure:

- **models** → Defines data structures (e.g., Restaurant)  
- **screens** → Contains UI screens (Splash, Onboarding, Home, Favorites)  
- **widgets** → Reusable UI components (e.g., RestaurantCard)  
- **data** → Handles sample data and database logic  

---

## 🔄 State Management

The app uses `setState` for managing UI updates.  
This approach is suitable for localized interactions such as:
- toggling favorite restaurants  
- updating UI based on user input  

It ensures immediate UI updates while keeping the implementation simple.

---

## 💾 Data Persistence (CRUD)

The app supports basic CRUD operations for managing favorite restaurants:

- **Create** → Add restaurant to favorites  
- **Read** → Load and display saved favorites  
- **Update** → Toggle favorite status  
- **Delete** → Remove restaurant from favorites  

These operations ensure that user preferences are maintained and reflected correctly in the UI.

---

## 🔀 Version Control

The project uses GitHub for version control with a structured workflow:

- Feature branching (e.g., `mandhara-ui`)  
- Independent development of features  
- Pull requests for safe merging  
- Meaningful commit messages  

This approach improves collaboration and code stability.

---

## 🧪 Testing

- Manual testing was performed for UI flow and navigation  
- Widget testing implemented for splash screen behavior  
- Verified state updates and UI interactions  

---

## 👩‍💻 Team Members

- **Mandhara Bhushan** – UI Design, Navigation, State Management  
- **[Teammate Name]** – Database, Search, Backend Logic  

---

## ▶️ How to Run the App

1. Clone the repository:
git clone <https://github.com/hafsaakhtarr/TravelFoodApp.git>


2. Navigate to the project folder:

cd TravelFoodApp


3. Install dependencies:

flutter pub get


4. Run the application:

flutter run


---

## 📌 Conclusion

This project demonstrates the implementation of a Flutter-based application with responsive UI design, efficient state management, and local data persistence. It highlights key concepts such as cross-platform development, modular architecture, and collaborative version control.