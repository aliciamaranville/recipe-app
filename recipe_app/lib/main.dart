import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/recipe_list.dart';
import 'package:recipe_app/flip_recipe_card.dart';
import 'package:recipe_app/profile_page.dart';
import 'package:recipe_app/expanded_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Recipe App',
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var favorites = <FlipRecipeCard>[];
  int currentIndex = 0;
  
  // User preferences
  List<String> favoriteCuisines = ['Italian', 'Mexican', 'Japanese'];
  String preferredCookingTime = '30-60 minutes';
  List<String> dietaryPreferences = ['Vegetarian'];

  // Authentication state
  bool isLoggedIn = false;
  String? userName;
  String? userEmail;
  bool rememberMe = false;

  // Folders
  final Map<String, List<FlipRecipeCard>> folders = {
    'All Recipes': <FlipRecipeCard>[],
  };

  void addFolder(String name) {
    if (!folders.containsKey(name)) {
      folders[name] = <FlipRecipeCard>[];
      notifyListeners();
    }
  }

  void removeFolder(String name) {
    if (name != 'All Recipes' && folders.containsKey(name)) {
      // Move recipes from deleted folder to 'All Recipes'
      folders['All Recipes']!.addAll(folders[name]!);
      folders.remove(name);
      notifyListeners();
    }
  }

  void addToFolder(FlipRecipeCard recipe, String folderName) {
    if (folders.containsKey(folderName)) {
      if (!folders[folderName]!.contains(recipe)) {
        folders[folderName]!.add(recipe);
        notifyListeners();
      }
    }
  }

  void removeFromFolder(FlipRecipeCard recipe, String folderName) {
    if (folders.containsKey(folderName)) {
      folders[folderName]!.remove(recipe);
      notifyListeners();
    }
  }

  void toggleFavorite(FlipRecipeCard current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
      // Remove from all folders
      for (var folder in folders.values) {
        folder.remove(current);
      }
    } else {
      favorites.add(current);
      // Add to 'All Recipes' folder
      folders['All Recipes']!.add(current);
    }
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void updatePreferences({
    List<String>? newCuisines,
    String? newCookingTime,
    List<String>? newDietaryPreferences,
  }) {
    if (newCuisines != null) favoriteCuisines = newCuisines;
    if (newCookingTime != null) preferredCookingTime = newCookingTime;
    if (newDietaryPreferences != null) dietaryPreferences = newDietaryPreferences;
    notifyListeners();
  }

  void login(String name, String email, {bool remember = false}) {
    userName = name;
    userEmail = email;
    isLoggedIn = true;
    rememberMe = remember;
    notifyListeners();
  }

  void logout() {
    if (!rememberMe) {
      userName = null;
      userEmail = null;
    }
    isLoggedIn = false;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Food Finder",
          style: GoogleFonts.dmSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink[100]?.withOpacity(0.3),
              ),
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.favorite), text: "Favorites"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe between tabs
        children: [
          SwipingPage(),
          FavoritesPage(),
        ],
      ),
    );
  }
}


class SwipingPage extends StatefulWidget {
  const SwipingPage({
    super.key,
  });

  @override
  State<SwipingPage> createState() => _SwipingPageState();
}

class _SwipingPageState extends State<SwipingPage> {
  final CardSwiperController controller = CardSwiperController();
  final cards = recipes.map(FlipRecipeCard.new).toList();

