import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideInText extends StatefulWidget {
  const SlideInText({
    super.key,
    this.align,
    required this.value,
    required this.size,
    required this.weight,
  });

  final String value;
  final double size;
  final FontWeight weight;
  final TextAlign? align;

  @override
  State<SlideInText> createState() => _SlideInTextState();
}

class _SlideInTextState extends State<SlideInText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.value,
      textAlign: widget.align ?? TextAlign.start,
      style: GoogleFonts.gantari(
        color: Colors.white,
        fontSize: widget.size,
        fontWeight: widget.weight,
        height: 1.1,
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(
            milliseconds: 800,
          ),
        )
        .slideY(
          duration: const Duration(
            milliseconds: 800,
          ),
          begin: 0.15,
        );
  }
}
