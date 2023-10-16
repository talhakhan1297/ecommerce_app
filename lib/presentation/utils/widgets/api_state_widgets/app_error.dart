import 'package:ecommerce_app/presentation/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  const AppError({
    required this.message,
    this.retry,
    this.isLoading = false,
    super.key,
  });

  final String message;
  final bool isLoading;
  final void Function()? retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(message, textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              text: 'Try again',
              onPressed: retry,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
