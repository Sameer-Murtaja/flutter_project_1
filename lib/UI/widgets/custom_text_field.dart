import 'package:flutter/material.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final bool obsecureText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.obsecureText = false,
    this.padding,
    this.margin,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.primaryExtraSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              style: TextStyle(fontSize: 14),
              cursorColor: AppColor.primary,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
