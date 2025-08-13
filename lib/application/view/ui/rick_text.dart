import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RickText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;

  const RickText(
      this.text, {
        super.key,
        this.style,
        this.textAlign = TextAlign.start,
        this.maxLines = 1,
        this.overflow = TextOverflow.ellipsis,
      });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
