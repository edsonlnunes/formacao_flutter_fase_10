import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String _text;
  final void Function() _onPressed;
  final bool? _isLoading;

  const CustomButton({
    super.key,
    required String text,
    required void Function() onPressed,
    bool? isLoading,
  })  : _text = text,
        _onPressed = onPressed,
        _isLoading = isLoading ?? false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      height: 40,
      child: ElevatedButton(
        onPressed: _onPressed,
        child: _isLoading!
            ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(_text),
      ),
    );
  }
}