  @override
  void initState() {
    super.initState();
    // The initialIndex will be set in the build method through context.watch
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                initialIndex: context.watch<MyAppState>().currentIndex,
                isLoop: false,
                numberOfCardsDisplayed: 2,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () { 
                      controller.swipe(CardSwiperDirection.left);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Makes the button circular
                      padding: EdgeInsets.all(16), // Adjust padding as needed
                      backgroundColor: Colors.red, // Button fill color
                    ),
                    child: Icon(Icons.close, color: Colors.white), // Regular icon
                  ),
                  ElevatedButton(
                    onPressed: () { 
                      controller.swipe(CardSwiperDirection.right);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Makes the button circular
                      padding: EdgeInsets.all(16), // Adjust padding as needed
                      backgroundColor: Colors.green, // Button fill color
                    ),
                    child: Icon(Icons.favorite, color: Colors.white), // Regular icon
                  ),
                  ElevatedButton(
                    onPressed: () { 
                      controller.undo();  // Fixed the undo call
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Makes the button circular
                      padding: EdgeInsets.all(16), // Adjust padding as needed
                    ),
                    child: Icon(Icons.rotate_left, color: Colors.black), // Regular icon
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex != null) {
      context.read<MyAppState>().setCurrentIndex(currentIndex);

      if (direction == CardSwiperDirection.right) {
        if (!context.read<MyAppState>().favorites.contains(cards[previousIndex])) {
          context.read<MyAppState>().toggleFavorite(cards[previousIndex]);
        }
      }
    }
    debugPrint(
      'Recipe $previousIndex was swiped to the ${direction.name}. Now showing recipe $currentIndex',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    context.read<MyAppState>().setCurrentIndex(currentIndex);
    debugPrint(
      'Recipe $currentIndex was undone from the ${direction.name}',
    );
    return true;
  } 
}

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _selectedFolder = 'All Recipes';
  final TextEditingController _folderNameController = TextEditingController();

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }

  void _showRecipeOptions(BuildContext context, FlipRecipeCard recipe) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Recipe Options',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Move to Folder'),
              onTap: () {
                Navigator.pop(context);
                _showMoveToFolderDialog(context, recipe);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(
                'Remove from Favorites',
                style: GoogleFonts.dmSans(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                context.read<MyAppState>().toggleFavorite(recipe);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Recipe removed from favorites'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        context.read<MyAppState>().toggleFavorite(recipe);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMoveToFolderDialog(BuildContext context, FlipRecipeCard recipe) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Move to Folder',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...context.read<MyAppState>().folders.keys.map((folderName) {
              if (folderName == _selectedFolder) return const SizedBox.shrink();
              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(folderName),
                onTap: () {
                  context.read<MyAppState>().addToFolder(recipe, folderName);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showAddFolderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'New Folder',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          controller: _folderNameController,
          decoration: InputDecoration(
            labelText: 'Folder Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _folderNameController.clear();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(
                color: Colors.grey[600],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_folderNameController.text.isNotEmpty) {
                context.read<MyAppState>().addFolder(_folderNameController.text);
                Navigator.pop(context);
                _folderNameController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
            ),
            child: Text(
              'Create',
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet.',
              style: GoogleFonts.dmSans(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...appState.folders.keys.map((folderName) {
                        final isSelected = folderName == _selectedFolder;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(folderName),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFolder = folderName;
                              });
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: Colors.pink[100],
                            checkmarkColor: Colors.pink,
                            labelStyle: GoogleFonts.dmSans(
                              color: isSelected ? Colors.pink : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.create_new_folder),
                onPressed: () => _showAddFolderDialog(context),
                color: Colors.pink[200],
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: appState.folders[_selectedFolder]?.length ?? 0,
            itemBuilder: (context, index) {
              final recipe = appState.folders[_selectedFolder]![index].recipe;
              return Dismissible(
                key: Key(recipe.name),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[400],
                  ),
                ),
                onDismissed: (direction) {
                  context.read<MyAppState>().toggleFavorite(
                    appState.folders[_selectedFolder]![index],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Recipe removed from favorites'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          context.read<MyAppState>().toggleFavorite(
                            appState.folders[_selectedFolder]![index],
                          );
                        },
                      ),
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedRecipeView(recipe),
                      ),
                    );
                  },
                  onLongPress: () {
                    _showRecipeOptions(
                      context,
                      appState.folders[_selectedFolder]![index],
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Image(
                            image: recipe.image.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Prep: ${recipe.preptime} | Cook: ${recipe.cooktime}',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}




