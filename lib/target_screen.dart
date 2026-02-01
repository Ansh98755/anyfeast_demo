import 'package:anyfeast_demo/pace_activity_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum WeightGoal { gain, maintain, lose }

class TargetWeightScreen extends StatefulWidget {
  final double currentWeight;
  final WeightGoal goal;

  const TargetWeightScreen({
    super.key,
    required this.currentWeight,
    required this.goal,
  });

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  late double targetWeight;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    /// 🎯 Default suggestion based on goal
    targetWeight = switch (widget.goal) {
      WeightGoal.gain => widget.currentWeight + 5,
      WeightGoal.lose => widget.currentWeight - 5,
      WeightGoal.maintain => widget.currentWeight,
    };
  }

  String get differenceText {
    final diff = targetWeight - widget.currentWeight;
    if (diff == 0) return "You want to stay right where you are ⚖️";
    if (diff > 0) return "+${diff.toInt()} kg to gain 💪";
    return "${diff.toInt()} kg to lose 🔥";
  }

  String get headlineText {
    switch (widget.goal) {
      case WeightGoal.gain:
        return "Let’s aim higher 💪";
      case WeightGoal.maintain:
        return "Stability is strength ⚖️";
      case WeightGoal.lose:
        return "Slow & steady wins 🏃";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Target Weight",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            Text(
              headlineText,
              style: TextStyleConstants.quickSand20W600,
            ),

            const SizedBox(height: 6),

            Text(
              "Choose a comfortable and realistic goal",
              style: TextStyleConstants.dmsans6A14W600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            /// 🎯 TARGET CARD
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: ColorConstants.colorDEFD7C.withOpacity(0.25),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    "Target Weight",
                    style: TextStyleConstants.quickSand14W700,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${targetWeight.toInt()} kg",
                    style: TextStyleConstants.quickSand20W600,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    differenceText,
                    style: TextStyleConstants.dmsans6A14W600,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// ⚖️ SLIDER
            Slider(
              value: targetWeight,
              min: widget.currentWeight - 20,
              max: widget.currentWeight + 20,
              divisions: 40,
              label: "${targetWeight.toInt()} kg",
              onChanged: (value) {
                setState(() => targetWeight = value);
              },
            ),

            const Spacer(),

            /// ▶️ CONTINUE
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaceActivityScreen(),
                  ),
                );

              },
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
