import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  final Color bgColor;
  const CustomButton(
      {this.bgColor = const Color(0xff0052a3), this.isLoading = false, required this.onTap, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : CustomText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColor.white,
                ),
        ),
      ),
    );
  }
}
