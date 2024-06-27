import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/provider/add_kameti_provider/add_kameti_provider.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/screens/add_kameti_screen/widget.dart/ending_date_widget.dart';
import 'package:kameti_app/screens/add_kameti_screen/widget.dart/starting_date_widget.dart';
import 'package:kameti_app/utils/Extensions.dart';
import 'package:provider/provider.dart';

class AddKametiScreen extends StatefulWidget {
  const AddKametiScreen({super.key});

  @override
  State<AddKametiScreen> createState() => _AddKametiScreenState();
}

class _AddKametiScreenState extends State<AddKametiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Kameti"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Consumer<AuthenticationProvider>(builder: (_, authProvider, __) {
          return Consumer<AddKametiProvider>(builder: (_, kametiProvider, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    MyTextField(
                      controller: kametiProvider.nameController,
                      hintText: "Enter your Name",
                      icon: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                    8.verSpace,
                    MyTextField(
                      controller: kametiProvider.perKametiController,
                      hintText: "Per kameti price",
                      icon: Icons.payment_outlined,
                      textInputType: TextInputType.number,
                    ),
                    8.verSpace,
                    MyTextField(
                      controller: kametiProvider.totalMonthsController,
                      hintText: "Total Months",
                      icon: Icons.payments_outlined,
                      textInputType: TextInputType.number,
                    ),
                    8.verSpace,
                    const EndingDateWidget(),
                    8.verSpace,
                    const StartingDateWidget()
                  ],
                ),
                CustomButton(
                    isLoading: kametiProvider.isLoading,
                    onTap: () async {
                      if (kametiProvider.nameController.text.isEmpty) {
                        "Please enter the name".errorSnack;
                      } else if (kametiProvider
                          .perKametiController.text.isEmpty) {
                        "PLease enter per kameti Price".errorSnack;
                      } else if (kametiProvider
                          .totalMonthsController.text.isEmpty) {
                        "PLease enter total kameti Price".errorSnack;
                      } else if (kametiProvider.selectedStartDate == null) {
                        "PLease select kameti start date".errorSnack;
                      } else if (kametiProvider.selectedEndDate == null) {
                        "PLease select kameti end date".errorSnack;
                      } else {
                        kametiProvider.addKameti();
                      }
                    },
                    title: "Add Kameti")
              ],
            );
          });
        }),
      ),
    );
  }
}
