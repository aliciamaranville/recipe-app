import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/recipe_list.dart';

class ExpandedRecipeView extends StatelessWidget {
  final RecipeList recipe;

  const ExpandedRecipeView(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: recipe.image.image,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: GoogleFonts.dmSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    children: recipe.keywords.map((keyword) {
                      return Chip(
                        label: Text(
                          keyword,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.pink[100],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.pink[200]),
                      const SizedBox(width: 8),
                      Text(
                        'Prep Time: ${recipe.preptime}',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.timer, color: Colors.pink[200]),
                      const SizedBox(width: 8),
                      Text(
                        'Cook Time: ${recipe.cooktime}',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Ingredients',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• 2 cups flour\n• 1 cup sugar\n• 1 tsp baking powder\n• 1/2 cup milk\n• 2 eggs\n• 1/2 cup butter\n• 1 tsp vanilla extract\n• 1/2 tsp salt',
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Instructions',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '1. Preheat oven to 350°F\n2. Mix dry ingredients in a large bowl\n3. Add wet ingredients and mix until smooth\n4. Pour batter into prepared pan\n5. Bake for 30-35 minutes\n6. Let cool before serving',
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Nutrition Information',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Calories: 250\nProtein: 5g\nCarbs: 35g\nFat: 10g',
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 