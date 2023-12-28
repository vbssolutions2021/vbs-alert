import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sos_vision/views/animations/blinkText.dart';
import 'package:sos_vision/views/components/defaltBtn.dart';
import 'package:sos_vision/views/constants.dart';

class NeedHelpPopup extends StatefulWidget {
  final String profilUrl;
  final String alertType;
  final String alertStatus;
  final String name;
  final String role;
  final String phone;
  final double profilUrlSize;
  const NeedHelpPopup(
      {super.key,
      required this.name,
      required this.alertStatus,
      required this.alertType,
      required this.phone,
      required this.profilUrl,
      required this.profilUrlSize,
      required this.role});

  @override
  State<NeedHelpPopup> createState() => _NeedHelpPopupState();
}

class _NeedHelpPopupState extends State<NeedHelpPopup> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: kHeight(context) * 0.035,
          child: SizedBox(
            width: kWidth(context) * 0.7,
            height: kWidth(context) * 0.55 / 1.4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: kWhite,
              surfaceTintColor: kWhite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 5, right: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 34, 34, 34),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.call,
                            size: 17,
                            color: kWhite,
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          widget.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        )),
                    AutoSizeText(
                      widget.role,
                      style: TextStyle(color: kTextColor, fontSize: 12),
                    ),
                    if (widget.alertType == "NEED HELP" ||
                        (widget.alertType == "GENERAL" &&
                            widget.alertStatus == "IN DANGER"))
                      BlinkText(
                        text:
                            " ${(widget.alertType == "GENERAL" && widget.alertStatus == "IN DANGER") ? "in danger🆘" : "NEED HELP✋"}",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    if (widget.alertType == "GENERAL" &&
                        widget.alertStatus != "IN DANGER")
                      AutoSizeText(
                        "${widget.alertStatus.toLowerCase()}...",
                        style: TextStyle(
                            color: widget.alertStatus == "IN PROGRESS"
                                ? Colors.orange
                                : (widget.alertStatus == "SAFE"
                                    ? Colors.green
                                    : kPrimaryColor),
                            fontSize: 14),
                      ),
                  ]),
            ),
          )),
      Positioned(
          bottom: kHeight(context) * 0.23,
          left: kWidth(context) * 0.27,
          child: Container(
            height: widget.profilUrlSize,
            width: widget.profilUrlSize,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.profilUrl)),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: kSecondaryColor)),
          )),
      Positioned(
          top: kHeight(context) * 0.22,
          left: kWidth(context) * 0.045,
          child: Container(
            width: kWidth(context) * 0.61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: kWidth(context) * 0.25,
                    height: kWidth(context) * 0.25 / 2.5,
                    child: DefaultBtn(
                        event: () {},
                        titleSize: 13,
                        title: "Accept",
                        bgColor: kSecondaryColor)),
                Container(
                    width: kWidth(context) * 0.25,
                    height: kWidth(context) * 0.25 / 2.5,
                    child: DefaultBtn(
                        event: () {},
                        title: "Decline",
                        titleSize: 13,
                        bgColor: kPrimaryColor))
              ],
            ),
          ))
    ]);
  }
}
