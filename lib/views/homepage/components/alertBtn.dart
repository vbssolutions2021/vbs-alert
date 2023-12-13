import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sos_vision/views/constants.dart';

class AlertBtn extends StatefulWidget {
  const AlertBtn({super.key});

  @override
  State<AlertBtn> createState() => _AlertBtnState();
}

class _AlertBtnState extends State<AlertBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(100)),
      child: Container(
          width: kWidth(context) * 0.28,
          height: kWidth(context) * 0.28,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                BoxIcons.bxs_bell_ring,
                color: kWhite,
                size: kWidth(context) * 0.07,
              ),
              SizedBox(
                height: kWidth(context) * 0.02,
              ),
              AutoSizeText(
                "Alert",
                style: TextStyle(
                    color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          )),
    );
  }
}
