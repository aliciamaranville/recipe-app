import 'package:flutter/cupertino.dart';

class RecipeList {
  final String name;
  final List<String> keywords;
  final String preptime;
  final String cooktime;
  final Image image;
  final List<String> macros;
  final String ingredients;
  final String instructions;

  RecipeList({
    required this.name,
    required this.keywords,
    required this.preptime,
    required this.cooktime,
    required this.image,
    required this.macros,
    required this.ingredients,
    required this.instructions,
  });
}

final List<RecipeList> recipes = [
  RecipeList(
    name: 'Mediterranean Turkey Burger Bowls',
    keywords: ['High Protein', 'Low Carb', 'Whole Foods'],
    preptime: '15 mins',
    cooktime: '40 mins',
    image: Image.asset('assets/images/turkey-burger.png'),
    macros: ['450 calories', '35g protein', '40g carbs', '15g fat'],
    ingredients:
      '• 1 lb ground turkey\n'
      '• 1 cup quinoa (cooked)\n'
      '• 1 cup mixed salad greens\n'
      '• 1/2 cup cherry tomatoes, halved\n'
      '• 1/4 cup sliced red onions\n'
      '• 2 tbsp olive oil\n'
      '• 1 tbsp lemon juice\n',
    instructions:
      '1. In a skillet, cook turkey until browned.\n'
      '2. Combine cooked quinoa, salad greens, tomatoes, and onions in a bowl.\n'
      '3. Top the salad with cooked turkey.\n'
      '4. Drizzle with olive oil and lemon juice, then season.\n'
  ),
  RecipeList(
    name: 'Copycat Starbucks Spinach Feta Wrap',
    keywords: ['Low Calorie', 'Healthy Breakfast'],
    preptime: '9 mins',
    cooktime: '12 mins',
    image: Image.asset('assets/images/spinach-wrap.png'),
    macros: ['320 calories', '20g protein', '30g carbs', '10g fat'],
    ingredients:
      '• 1 large whole wheat tortilla\n'
      '• 1 cup fresh spinach\n'
      '• 1/2 cup crumbled feta cheese\n'
      '• 1/4 cup roasted red peppers\n'
      '• 1/4 cup hummus\n',
    instructions:
      '1. Spread hummus evenly on the tortilla.\n'
      '2. Layer spinach, feta, and roasted red peppers.\n'
      '3. Season with a pinch of salt and pepper.\n'
      '4. Roll tightly and slice in half.\n'
  ),
  RecipeList(
    name: 'Fresh Spring Rolls with Peanut Sauce',
    keywords: ['Vegan', 'Gluten Free'],
    preptime: '40 mins',
    cooktime: '5 mins',
    image: Image.asset('assets/images/spring-rolls.png'),
    macros: ['250 calories', '8g protein', '35g carbs', '9g fat'],
    ingredients:
      '• Rice paper wrappers\n'
      '• 1 cup shredded lettuce\n'
      '• 1 cup julienned vegetables (carrots, bell peppers, cucumbers)\n'
      '• 1/2 cup fresh mint leaves\n'
      '• 1/2 cup rice noodles\n'
      '• Optional protein: tofu or shrimp',
    instructions:
      '1. Soak rice paper until soft.\n'
      '2. Arrange lettuce, vegetables, mint, and noodles in the center.\n'
      '3. Roll tightly, folding in the sides.\n'
      '4. Serve with peanut sauce for dipping.\n'
  ),
  RecipeList(
    name: 'Lighter Classic Chicken Salad',
    keywords: ['High Protein', 'Low Carb', 'Quick and Easy'],
    preptime: '5 mins',
    cooktime: '5 mins',
    image: Image.asset('assets/images/chicken-salad.png'),
    macros: ['350 calories', '40g protein', '20g carbs', '12g fat'],
    ingredients:
      '• 2 cups cooked, shredded chicken breast\n'
      '• 1/2 cup diced celery\n'
      '• 1/4 cup diced red grapes\n'
      '• 1/4 cup plain Greek yogurt\n'
      '• 1 tbsp light mayonnaise\n'
      '• Mixed greens for serving',
    instructions:
      '1. In a bowl, combine chicken, celery, and grapes.\n'
      '2. Mix Greek yogurt with light mayonnaise, salt, and pepper.\n'
      '3. Toss chicken mixture with the dressing.\n'
      '4. Serve on a bed of mixed greens.',
  ),
  RecipeList(
    name: 'Salmon with Mango Salsa and Coconut Rice',
    keywords: ['Restaurant Quality', 'Seafood'],
    preptime: '30 mins',
    cooktime: '26 mins',
    image: Image.asset('assets/images/salmon.png'),
    macros: ['600 calories', '30g protein', '55g carbs', '20g fat'],
    ingredients:
      '• 2 salmon fillets\n'
      '• 1 cup coconut rice (cooked)\n'
      '• 1 ripe mango, diced\n'
      '• 1/4 cup red bell pepper, diced\n'
      '• 2 tbsp chopped cilantro\n'
      '• 1 tbsp lime juice\n'
      '• Salt and pepper to taste',
    instructions:
      '1. Season salmon with salt and pepper and grill until cooked.\n'
      '2. In a bowl, combine mango, red bell pepper, cilantro, and lime juice to make salsa.\n'
      '3. Serve salmon on top of coconut rice with a generous spoonful of mango salsa.',
  ),
  RecipeList(
    name: 'Healthy Banana Brownies',
    keywords: ['Gluten Free', 'Dessert', 'Fan Favorite'],
    preptime: '10 mins',
    cooktime: '20 mins',
    image: Image.asset('assets/images/banana-brownies.png'),
    macros: ['300 calories', '6g protein', '40g carbs', '12g fat'],
    ingredients:
      '• 2 cups whole wheat flour\n'
      '• 1 cup coconut sugar\n'
      '• 1 tsp baking powder\n'
      '• 1/2 cup unsweetened applesauce\n'
      '• 2 ripe bananas, mashed\n'
      '• 1/4 cup cocoa powder\n'
      '• 1/3 cup melted coconut oil\n'
      '• 1 tsp vanilla extract\n'
      '• 1/2 tsp salt',
    instructions:
      '1. Preheat oven to 350°F.\n'
      '2. In a bowl, mix flour, coconut sugar, baking powder, cocoa, and salt.\n'
      '3. Add applesauce, mashed bananas, coconut oil, and vanilla extract; mix until smooth.\n'
      '4. Pour batter into a greased pan.\n'
      '5. Bake for 25-30 minutes.\n'
  ),
  RecipeList(
    name: 'Overnight Oats',
    keywords: ['Vegan', 'Customizable', 'Meal Prep'],
    preptime: '5 mins',
    cooktime: 'Overnight',
    image: Image.asset('assets/images/oatmeal.png'),
    macros: ['350 calories', '10g protein', '50g carbs', '8g fat'],
    ingredients:
      '• 1/2 cup rolled oats\n'
      '• 1/2 cup almond milk\n'
      '• 1/4 cup Greek yogurt\n'
      '• 1 tbsp chia seeds\n'
      '• 1 tbsp honey\n'
      '• 1/2 cup mixed berries',
    instructions:
      '1. Combine oats, almond milk, Greek yogurt, chia seeds, and honey in a jar.\n'
      '2. Stir well, then top with mixed berries.\n'
      '3. Refrigerate overnight.\n'
      '4. In the morning, stir and enjoy cold or warmed up.',
  ),
];
