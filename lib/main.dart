import 'package:anyfeast_demo/utils/screen_size_config/screen_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'gender_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSizeConfig(context);
    return ScreenUtilInit(
      designSize: Size(SizeConfig.screenWidth, SizeConfig.screenHeight),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const GenderSelectionScreen(),
      ),
    );
  }
}