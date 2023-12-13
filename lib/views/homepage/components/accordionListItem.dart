import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sos_vision/views/constants.dart';

class AccordionListItem extends StatefulWidget {
  final String lastname;
  final String firstname;
  final String urlProfil;
  final String role;
  final String status;
  const AccordionListItem(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.status,
      required this.role,
      required this.urlProfil});

  @override
  State<AccordionListItem> createState() => _AccordionListItemState();
}

class _AccordionListItemState extends State<AccordionListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(widget.urlProfil)),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: kSecondaryColor)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${widget.lastname} ${widget.firstname}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kSecondaryColor, fontSize: 15),
                    ),
                    AutoSizeText(
                      widget.role,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kTextColor, fontSize: 13),
                    ),
                  ]),
            )
          ]),
        ),
        Container(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.status == "SAFE"
                      ? Colors.green
                      : (widget.status == "NEED HELP"
                          ? kPrimaryColor
                          : Colors.amber.shade100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {},
              child: AutoSizeText(
                widget.status,
                style: TextStyle(fontSize: 13, color: kWhite),
              )),
        )
      ]),
    );
  }
}
