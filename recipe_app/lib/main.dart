import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/recipe_list.dart';
import 'package:recipe_app/recipe_card.dart';
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

  var favorites = <RecipeCard>[];
  int currentIndex = 0;

  void toggleFavorite(RecipeCard current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
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
          padding: const EdgeInsets.all(8.0), // Optional padding for better spacing
          child: Image.asset(
            'assets/images/logo.png', // Replace with your image path
            fit: BoxFit.contain, // Ensures the image fits well inside the AppBar
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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.favorite), text: "Favorites"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
  final cards = recipes.map(RecipeCard.new).toList();
  int currentIndex = 0;

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
                initialIndex: currentIndex,
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
                    child: Icon(Icons.close, color: Colors.white), // Icon inside
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
                    child: Icon(Icons.favorite, color: Colors.white), // Icon inside
                  ),ElevatedButton(
                    onPressed: () { 
                      controller.undo;
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Makes the button circular
                      padding: EdgeInsets.all(16), // Adjust padding as needed
                    ),
                    child: Icon(Icons.rotate_left, color: Colors.black), // Icon inside
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
    if (currentIndex != null) {  // Ensure it's a valid index
      setState(() {
        this.currentIndex = currentIndex;
      });

      if (direction == CardSwiperDirection.right) {
        context.read<MyAppState>().toggleFavorite(cards[previousIndex]);
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
    setState(() {
        this.currentIndex = currentIndex;
    });
    debugPrint(
      'Recipe $currentIndex was undone from the ${direction.name}',
    );
    return true;
  } 
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(child: Text('No favorites yet.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // This makes 2 cards per row
        crossAxisSpacing: 16, // Space between the columns
        mainAxisSpacing: 16, // Space between the rows
        childAspectRatio: 0.7, // Adjust to make the cards taller or wider as needed
      ),
      itemCount: appState.favorites.length,
      itemBuilder: (context, index) {
        return FavoritesCard(appState.favorites[index].recipe);
      },
    );
  }
}




