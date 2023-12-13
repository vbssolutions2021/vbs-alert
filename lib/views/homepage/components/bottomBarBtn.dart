import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sos_vision/views/constants.dart';

class BottomBarBtn extends StatefulWidget {
  final IconData icon;
  final String title;
  const BottomBarBtn({super.key, required this.icon, required this.title});

  @override
  State<BottomBarBtn> createState() => _BottomBarBtnState();
}

class _BottomBarBtnState extends State<BottomBarBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kWidth(context) * 0.2,
      width: kWidth(context) * 0.25,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: kSecondaryColor),
                  color: kWhite),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  widget.icon,
                  color: kWhite,
                ),
              ),
            ),
            AutoSizeText(
              widget.title,
              style: TextStyle(
                  color: kTextColor, fontSize: 15, fontWeight: FontWeight.w700),
            )
          ]),
    );
  }
}
