import 'package:anyfeast_demo/born_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/screen_size_config/screen_size_config.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Gender { male, female, Other }

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  Gender? selectedGender;
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSizeConfig(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        title: Text(
          "Welcome to AnyFeast",
          style: TextStyleConstants.quickSand20W600,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose your gender",
              style: TextStyleConstants.dmsans6A14W600
            ),
            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: _genderItem(
                    gender: Gender.male,
                    label: "Male",
                    selectedImage: "assets/male_selected.png",
                    unSelectedImage: "assets/male_unselected.png",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _genderItem(
                    gender: Gender.female,
                    label: "Female",
                    selectedImage: "assets/female_selected.png",
                    unSelectedImage: "assets/female_unselected.png",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _genderItem(
                    gender: Gender.Other,
                    label: "Other",
                    selectedImage: "assets/other_selected.png",
                    unSelectedImage: "assets/other_unselected.png",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                if (selectedGender == null) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BornScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 50),
                ),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
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
            )
          ],
        ),
      ),
    );
  }

  Widget _genderItem({
    required Gender gender,
    required String label,
    required String selectedImage,
    required String unSelectedImage,
  }) {
    final bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Image.asset(
              isSelected ? selectedImage : unSelectedImage,
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyleConstants.quickSand14W700
          ),
        ],
      ),
    );
  }
}
