import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/utils/extensions.dart';

class kametiDetailWidget extends StatelessWidget {
  final String title, value;
  const kametiDetailWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontSize: 16, fontColor: Colors.black),
          5.horSpace,
          CustomText(text: value, fontSize: 14, fontColor: Colors.black.withOpacity(.7)),
        ],
      ),
    );
  }
}
