# shopping_app
simplified version of a shopping app interface using Flutter. </br>
This app will feature a main screen with multiple sections, displaying products, hot offers and recently purchased  products
## Widget we used 
- Scaffold to contain different widgets
- Text to show certain text
- PageView to show image of products
- GridView to show # items in rows (card Widget),
- List View to show offers
- Sized Box to add a space
- Divider to separate page view from Grid view

  #  Create signUp page
  make signup page to access the shopping screen
  ## Widget we used 
- Form to validate text form fields
- Text Form Field to take data from user
- Elevated button which when all data validated , navigate to main screen.
- Dialog to show it if data validated

  # Localization
  - use package easy localization
  - add two files json for languages
  - initialize package in main file
  - change text to apply change of language
  # animation
  - use package flutter animate
  - use extension method to animate login screen and home screen

# auth
Add firbase authentication to app & add login page.
# biometric authentication
 use that permission to andorid 
 ```bash
    <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
 ```
we use the `local_auth` plugin to implement biometric authentication.
* The `_authenticate()` function uses `auth.authenticate()` to prompt the user to scan their fingerprint. 
* The `biometricOnly: true` option ensures that only biometric authentication (fingerprint, Face ID) is used.
* The profile icon in actions of the app bar, when pressed.if authentication is successful, the app navigates to the `ProfilePage`. 

---
## APP Video Demo
[ Click here to watch ](https://github.com/user-attachments/assets/36c1c5c1-8f77-4ba8-9c28-465300e4758f)





## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An IDE (e.g., Android Studio, VS Code) with Flutter and Dart plugins installed.

### Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Hanan-Mosa/shopping_app.git
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the App**:

   ```bash
   flutter run
   ```

---

## Dependencies
  
- [firebase_core ](https://pub.dev/packages/firebase_core): To make project support Firbase.
- [firebase_auth](https://pub.dev/packages/firebase_auth): to support authentication.
- [local_auth](https://pub.dev/packages/local_auth): to add authentication with biometrics such as fingerprint or facial recognition

---
  
  
  
  
