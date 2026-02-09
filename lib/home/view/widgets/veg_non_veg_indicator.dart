import 'package:flutter/material.dart';

class VegNonVegIndicator extends StatelessWidget {
  final bool isVeg;

  const VegNonVegIndicator({super.key, required this.isVeg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        border: Border.all(
          color: isVeg ? Colors.green : Colors.red,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isVeg ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
