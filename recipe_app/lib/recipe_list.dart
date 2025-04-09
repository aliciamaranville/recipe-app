import 'package:flutter/cupertino.dart';

class RecipeList {
  final String name;
  final List<String> keywords;
  final String preptime;
  final String cooktime;
  final Image image;

  RecipeList({
    required this.name,
    required this.keywords,
    required this.preptime,
    required this.cooktime,
    required this.image,
  });
}

final List<RecipeList> recipes = [
  RecipeList(
    name: 'Mediterranean Turkey Burger Bowls',
    keywords: ['High Protien', 'Low Carb','Whole Foods'],
    preptime: '15 mins',
    cooktime: '40 mins',
    image: Image.asset('assets/images/turkey-burger.png'),
  ),
  RecipeList(
    name: 'Copycat Starbucks Spinach Feta Wrap',
    keywords: ['Low Calorie','Healthy Breakfast'],
    preptime: '9 mins',
    cooktime: '12 mins',
    image: Image.asset('assets/images/spinach-wrap.png'),
  ),
  RecipeList(
    name: 'Fresh Spring Rolls with Peanut Sauce',
    keywords: ['Vegan', 'Gluten Free'],
    preptime: '40 mins',
    cooktime: '5 mins',
    image: Image.asset('assets/images/spring-rolls.png'),
  ),
  RecipeList(
    name: 'Lighter Classic Chicken Salad',
    keywords: ['High Protien', 'Low Carb','Quick and Easy'],
    preptime: '5 mins',
    cooktime: '5 mins',
    image: Image.asset('assets/images/chicken-salad.png'),
  ),
  RecipeList(
    name: 'Salmon with Mango Salsa and Coconut Rice',
    keywords: ['Restaurant Quality', 'Seafood'],
    preptime: '30 mins',
    cooktime: '26 mins',
    image: Image.asset('assets/images/salmon.png'),
  ),
  RecipeList(
    name: 'Healthy Banana Brownies',
    keywords: ['Gluten Free', 'Dessert','Fan Favorite'],
    preptime: '10 mins',
    cooktime: '20 mins',
    image: Image.asset('assets/images/banana-brownies.png'),
  ),
  RecipeList(
    name: 'Overnight Oats',
    keywords: ['Vegan', 'Customizable','Meal Prep'],
    preptime: '5 mins',
    cooktime: 'Overnight',
    image: Image.asset('assets/images/oatmeal.png'),
  ),
];
