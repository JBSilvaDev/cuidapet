// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_cuida_pet/app/core/ui/extensions/size_screen_extension.dart';

class RoundedButtomIcon extends StatelessWidget {
  final GestureTapCallback onPressed;
  final double width;
  final Color? color;
  final IconData icon;
  final String label;

  const RoundedButtomIcon({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.color,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 45.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 2),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0.clamp(10, 30)),
            ),
          )
        ]),
      ),
    );
  }
}
