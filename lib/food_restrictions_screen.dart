import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'lifestyle_preference_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FoodRestriction {
  peanuts,
  dairy,
  gluten,
  shellfish,
  soy,
  eggs,
  seafood,
  mushrooms,
  brinjal,
  broccoli,
  spinach,
  olives,
  coconut,
}

class FoodRestrictionsScreen extends StatefulWidget {
  const FoodRestrictionsScreen({super.key});

  @override
  State<FoodRestrictionsScreen> createState() =>
      _FoodRestrictionsScreenState();
}

class _FoodRestrictionsScreenState extends State<FoodRestrictionsScreen> {
  final Set<FoodRestriction> selected = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  bool get canContinue => selected.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Food Preferences",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text(
              "Any allergies or foods you avoid?",
              style: TextStyleConstants.dmsans6A14W600,
            ),

            const SizedBox(height: 6),

            Text(
              "We’ll make sure to keep them off your plate 🚫🍽️",
              style: TextStyleConstants.quickSand14W700,
            ),

            const SizedBox(height: 28),

            /// 🚨 ALLERGIES
            _sectionTitle("Allergies"),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _allergyOptions.map(_animatedChip).toList(),
            ),

            const SizedBox(height: 32),

            /// 😖 DISLIKES
            _sectionTitle("Foods you dislike"),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _dislikeOptions.map(_animatedChip).toList(),
            ),

            const SizedBox(height: 40),

            /// ▶️ CONTINUE
            ElevatedButton(
              onPressed: canContinue
                  ? () {
                debugPrint("Restrictions: $selected");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LifestylePreferencesScreen(),
                  ),
                );
              }
                  : null,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 50),
                ),
                backgroundColor:
                MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ColorConstants.colorDEFD7C.withOpacity(0.4);
                  }
                  return ColorConstants.colorDEFD7C;
                }),
                side: MaterialStateProperty.all(
                  BorderSide(color: ColorConstants.color333333),
                ),
              ),
              child: Text(
                "Continue",
                style: TextStyleConstants.quickSand14W700,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 🧩 Animated chip
  Widget _animatedChip(_FoodOption option) {
    final bool isSelected = selected.contains(option.type);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!selected.add(option.type)) {
            selected.remove(option.type);
          }
        });
      },
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected
                ? Colors.red.withOpacity(0.15)
                : ColorConstants.color8E8E93.withOpacity(0.08),
            border: Border.all(
              color: isSelected ? Colors.red : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.red.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(option.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                option.label,
                style: TextStyleConstants.quickSand14W700,
              ),
              AnimatedOpacity(
                opacity: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyleConstants.quickSand14W700,
    );
  }
}

/// 🍽️ Food option model
class _FoodOption {
  final FoodRestriction type;
  final String label;
  final String emoji;

  const _FoodOption(this.type, this.label, this.emoji);
}

/// 🚨 Allergy options
const List<_FoodOption> _allergyOptions = [
  _FoodOption(FoodRestriction.peanuts, "Peanuts", "🥜"),
  _FoodOption(FoodRestriction.dairy, "Dairy", "🥛"),
  _FoodOption(FoodRestriction.gluten, "Gluten", "🌾"),
  _FoodOption(FoodRestriction.shellfish, "Shellfish", "🦐"),
  _FoodOption(FoodRestriction.soy, "Soy", "🫘"),
  _FoodOption(FoodRestriction.eggs, "Eggs", "🥚"),
  _FoodOption(FoodRestriction.seafood, "Seafood", "🐟"),
];

/// 😖 Disliked foods
const List<_FoodOption> _dislikeOptions = [
  _FoodOption(FoodRestriction.mushrooms, "Mushrooms", "🍄"),
  _FoodOption(FoodRestriction.brinjal, "Brinjal", "🍆"),
  _FoodOption(FoodRestriction.broccoli, "Broccoli", "🥦"),
  _FoodOption(FoodRestriction.spinach, "Spinach", "🥬"),
  _FoodOption(FoodRestriction.olives, "Olives", "🫒"),
  _FoodOption(FoodRestriction.coconut, "Coconut", "🥥"),
];

/// 🔜 Dummy next screen
class NextOnboardingScreen extends StatelessWidget {
  const NextOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Next Onboarding Step")),
    );
  }
}
