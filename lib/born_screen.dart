import 'package:anyfeast_demo/measurements_screen.dart';
import 'package:anyfeast_demo/utils/color_constants/color_constants.dart';
import 'package:anyfeast_demo/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BornScreen extends StatefulWidget {
  const BornScreen({super.key});

  @override
  State<BornScreen> createState() => _BornScreenState();
}

class _BornScreenState extends State<BornScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  int _calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.color8E8E93.withOpacity(0.1),
        title: Text(
          "Tell us about you",
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
              "When were you born?",
              style: TextStyleConstants.dmsans6A14W600,
            ),

            const SizedBox(height: 30),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selectedDate == null
                      ? Colors.grey.shade300
                      : Colors.blue,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    selectedDate == null
                        ? "Your age will appear here"
                        : "${_calculateAge(selectedDate!)} years old",
                    style: TextStyleConstants.quickSand20W600,
                  ),
                  const SizedBox(height: 6),
                  if (selectedDate != null)
                    Text(
                      DateFormat("dd MMM yyyy").format(selectedDate!),
                      style: TextStyleConstants.quickSand14W700,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.colorDEFD7C.withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.calendar_today_outlined),
                    SizedBox(width: 10),
                    Text("Select your birth date"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            /// ▶️ Continue Button
            ElevatedButton(
              onPressed: selectedDate == null
                  ? null
                  : () {
                debugPrint("DOB: $selectedDate");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MeasurementScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.colorDEFD7C,
                minimumSize: const Size(double.infinity, 50),
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
