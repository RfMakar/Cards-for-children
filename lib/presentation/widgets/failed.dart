import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  final String message;

  const FailedWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }

  
}
