import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/application/view/theme/rick_colors.dart';
import 'package:rick_and_morty_info/application/view/ui/rick_text.dart';


class RickButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon? icon;
  final String text;

  const RickButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: RickText(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: RickColors.primary,
          foregroundColor: RickColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return RickColors.black;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}