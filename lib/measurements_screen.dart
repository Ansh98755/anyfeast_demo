import 'package:anyfeast_demo/goal_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  double heightCm = 168;
  double weightKg = 65;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  double get bmi {
    final h = heightCm / 100;
    return weightKg / (h * h);
  }

  String get bmiMessage {
    if (bmi < 18.5) return "You’re light — nourishment helps 🌱";
    if (bmi < 25) return "Balanced & healthy 💚";
    if (bmi < 30) return "Let’s move a little more 🚶";
    return "Every step counts ❤️";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Your Measurements",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            Text(
              "Help us understand your body better",
              style: TextStyleConstants.dmsans6A14W600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            _heightCard(),

            const SizedBox(height: 24),

            _weightCard(),

            const SizedBox(height: 24),

            /// 📊 BMI CARD
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    "Body Insight",
                    style: TextStyleConstants.quickSand14W700,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "BMI ${bmi.toStringAsFixed(1)}",
                    style: TextStyleConstants.quickSand20W600,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bmiMessage,
                    style: TextStyleConstants.dmsans6A14W600,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ▶️ CONTINUE
            ElevatedButton(
              onPressed: () {
                debugPrint(
                  "Height: $heightCm | Weight: $weightKg | BMI: ${bmi.toStringAsFixed(1)}",
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GoalScreen(
                      currentWeight: weightKg, // ✅ PASS DATA
                    ),
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

  /// 🧍 HEIGHT CARD
  Widget _heightCard() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.color8E8E93.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/height_scale.png",
            width: 55,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Height",
                  style: TextStyleConstants.quickSand14W700,
                ),
                const SizedBox(height: 4),
                Text(
                  "Stand tall — every cm counts 📏",
                  style: TextStyleConstants.dmsans6A14W600,
                ),
                const SizedBox(height: 12),
                Text(
                  "${heightCm.toInt()} cm",
                  style: TextStyleConstants.quickSand20W600,
                ),
                Slider(
                  value: heightCm,
                  min: 130,
                  max: 210,
                  divisions: 80,
                  label: "${heightCm.toInt()} cm",
                  onChanged: (value) {
                    setState(() => heightCm = value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ⚖️ WEIGHT CARD
  Widget _weightCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.color8E8E93.withOpacity(0.08),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/weight_taraju.png",
            height: 70,
          ),
          const SizedBox(height: 10),
          Text(
            "Weight",
            style: TextStyleConstants.quickSand14W700,
          ),
          const SizedBox(height: 4),
          Text(
            "It’s about balance, not pressure ⚖️",
            style: TextStyleConstants.dmsans6A14W600,
          ),
          const SizedBox(height: 10),
          Text(
            "${weightKg.toInt()} kg",
            style: TextStyleConstants.quickSand20W600,
          ),
          Slider(
            value: weightKg,
            min: 35,
            max: 150,
            divisions: 115,
            label: "${weightKg.toInt()} kg",
            onChanged: (value) {
              setState(() => weightKg = value);
            },
          ),
        ],
      ),
    );
  }
}
