import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/screens/all_kameti/widget/kameti_montly_fee_widget.dart';
import 'package:kameti_app/screens/all_kameti/widget/per_kameti_price_widget.dart';
import 'package:kameti_app/screens/all_kameti/widget/selected_month_widget.dart';
import 'package:kameti_app/screens/all_kameti/widget/starting_months_widget.dart';
import 'package:kameti_app/utils/Extensions.dart';

class UserAddInKametiScreen extends StatelessWidget {
  const UserAddInKametiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add User"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            const PerKametiPriceWidget(),
            const SelectedMonthsWidget(),
            const SelectStartMonthsWidget(),
            const SelectedMonthsFeeWidget(),
            const Spacer(),
            CustomButton(
                onTap: () {
                  Get.back();
                  "Add Member SuccessFully".successSnack;
                },
                title: "Add Now")
          ],
        ),
      ),
    );
  }
}
