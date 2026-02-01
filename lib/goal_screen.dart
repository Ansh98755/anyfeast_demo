import 'package:anyfeast_demo/target_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoalScreen extends StatefulWidget {
  final double currentWeight;

  const GoalScreen({
    super.key,
    required this.currentWeight,
  });

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  WeightGoal? selectedGoal;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Your Goal",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            Text(
              "What would you like to achieve?",
              style: TextStyleConstants.dmsans6A14W600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            _goalCard(
              goal: WeightGoal.gain,
              title: "Gain Weight",
              subtitle: "Build strength & nourishment 💪",
              icon: Icons.trending_up,
            ),

            const SizedBox(height: 16),

            _goalCard(
              goal: WeightGoal.maintain,
              title: "Maintain Weight",
              subtitle: "Stay balanced & consistent ⚖️",
              icon: Icons.horizontal_rule,
            ),

            const SizedBox(height: 16),

            _goalCard(
              goal: WeightGoal.lose,
              title: "Lose Weight",
              subtitle: "Feel lighter & more active 🏃",
              icon: Icons.trending_down,
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: selectedGoal == null
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TargetWeightScreen(
                      currentWeight: widget.currentWeight,
                      goal: selectedGoal!,
                    ),
                  ),
                );
              },
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

  /// 🎯 Goal selection card
  Widget _goalCard({
    required WeightGoal goal,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = selectedGoal == goal;

    return GestureDetector(
      onTap: () {
        if (selectedGoal != goal) {
          setState(() {
            selectedGoal = goal;
          });
        }
      },
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
