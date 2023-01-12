import 'package:all_in_one/utils/AppColors.dart';
import 'package:all_in_one/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback retry;
  final String errorMessage;
  const ErrorScreen({Key? key, required this.retry, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppImages.errorOneLottie,
              animate: true,
              height: 100,
              width: 100,
            ),
            Text(
              errorMessage,
              style: TextStyle(color: AppColors.kCustomGreyColor, fontSize: 12),
            ),
           const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
              onPressed: retry,
              icon:const Icon(Icons.refresh_outlined),
              label:const Text("RETRY"),
            )
          ],
        ),
      ),
    );
  }
}
