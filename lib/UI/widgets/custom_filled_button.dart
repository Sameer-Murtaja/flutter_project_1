import 'package:flutter/material.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomFilledButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.primarySoft,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'inter',
          ),
        ),
      ),
    );
  }
}
