import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'budget_screen.dart';
import 'package:flutter/services.dart';

class LifestylePreferencesScreen extends StatefulWidget {
  const LifestylePreferencesScreen({super.key});

  @override
  State<LifestylePreferencesScreen> createState() =>
      _LifestylePreferencesScreenState();
}

class _LifestylePreferencesScreenState
    extends State<LifestylePreferencesScreen> {
  final Set<String> cuisines = {};
  final Set<String> healthGoals = {};
  final Set<String> vegDays = {};

  double cookingTime = 30;
  int budget = 3;
  String kitchen = "Basic";
  String frequency = "Daily";

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
  }

  // ───── COPY HELPERS ─────
  String get cookingTimeText {
    if (cookingTime <= 20) return "Quick & effortless ⚡";
    if (cookingTime <= 40) return "Balanced daily cooking 🍳";
    return "Slow, mindful meals 🍲";
  }

  String get budgetText {
    const labels = [
      "Very budget friendly",
      "Budget conscious",
      "Balanced spending",
      "Premium ingredients",
      "No budget limits"
    ];
    return labels[budget - 1];
  }

  // ───── UI ─────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          "Your Food Lifestyle",
          style: TextStyleConstants.quickSand20W600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroSection(),

            _sectionCard(
              title: "Cuisines you love",
              subtitle: "We’ll prioritize meals from these",
              child: _chipWrap(
                ["Indian", "Italian", "Chinese", "Mexican", "Mediterranean"],
                cuisines,
              ),
            ),

            _sectionCard(
              title: "Health focus (optional)",
              subtitle: "Only if you want to guide us",
              child: _chipWrap(
                ["Weight Loss", "Muscle Gain", "Gut Health", "Heart Health"],
                healthGoals,
                accent: Colors.green,
              ),
            ),

            _sectionCard(
              title: "Cooking time",
              subtitle: cookingTimeText,
              child: Slider(
                value: cookingTime,
                min: 10,
                max: 60,
                divisions: 5,
                onChanged: (v) => setState(() => cookingTime = v),
              ),
            ),

            _sectionCard(
              title: "Your kitchen",
              subtitle: "What you usually cook with",
              child: _segmentedRow(
                ["Basic", "Well-equipped", "Advanced"],
                kitchen,
                    (v) => setState(() => kitchen = v),
              ),
            ),

            _sectionCard(
              title: "How often you cook",
              subtitle: "This helps us plan smarter",
              child: _segmentedRow(
                ["Daily", "Weekly", "Occasionally"],
                frequency,
                    (v) => setState(() => frequency = v),
              ),
            ),

            _sectionCard(
              title: "Budget comfort",
              subtitle: budgetText,
              child: _heartBudget(),
            ),

            _storySummary(),

            _sectionCard(
              title: "Vegetarian days (optional)",
              subtitle: "Choose days for veg-only meals",
              child: _chipWrap(
                ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                vegDays,
                accent: Colors.green,
              ),
            ),

            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BudgetScreen(),
                  )
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                backgroundColor: ColorConstants.colorDEFD7C,
                side: BorderSide(color: ColorConstants.color333333),
              ),
              child: Text(
                "Continue",
                style: TextStyleConstants.quickSand14W700,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ───── COMPONENTS ─────

  Widget _heroSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        "Let’s shape meals around your life 🍽️",
        style: TextStyleConstants.quickSand14W700,
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: ColorConstants.color8E8E93.withOpacity(0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyleConstants.quickSand14W700),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyleConstants.dmsans6A14W600),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _chipWrap(
      List<String> items,
      Set<String> selected, {
        Color accent = Colors.blue,
      }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        final isSelected = selected.contains(item);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (!selected.add(item)) selected.remove(item);
            });
          },
          child: AnimatedScale(
            scale: isSelected ? 1.08 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isSelected
                    ? accent.withOpacity(0.25)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? accent : Colors.grey.shade300,
                ),
              ),
              child: Text(
                item,
                style: TextStyleConstants.quickSand14W700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _segmentedRow(
      List<String> items,
      String selected,
      Function(String) onTap,
      ) {
    return Row(
      children: items.map((item) {
        final isSelected = item == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isSelected
                    ? ColorConstants.colorDEFD7C.withOpacity(0.35)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  item,
                  style: TextStyleConstants.quickSand14W700,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _heartBudget() {
    return Row(
      children: List.generate(5, (i) {
        final active = i < budget;
        return GestureDetector(
          onTap: () => setState(() => budget = i + 1),
          child: AnimatedScale(
            scale: active ? 1.15 : 1,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.favorite,
                color: active ? Colors.red : Colors.grey.shade300,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _storySummary() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your food story",
              style: TextStyleConstants.quickSand14W700),
          const SizedBox(height: 8),
          _summaryLine("Cuisines", cuisines.join(", ")),
          _summaryLine("Cooking", frequency),
          _summaryLine("Time", cookingTimeText),
          _summaryLine("Kitchen", kitchen),
          _summaryLine("Budget", budgetText),
          if (vegDays.isNotEmpty)
            _summaryLine("Veg days", vegDays.join(", ")),
        ],
      ),
    );
  }

  Widget _summaryLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: $value",
        style: TextStyleConstants.dmsans6A14W600,
      ),
    );
  }
}
