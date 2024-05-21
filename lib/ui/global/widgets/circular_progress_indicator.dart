import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final Color valueColor;
  const CircularProgressWidget({
    super.key,
    required this.valueColor,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor,
          ),
        ),
      ),
    );
  }
}
