import 'package:flutter/material.dart';
import 'package:sehety/core/util/colors.dart';
import 'package:sehety/core/util/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    this.textColor,
  });
  final String text;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color ?? AppColors.whiteColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            text,
            style: getBodyStyle(context,
                fontWeight: FontWeight.w800,
                color: textColor ?? AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
