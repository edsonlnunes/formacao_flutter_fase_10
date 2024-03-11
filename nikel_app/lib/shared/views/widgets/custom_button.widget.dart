import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final void Function()? onPressed;
  final bool isLoading;
  final String label;
  const CustomButton({
    super.key,
    this.width = 150,
    this.isLoading = false,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 40,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              )
            : Text(label),
      ),
    );
  }
}
