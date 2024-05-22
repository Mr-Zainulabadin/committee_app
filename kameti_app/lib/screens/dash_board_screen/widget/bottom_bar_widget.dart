import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/provider/bottom_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  final BottomNavProvider provider;
  const BottomNavBarWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        backgroundColor: AppColor.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.darkGrey,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: (index) {
          provider.changeSelectedIndex(index);
        },
        currentIndex: provider.selectedIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: AppColor.white,
              activeIcon: Icon(
                Icons.person_add_alt_1,
                color: AppColor.black,
              ),
              icon: Icon(
                Icons.person_add_alt_1,
                color: AppColor.black.withOpacity(.5),
              ),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: AppColor.white,
              activeIcon: Icon(
                Icons.add_to_photos_outlined,
                color: AppColor.black,
              ),
              icon: Icon(
                Icons.add_to_photos_outlined,
                color: AppColor.black.withOpacity(.5),
              ),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: AppColor.white,
              activeIcon: Icon(
                Icons.history,
                color: AppColor.black,
              ),
              icon: Icon(
                Icons.history,
                color: AppColor.black.withOpacity(.5),
              ),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: AppColor.white,
              activeIcon: Icon(
                Icons.settings,
                color: AppColor.black,
              ),
              icon: Icon(
                Icons.settings,
                color: AppColor.black.withOpacity(.5),
              ),
              label: ''),
        ]);
  }
}
