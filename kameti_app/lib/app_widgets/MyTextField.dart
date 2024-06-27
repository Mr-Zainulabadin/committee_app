import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  final IconData icon;
  final bool isActive;
  const MyTextField(
      {required this.controller,
      required this.hintText,
      required this.icon,
      this.isPass = false,
      required this.textInputType,
      super.key,
      this.isActive = true});
  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(borderSide: BorderSide.none);
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
              icon,
              size: 20,
              color: const Color(0xff1C1B1F).withOpacity(.5),
            )),
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: const Color(0xffFAF9F6), borderRadius: BorderRadius.circular(4)),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  keyboardType: textInputType,
                  obscureText: isPass,
                  decoration: InputDecoration(
                    enabled: isActive,
                    fillColor: Colors.transparent,
                    hintText: hintText,
                    border: InputBorder.none,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    contentPadding: const EdgeInsets.all(8),
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
