import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> _allCuisines = [
    'Italian', 'Mexican', 'Japanese', 'Chinese', 'Indian',
    'Thai', 'French', 'Mediterranean', 'American', 'Korean'
  ];
  final List<String> _allDietaryPreferences = [
    'Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free',
    'Keto', 'Paleo', 'Pescatarian', 'Low-Carb'
  ];
  final List<String> _cookingTimeRanges = [
    '0-15 minutes',
    '15-30 minutes',
    '30-60 minutes',
    '60+ minutes'
  ];
  int _selectedTimeIndex = 2; 

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _rememberMe = false;
  String? _emailError;
  String? _nameError;
  
  @override
  void initState() {
    super.initState();
    _selectedTimeIndex = _cookingTimeRanges.indexOf(
      context.read<MyAppState>().preferredCookingTime
    );
    if (_selectedTimeIndex == -1) _selectedTimeIndex = 2;

    final appState = context.read<MyAppState>();
    if (appState.isLoggedIn && appState.rememberMe) {
      _nameController.text = appState.userName ?? '';
      _emailController.text = appState.userEmail ?? '';
      _rememberMe = true;
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validateAndLogin(MyAppState appState) {
    final email = _emailController.text;
    final name = _nameController.text;

    if (name.isEmpty) {
      setState(() {
        _nameError = 'Please enter your name';
      });
    }

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _emailError = null;
      _nameError = null;
    });
    appState.login(name, email, remember: _rememberMe);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.dmSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (appState.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                appState.logout();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!appState.isLoggedIn) ...[
              _buildLoginSection(appState),
            ] else ...[
              const SizedBox(height: 5),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple[100],
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  appState.userName ?? 'John Doe',
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  appState.userEmail ?? 'john.doe@example.com',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 15),
              _buildPreferenceSection(
                'Favorite Cuisines',
                appState.favoriteCuisines,
                _allCuisines,
                (selected) => appState.updatePreferences(newCuisines: selected),
              ),
              const SizedBox(height: 25),
              _buildCookingTimeSection(appState),
              const SizedBox(height: 25),
              _buildPreferenceSection(
                'Dietary Preferences',
                appState.dietaryPreferences,
                _allDietaryPreferences,
                (selected) => appState.updatePreferences(newDietaryPreferences: selected),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Account Settings'),
              _buildSettingItem(Icons.lock, 'Privacy'),
              _buildSettingItem(Icons.help, 'Help & Support'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoginSection(MyAppState appState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Text(
            'Welcome to Food Finder',
            style: GoogleFonts.dmSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
              errorText: _nameError,
            ),
            onChanged: (value) {
              if (_nameError != null) {
                setState(() {
                  _nameError = null;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.email),
              errorText: _emailError,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (_emailError != null) {
                setState(() {
                  _emailError = null;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
                activeColor: Colors.purple[200],
              ),
              Text(
                'Remember Me',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _validateAndLogin(appState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[200],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Login',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
          Container(
            height: 1.5,
            width: double.infinity,
            color: Colors.grey[600] 
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceSection(
    String title,
    List<String> currentPreferences,
    List<String> allOptions,
    Function(List<String>) onUpdate,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: allOptions.map((option) {
            final isSelected = currentPreferences.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                final newPreferences = List<String>.from(currentPreferences);
                if (selected) {
                  newPreferences.add(option);
                } else {
                  newPreferences.remove(option);
                }
                onUpdate(newPreferences);
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.purple[100],
              checkmarkColor: Colors.purple,
              labelStyle: GoogleFonts.dmSans(
                color: isSelected ? Colors.purple : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCookingTimeSection(MyAppState appState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Cooking Time',
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.purple[200],
            inactiveTrackColor: Colors.grey[200],
            thumbColor: Colors.purple,
            overlayColor: Colors.purple.withOpacity(0.1),
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: Column(
            children: [
              Slider(
                value: _selectedTimeIndex.toDouble(),
                min: 0,
                max: _cookingTimeRanges.length - 1,
                divisions: _cookingTimeRanges.length - 1,
                label: _cookingTimeRanges[_selectedTimeIndex],
                onChanged: (value) {
                  setState(() {
                    _selectedTimeIndex = value.round();
                  });
                  appState.updatePreferences(
                    newCookingTime: _cookingTimeRanges[_selectedTimeIndex],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _cookingTimeRanges.map((time) {
                    return Text(
                      time,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple[200]),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
} 