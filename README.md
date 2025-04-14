# Food Finder Mobile Application

Discover new recipes in a fun swipe-based interface
Food Finder helps you explore and save recipes with a simple swipe. Swipe right to save a recipe to your Favorites, or swipe left if it’s not for you.


## Features
**Swipe Discovery:** Swipe right to save recipes that interest you. Swipe left to discard recipes you don’t like.

**Favorites:** Quickly access saved recipes in a dedicated section.

**Recipe Details:** Each recipe card features key information – ingredients, cooking time, and short descriptions.

**Search & Filter:** Filter recipes by cuisine, difficulty, or dietary restrictions.

**User Profiles:** Create an account to sync favorites across devices.


## Prerequisites

To run Food Finder from source or contribute to the codebase, you’ll need:
- Flutter SDK
- Dart (comes bundled with the Flutter SDK)
- A code editor with the Flutter plugin (VSCode is recommended)
- Xcode --> For iOS device emulator
- zsh as default shell


## Installation Guide

Running the App from Source (Flutter)

1. Clone the repository

```bash
$ git clone https://github.com/aliciamaranville/food-finder.git
```

3. Create File Structure

```bash
# recipe-app needs to be nested in projects.nosync folder
aliciamaranville/projects.nosync/recipe-app
```

3. Open recipe-app in VSCode

4. Install dependencies

```bash
$ flutter pub get
```

5. Configure iOS Simulator

```bash
# To install the iOS Simulator, run the following command.
$ xcodebuild -downloadPlatform iOS

# To start the Simulator, run the following command:
$ open -a Simulator
```

7. Select whatever phone you are using on the simulator as your target device in the bottom right corner of VSCode

8. Navigate to recipe-app directory

```bash
$ cd recipe_app
```

8. Run the application

```bash
$ flutter clean && flutter pub get && flutter run
```

```
Other option to run application:

Open main Dart source code located here --> recipe_app/lib/main.dart
Click 'Run and Debug' which will build the code and open the app in the simulator flutter run
```

9. You can make changes to the code then refresh to automatically update the simulator without rebuilding every time


## Usage
1. Register or Continue as Guest.
2. Swipe Cards to explore the recipe database.
   - Swipe Right to save a recipe to your Favorites.
   - Swipe Left if it doesn’t appeal to you.
3. View Recipe Details by tapping the card or from the Favorites list.
4. Access Favorites via the Favorites icon to revisit saved recipes.
5. Search or Filter to refine recipe results.

