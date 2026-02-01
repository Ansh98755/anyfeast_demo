import 'package:anyfeast_demo/food_restrictions_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DietType {
  all,
  veg,
  nonVeg,
  eggetarian,
  vegan,
  jain,
  keto,
  paleo,
  glutenFree,
  dairyFree,
  lowCarb,
  highProtein,
  mediterranean,
}

class DietPlanScreen extends StatefulWidget {
  const DietPlanScreen({super.key});

  @override
  State<DietPlanScreen> createState() => _DietPlanScreenState();
}

class _DietPlanScreenState extends State<DietPlanScreen>
    with SingleTickerProviderStateMixin {
  final Set<DietType> selectedDiets = {};

  late AnimationController _ctaController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    _ctaController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _ctaController.dispose();
    super.dispose();
  }

  void _onDietTap(DietType diet) {
    setState(() {
      if (diet == DietType.all) {
        if (selectedDiets.contains(DietType.all)) {
          selectedDiets.clear();
        } else {
          selectedDiets
            ..clear()
            ..add(DietType.all);
        }
      } else {
        selectedDiets.remove(DietType.all);
        if (!selectedDiets.add(diet)) {
          selectedDiets.remove(diet);
        }
      }
    });

    if (selectedDiets.isNotEmpty) {
      _ctaController.forward();
    } else {
      _ctaController.reverse();
    }
  }

  bool get canContinue => selectedDiets.isNotEmpty;

  String get helperText {
    if (selectedDiets.contains(DietType.all)) {
      return "You’re open to all cuisines 🍽️";
    }
    return "Selected ${selectedDiets.length} preference(s)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Diet Preferences",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  "What kind of food do you enjoy?",
                  style: TextStyleConstants.dmsans6A14W600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    helperText,
                    key: ValueKey(helperText),
                    style: TextStyleConstants.quickSand14W700,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          /// 🌈 DIET GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _dietOptions.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final option = _dietOptions[index];
                final isSelected = selectedDiets.contains(option.type);

                return _AnimatedDietTile(
                  option: option,
                  isSelected: isSelected,
                  onTap: () => _onDietTap(option.type),
                );
              },
            ),
          ),

          /// 🚀 CTA BUTTON (animated in)
          SizeTransition(
            sizeFactor:
            CurvedAnimation(parent: _ctaController, curve: Curves.easeOut),
            axisAlignment: -1,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
              child: ElevatedButton(
                onPressed: canContinue
                    ? () {
                  debugPrint("Selected diets: $selectedDiets");

                  /// 👉 NAVIGATION
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FoodRestrictionsScreen(),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: ColorConstants.colorDEFD7C,
                  side: BorderSide(color: ColorConstants.color333333),
                ),
                child: Text(
                  "Continue",
                  style: TextStyleConstants.quickSand14W700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🌟 Animated diet tile
class _AnimatedDietTile extends StatelessWidget {
  final _DietOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnimatedDietTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isSelected
                ? ColorConstants.colorDEFD7C.withOpacity(0.35)
                : ColorConstants.color8E8E93.withOpacity(0.08),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.blue.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ]
                : [],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(option.emoji, style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 8),
                Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.quickSand14W700,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1 : 0,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    child: Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _DietOption {
  final DietType type;
  final String label;
  final String emoji;

  const _DietOption(this.type, this.label, this.emoji);
}

/// 📋 All diet options
const List<_DietOption> _dietOptions = [
  _DietOption(DietType.all, "All", "🍽️"),
  _DietOption(DietType.veg, "Veg", "🥦"),
  _DietOption(DietType.nonVeg, "Non-Veg", "🍗"),
  _DietOption(DietType.eggetarian, "Egg", "🥚"),
  _DietOption(DietType.vegan, "Vegan", "🌱"),
  _DietOption(DietType.jain, "Jain", "🙏"),
  _DietOption(DietType.keto, "Keto", "🥩"),
  _DietOption(DietType.paleo, "Paleo", "🔥"),
  _DietOption(DietType.glutenFree, "Gluten-Free", "🚫🌾"),
  _DietOption(DietType.dairyFree, "Dairy-Free", "🥛❌"),
  _DietOption(DietType.lowCarb, "Low-Carb", "⬇️🍞"),
  _DietOption(DietType.highProtein, "High-Protein", "💪"),
  _DietOption(DietType.mediterranean, "Mediterranean", "🫒"),
];

/// 🔜 Dummy next screen (replace with real one)
class NextOnboardingScreen extends StatelessWidget {
  const NextOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Next Onboarding Step")),
    );
  }
}
