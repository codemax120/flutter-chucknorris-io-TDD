import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;

  const CustomButton({
    super.key,
    required this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: OutlinedButton(
        onPressed: callback,
        child: Text(title),
      ),
    );
  }
}
