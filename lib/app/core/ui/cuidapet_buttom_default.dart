// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_cuida_pet/app/core/ui/extensions/theme_extensions.dart';

class CuidapetButtomDefault extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double labelSize;
  final double radius;
  final Color? color;
  final double padding;
  final double width;
  final double height;

  const CuidapetButtomDefault({
    Key? key,
    this.onPressed,
    required this.label,
    this.labelSize = 20,
    this.radius = 10,
    this.color,
    this.padding = 10,
     this.width = double.infinity,
     this.height = 66,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          backgroundColor: color ?? context.primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
