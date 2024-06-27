import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/provider/add_kameti_provider/add_kameti_provider.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/provider/bottom_provider.dart';
import 'package:kameti_app/screens/splash_screen/splash_screen.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    // Initialize Firebase with web-specific options
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDEkimIY1tfpOBqjmmx7OSRn-5BvibxTcA",
            appId: "1:956372008740:web:e7e45d2ac16c79c409fdb1",
            messagingSenderId: "956372008740",
            projectId: "testing-3d61a",
            storageBucket: "testing-3d61a.appspot.com"));
  } else {
    // Initialize Firebase without any additional options
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
  // DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => AddKametiProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 225, 222, 222),
          tabBarTheme: TabBarTheme(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: AppColor.black.withOpacity(.5),
            indicator: BoxDecoration(
              color: AppColor.darkRed,
            ),
            labelColor: AppColor.white,
            labelStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.black),
            unselectedLabelStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.black.withOpacity(.3)),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
