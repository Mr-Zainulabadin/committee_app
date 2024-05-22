import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class SelectStartMonthsWidget extends StatelessWidget {
  const SelectStartMonthsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Select Start Months",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontColor: AppColor.black,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 45,
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(
                //                   <--- right side
                color: Colors.black,
              ),
            ),
          ),
          child: Center(
            child: DropdownMenu(
              onSelected: (value) {},
              width: context.mqWidth * .95,
              trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
              selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_sharp),
              hintText: "Select start months",
              inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
              dropdownMenuEntries: List.generate(12, (index) {
                return const DropdownMenuEntry(
                  value: "jun",
                  label: "jun",
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
