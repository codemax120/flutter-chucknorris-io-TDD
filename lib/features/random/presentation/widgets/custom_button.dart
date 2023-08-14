import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    required this.title,
    required this.callback,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: OutlinedButton(
        onPressed: callback,
        child: Text(title),
      ),
    );
  }
}
