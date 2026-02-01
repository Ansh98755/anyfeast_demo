import 'dart:math';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinalCelebrationScreen extends StatefulWidget {
  const FinalCelebrationScreen({super.key});

  @override
  State<FinalCelebrationScreen> createState() =>
      _FinalCelebrationScreenState();
}

class _FinalCelebrationScreenState extends State<FinalCelebrationScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _heartController;
  late AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    _bgController =
    AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat();

    _heartController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);

    _contentController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _heartController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Stack(
        children: [
          /// 🌊 MOVING BACKGROUND BLOBS
          Positioned.fill(child: _AnimatedBackground(controller: _bgController)),

          /// MAIN CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// ❤️ BEATING HEART
                  AnimatedBuilder(
                    animation: _heartController,
                    builder: (_, __) {
                      return Transform.scale(
                        scale: 1 + (_heartController.value * 0.12),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 72,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  /// 🎉 TITLE
                  FadeTransition(
                    opacity: _contentController,
                    child: Text(
                      "You just made\nan incredible decision 🎉",
                      textAlign: TextAlign.center,
                      style: TextStyleConstants.quickSand20W600.copyWith(
                        fontSize: 26,
                        height: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "This is where your relationship with food changes.",
                    textAlign: TextAlign.center,
                    style: TextStyleConstants.dmsans6A14W600,
                  ),

                  const SizedBox(height: 40),

                  /// 📖 STORY CARDS
                  _floatingCard(
                    delay: 0.2,
                    title: "Your food story",
                    lines: const [
                      "🎯 Goal: Eat better & feel lighter",
                      "🥗 Diet: Flexible & personalized",
                      "🌍 Loves Indian & Italian food",
                      "👨‍🍳 Cooking level: Edible food expert 😄",
                      "❤️ Budget: Balanced & stress-free",
                    ],
                  ),

                  _floatingCard(
                    delay: 0.4,
                    title: "Why this works",
                    lines: const [
                      "No extreme diets",
                      "No food guilt",
                      "No confusion",
                      "Just consistency & balance",
                    ],
                  ),

                  _floatingCard(
                    delay: 0.6,
                    title: "What AnyFeast does differently",
                    lines: const [
                      "Respects your culture & taste",
                      "Fits your lifestyle",
                      "Adapts as your life changes",
                      "Builds habits, not rules",
                    ],
                  ),

                  const SizedBox(height: 50),

                  /// 🚀 FINISH BUTTON
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _contentController,
                      curve: Curves.elasticOut,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Finish Setup tapped");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 58),
                        backgroundColor: ColorConstants.colorDEFD7C,
                        side: BorderSide(color: ColorConstants.color333333),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Finish Setup & Begin My Journey",
                        style: TextStyleConstants.quickSand14W700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🌱 FOOTER QUOTE
                  Text(
                    "Good food isn’t about perfection.\nIt’s about showing up every day 🌱",
                    textAlign: TextAlign.center,
                    style: TextStyleConstants.dmsans6A14W600,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🧩 FLOATING SUMMARY CARD
  Widget _floatingCard({
    required double delay,
    required String title,
    required List<String> lines,
  }) {
    return AnimatedBuilder(
      animation: _contentController,
      builder: (_, __) {
        final progress =
        Curves.easeOut.transform((_contentController.value - delay).clamp(0, 1));

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - progress)),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: ColorConstants.color8E8E93.withOpacity(0.08),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyleConstants.quickSand14W700),
                  const SizedBox(height: 10),
                  ...lines.map(
                        (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        e,
                        style: TextStyleConstants.dmsans6A14W600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 🌊 BACKGROUND BLOBS
class _AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          children: List.generate(3, (i) {
            final double dx = sin(controller.value * 2 * pi + i) * 40;
            final double dy = cos(controller.value * 2 * pi + i) * 40;

            return Positioned(
              left: 80.0 * i + dx,
              top: 120.0 * i + dy,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorDEFD7C.withOpacity(0.15),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
