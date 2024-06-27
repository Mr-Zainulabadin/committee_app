import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kameti_app/provider/bottom_provider.dart';
import 'package:kameti_app/screens/dash_board_screen/widget/bottom_bar_widget.dart';
import 'package:kameti_app/screens/kameti_history/Kameti_history_screen.dart';
import 'package:kameti_app/screens/setting_screen/setting_screen.dart';
import 'package:provider/provider.dart';

import '../add_kameti_screen/add_Kameti_screen.dart';
import '../all_kameti/all_kameti_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _HomePageState();
}

class _HomePageState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;
  List<Widget> pages = [
    const AddKametiScreen(),
    const AllKametiScreen(isLeading: true),
    // const KametiHistoryScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
        builder: (context, bottomProvider, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          bottomProvider.selectedIndex != 0
              ? bottomProvider.changeSelectedIndex(0)
              : SystemNavigator.pop();
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavBarWidget(provider: bottomProvider),
          key: _scaffoldKey,
          body: pages[bottomProvider.selectedIndex],
        ),
      );
    });
  }
}
