import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sehety/core/util/colors.dart';

showLoading({context}) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: LottieBuilder.asset('assets/images/loading.json'),
        ),
      );
    },
  );
}

showError({required context,required textError}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Container(
        color: AppColors.redColor,
        child: Text(textError))));
}
