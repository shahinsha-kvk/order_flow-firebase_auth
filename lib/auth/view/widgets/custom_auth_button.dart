import 'package:flutter/material.dart';
import 'package:test_12/helpers/ui_helper.dart';

class CustomAuthButton extends StatelessWidget {
  final String label;
  final String assetImagePath;
  final Color bgColor;
  final Future<void> Function()? onTap;

  const CustomAuthButton({
    super.key,
    required this.label,
    required this.assetImagePath,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: getWidth(context: context) * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetImagePath,
              width: 24,
              height: 24,
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
