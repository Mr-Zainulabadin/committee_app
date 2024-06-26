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

class AddKametiScreen extends StatelessWidget {
  const AddKametiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final perKametiController = TextEditingController();
    final totalKametiPriceController = TextEditingController();

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
                      controller: nameController,
                      hintText: "Enter your Name",
                      icon: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                    8.verSpace,
                    MyTextField(
                      controller: perKametiController,
                      hintText: "Per kameti price",
                      icon: Icons.payment_outlined,
                      textInputType: TextInputType.number,
                    ),
                    8.verSpace,
                    MyTextField(
                      controller: totalKametiPriceController,
                      hintText: "Kameti total price",
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
                    onTap: () async {
                      if (nameController.text.isEmpty) {
                        "Please enter the name".errorSnack;
                      } else if (perKametiController.text.isEmpty) {
                        "PLease enter per kameti Price".errorSnack;
                      } else if (totalKametiPriceController.text.isEmpty) {
                        "PLease enter total kameti Price".errorSnack;
                      } else if (kametiProvider.selectedStartDate == null) {
                        "PLease select kameti start date".errorSnack;
                      } else if (kametiProvider.selectedEndDate == null) {
                        "PLease select kameti end date".errorSnack;
                      } else {
                        try {
                          final DocumentSnapshot snapshot =
                              await FirebaseFirestore.instance
                                  .collection("all_kameti")
                                  .doc("all_kameti")
                                  .get();

                          if (snapshot.exists) {
                            List<dynamic> allKametiList =
                                snapshot['all_kameti'];

                            allKametiList.add({
                              "name": nameController.text.toString(),
                              "perkameti": perKametiController.text.toString(),
                              "total_months": int.parse(
                                      totalKametiPriceController.text
                                          .toString()) /
                                  int.parse(
                                      perKametiController.text.toString()),
                              "totalKametiPrice":
                                  totalKametiPriceController.text.toString(),
                              "createdDate": DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                              "startingDate": DateFormat('yyyy-MM-dd')
                                  .format(kametiProvider.selectedStartDate!),
                              "endingDate": DateFormat('yyyy-MM-dd')
                                  .format(kametiProvider.selectedEndDate!),
                              "total_user": []
                            });
                            await FirebaseFirestore.instance
                                .collection("all_kameti")
                                .doc("all_kameti")
                                .update({'all_kameti': allKametiList});
                            "Add Kameti SuccessFully".successSnack;
                          } else {
                            "Document 'all_kameti' does not exist".errorSnack;
                            throw Exception(
                                "Document 'all_kameti' does not exist.");
                          }
                        } catch (e) {
                          print("Error adding kameti to list: $e");
                        }
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
