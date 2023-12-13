import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BlinkText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const BlinkText({super.key, required this.style, required this.text});

  @override
  State<BlinkText> createState() => _BlinkTextState();
}

class _BlinkTextState extends State<BlinkText> {
  bool _show = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _show = !_show;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      overflow: TextOverflow.ellipsis,
      style: _show ? widget.style : const TextStyle(color: Colors.transparent),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
