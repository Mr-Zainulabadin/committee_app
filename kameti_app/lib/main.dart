import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/provider/bottom_provider.dart';
import 'package:kameti_app/screens/splash_screen/splash_screen.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BottomNavProvider())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 225, 222, 222),
          tabBarTheme: TabBarTheme(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: AppColor.black.withOpacity(.5),
            indicator: const BoxDecoration(
              color: Color(0xff0052a3),
            ),
            labelColor: AppColor.white,
            labelStyle: TextStyle(fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.black),
            unselectedLabelStyle: TextStyle(fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.black.withOpacity(.3)),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff000080)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
