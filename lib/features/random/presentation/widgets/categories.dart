import 'package:chuck_norris_io/features/random/presentation/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Categories extends StatelessWidget {
  final String title;
  final List<String> list;

  const Categories({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.jost(
            fontWeight: FontWeight.w800,
            fontSize: 0.3.dp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: list
              .map((category) => RandomCategory(category: category))
              .toList(),
        ),
        Divider(
          color: Colors.black45,
          height: 5.h,
        ),
      ],
    );
  }
}
