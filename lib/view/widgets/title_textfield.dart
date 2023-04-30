import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {super.key,
      required this.setController,
      required this.errorTextNotifier});

  final TextEditingController setController;
  final ValueNotifier<String?> errorTextNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: errorTextNotifier,
      builder: (context, value, child) => TextField(
        controller: setController,
        decoration: InputDecoration(errorText: value),
      ),
    );
  }
}
