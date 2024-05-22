import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class AddKametiScreen extends StatelessWidget {
  const AddKametiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final perKametiController = TextEditingController();
    final totalKametiPriceController = TextEditingController();
    final totalMonthController = TextEditingController();
    final myKametiController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(title: "Add Kameti"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    icon: Icons.today_outlined,
                    textInputType: TextInputType.number,
                  ),
                  8.verSpace,
                  MyTextField(
                    controller: totalMonthController,
                    hintText: "Total months",
                    icon: Icons.person,
                    textInputType: TextInputType.number,
                  ),
                  8.verSpace,
                  MyTextField(
                    controller: myKametiController,
                    hintText: "My total kameties ",
                    icon: Icons.person,
                    textInputType: TextInputType.number,
                  ),
                  8.verSpace,
                  const EndingDateWidget(),
                  8.verSpace,
                  const StartingDateWidget()
                ],
              ),
              SizedBox(
                height: context.mqHeight * .13,
              ),
              CustomButton(
                  onTap: () {
                    if (nameController.text.isEmpty) {
                      "Please enter the name".errorSnack;
                    } else if (perKametiController.text.isEmpty) {
                      "PLease enter per kameti Price".errorSnack;
                    } else if (totalKametiPriceController.text.isEmpty) {
                      "PLease enter total kameti Price".errorSnack;
                    } else if (totalMonthController.text.isEmpty) {
                      "PLease enter total months".errorSnack;
                    } else if (myKametiController.text.isEmpty) {
                      "PLease enter total Kameties".errorSnack;
                    } else {
                      "Add Kameti SuccessFully".successSnack;
                    }
                  },
                  title: "Add Kameti")
            ],
          ),
        ),
      ),
    );
  }
}

class StartingDateWidget extends StatelessWidget {
  const StartingDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: AppColor.offWhite),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.grey,
            ),
            child: Center(
                child: Icon(
              Icons.calendar_month_outlined,
              size: 20,
              color: const Color(0xff1C1B1F).withOpacity(.5),
            )),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(color: const Color(0xffFAF9F6), borderRadius: BorderRadius.circular(4)),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomText(
                text: "Stating date",
                fontSize: 15,
                fontColor: AppColor.black.withOpacity(.6),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class EndingDateWidget extends StatelessWidget {
  const EndingDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: AppColor.offWhite),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.grey,
            ),
            child: Center(
                child: Icon(
              Icons.calendar_month_outlined,
              size: 20,
              color: const Color(0xff1C1B1F).withOpacity(.5),
            )),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(color: const Color(0xffFAF9F6), borderRadius: BorderRadius.circular(4)),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomText(
                text: "Ending date",
                fontColor: AppColor.black.withOpacity(.6),
                fontSize: 15,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
