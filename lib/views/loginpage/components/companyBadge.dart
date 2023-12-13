import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sos_vision/views/constants.dart';

class CompanyBadge extends StatelessWidget {
  const CompanyBadge(
      {super.key,
      required this.company,
      required this.event,
      required this.logo});
  final String company;
  final String logo;
  final Function event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        event();
      },
      child: Container(
        width: kWidth(context) * 0.65,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
              color: kWhite, border: Border.all(color: kPrimaryColor)),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: AssetImage(logo)),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: kSecondaryColor)),
              ),
              Container(
                width: kWidth(context) * 0.48,
                child: AutoSizeText(
                  " ${company} ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      backgroundColor: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
