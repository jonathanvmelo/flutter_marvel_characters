import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final String message;

  const CustomLoadingIndicator({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
