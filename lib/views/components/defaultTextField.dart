import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sos_vision/views/constants.dart';

class DefaultTextField extends StatefulWidget {
  final String hintText;
  final String? title;
  final double width;
  final bool? obscurText;
  final IconData? prefixIcon;
  final TextEditingController controller;
  const DefaultTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscurText,
      this.title,
      this.prefixIcon,
      required this.width});

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool obscurText = true;
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.title != null)
          Container(
            width: widget.width,
            child: AutoSizeText(
              widget.title!,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: kTextColor),
            ),
          ),
        if (widget.title != null)
          SizedBox(
            height: 7,
          ),
        Container(
            width: widget.width,
            padding: widget.prefixIcon != null && widget.obscurText == null
                ? EdgeInsets.only(right: kWidth(context) * 0.05)
                : (widget.obscurText == null
                    ? EdgeInsets.symmetric(horizontal: kWidth(context) * 0.05)
                    : null),
            decoration: BoxDecoration(
              border: Border.all(color: kTextColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: TextField(
                obscureText: widget.obscurText != null ? obscurText : false,
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(
                            widget.prefixIcon,
                            size: 17,
                            color: kTextColor,
                          )
                        : null,
                    suffixIcon: widget.obscurText != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                obscurText = !obscurText;
                              });
                            },
                            child: !obscurText
                                ? Icon(
                                    Bootstrap.eye,
                                    size: 17,
                                  )
                                : Icon(
                                    Bootstrap.eye_slash,
                                    size: 17,
                                  ),
                          )
                        : null,
                    border: InputBorder.none),
              ),
            ))
      ]),
    );
  }
}
