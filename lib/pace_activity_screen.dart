import 'package:anyfeast_demo/diet_plan_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Pace { fast, moderate }
enum ActivityLevel { sedentary, light }

class PaceActivityScreen extends StatefulWidget {
  const PaceActivityScreen({super.key});

  @override
  State<PaceActivityScreen> createState() => _PaceActivityScreenState();
}

class _PaceActivityScreenState extends State<PaceActivityScreen> {
  Pace? selectedPace;
  ActivityLevel? selectedActivity;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  bool get canContinue =>
      selectedPace != null && selectedActivity != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Your Lifestyle",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text(
              "Let’s personalize your plan",
              style: TextStyleConstants.dmsans6A14W600,
            ),

            const SizedBox(height: 28),

            /// ⚡ PACE SECTION
            Text(
              "How fast do you want to go?",
              style: TextStyleConstants.quickSand14W700,
            ),
            const SizedBox(height: 12),

            _optionCard(
              isSelected: selectedPace == Pace.fast,
              title: "Fast & Steady",
              subtitle: "Quicker progress with commitment 🚀",
              icon: Icons.flash_on,
              onTap: () => setState(() {
                selectedPace = Pace.fast;
              }),
            ),

            const SizedBox(height: 12),

            _optionCard(
              isSelected: selectedPace == Pace.moderate,
              title: "Moderate",
              subtitle: "Slow, steady & sustainable 🌱",
              icon: Icons.timeline,
              onTap: () => setState(() {
                selectedPace = Pace.moderate;
              }),
            ),

            const SizedBox(height: 32),

            /// 🧍 ACTIVITY SECTION
            Text(
              "How active are you?",
              style: TextStyleConstants.quickSand14W700,
            ),
            const SizedBox(height: 12),

            _optionCard(
              isSelected: selectedActivity == ActivityLevel.sedentary,
              title: "Sedentary",
              subtitle: "Mostly sitting, little movement 🪑",
              icon: Icons.event_seat,
              onTap: () => setState(() {
                selectedActivity = ActivityLevel.sedentary;
              }),
            ),

            const SizedBox(height: 12),

            _optionCard(
              isSelected: selectedActivity == ActivityLevel.light,
              title: "Lightly Active",
              subtitle: "Some walking or light activity 🚶",
              icon: Icons.directions_walk,
              onTap: () => setState(() {
                selectedActivity = ActivityLevel.light;
              }),
            ),

            const SizedBox(height: 32),

            /// ▶️ CONTINUE
            ElevatedButton(
              onPressed: canContinue
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DietPlanScreen(),
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

  /// 🧩 Reusable option card
  Widget _optionCard({
    required bool isSelected,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? ColorConstants.colorDEFD7C.withOpacity(0.25)
              : ColorConstants.color8E8E93.withOpacity(0.08),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.blue.withOpacity(0.15)
                    : Colors.grey.withOpacity(0.15),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleConstants.quickSand14W700,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyleConstants.dmsans6A14W600,
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
