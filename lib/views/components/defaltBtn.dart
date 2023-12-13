import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sos_vision/views/constants.dart';

class DefaultBtn extends StatefulWidget {
  final Function event;
  final String title;
  final double titleSize;
  final Color bgColor;
  const DefaultBtn(
      {super.key,
      required this.event,
      required this.titleSize,
      required this.title,
      required this.bgColor});

  @override
  State<DefaultBtn> createState() => _DefaultBtnState();
}

class _DefaultBtnState extends State<DefaultBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
        onPressed: () {
          widget.event();
        },
        child: AutoSizeText(
          widget.title,
          style: TextStyle(color: kWhite, fontSize: widget.titleSize),
        ));
  }
}
