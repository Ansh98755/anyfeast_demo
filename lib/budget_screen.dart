import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'final_summary_screen.dart';
import 'package:flutter/services.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  /// 🔑 IMPORTANT: keep budget as DOUBLE
  double budgetLevel = 3; // 1–5 (coins)

  late AnimationController _controller;
  late Animation<double> _amountAnimation;

  /// Weekly budgets mapped to coin levels
  final List<int> weeklyBudgets = [
    700,
    1000,
    1350,
    1800,
    2500,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _updateAnimation();
  }

  void _updateAnimation() {
    _amountAnimation = Tween<double>(
      begin: 0,
      end: weeklyBudgets[budgetLevel.toInt() - 1].toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward(from: 0);
  }

  String get budgetMood {
    switch (budgetLevel.toInt()) {
      case 1:
        return "Very budget-friendly 🧘";
      case 2:
        return "Careful & conscious 🌱";
      case 3:
        return "Balanced & flexible ⚖️";
      case 4:
        return "Premium ingredients ✨";
      default:
        return "Luxury food life 💎";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int weeklyAmount = weeklyBudgets[budgetLevel.toInt() - 1];
    final int perMeal = (weeklyAmount / 2).toInt();

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Weekly Budget",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Set your comfortable food spend",
              style: TextStyleConstants.dmsans6A14W600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            /// 💳 WALLET CARD
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: ColorConstants.colorDEFD7C.withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    "Your Food Wallet",
                    style: TextStyleConstants.quickSand14W700,
                  ),

                  const SizedBox(height: 12),

                  /// Animated Amount
                  AnimatedBuilder(
                    animation: _amountAnimation,
                    builder: (_, __) {
                      return Text(
                        "₹${_amountAnimation.value.toInt()}",
                        style: TextStyleConstants.quickSand20W600.copyWith(
                          fontSize: 32,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Weekly comfort budget",
                    style: TextStyleConstants.dmsans6A14W600,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "≈ ₹$perMeal per meal",
                    style: TextStyleConstants.dmsans6A14W600,
                  ),

                  const SizedBox(height: 20),

                  /// 💰 COIN SELECTOR
                  Row(
                    children: List.generate(5, (index) {
                      final bool active = index < budgetLevel.toInt();

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            budgetLevel = (index + 1).toDouble();
                            _updateAnimation();
                          });
                        },
                        child: AnimatedScale(
                          scale: active ? 1.2 : 1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutBack,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.monetization_on,
                              size: 32,
                              color: active
                                  ? Colors.green
                                  : Colors.green.withOpacity(0.3),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  /// Mood text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      budgetMood,
                      key: ValueKey(budgetMood),
                      style: TextStyleConstants.quickSand14W700,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// ▶️ CONTINUE
            ElevatedButton(
              onPressed: () {
                debugPrint(
                  "Weekly Budget: ₹$weeklyAmount | Level: ${budgetLevel.toInt()}",
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FinalCelebrationScreen(
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: ColorConstants.colorDEFD7C,
                side: BorderSide(color: ColorConstants.color333333),
              ),
              child: Text(
                "Continue",
                style: TextStyleConstants.quickSand14W700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
