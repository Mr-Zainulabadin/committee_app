import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/screens/kameti_history/widget/kameti_detail_widget.dart';
import 'package:kameti_app/utils/extensions.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.offWhite,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          10.verSpace,
          Text(
            "Kameti Details",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.verSpace,
          const kametiDetailWidget(title: "Name", value: "Coder"),
          const kametiDetailWidget(title: "Per Kameti Price", value: "2000"),
          const kametiDetailWidget(title: "Kameti Total Price", value: "24000"),
          const kametiDetailWidget(title: "Total Months", value: "12"),
          const kametiDetailWidget(title: "Starting Date", value: "19/12/2023"),
          const kametiDetailWidget(title: "Ending Date", value: "19/12/2024"),
        ],
      ),
    );
    ;
  }
}
