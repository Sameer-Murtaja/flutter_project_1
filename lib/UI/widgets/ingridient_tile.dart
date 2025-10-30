import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  final String data;
  final bool useBigFont;
  const DetailsTile({super.key, required this.data, this.useBigFont = false});

  @override
  Widget build(BuildContext context) {
    double fontSize = switch (useBigFont) {
      true => 14,
      false => 10,
    };

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 1)),
      ),
      child: Text(
        data,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          height: 150 / 100,
        ),
      ),
    );
  }
}
