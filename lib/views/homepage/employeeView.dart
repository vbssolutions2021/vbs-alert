import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sos_vision/models/alert.dart';
import 'package:sos_vision/models/employee.dart';
import 'package:sos_vision/services/firbase_sevices.dart';
import 'package:sos_vision/views/constants.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  bool isPressed = false;

  bool sirene = false;

  void alert() async {
    await addAlertPivot(
      alert: Alert(
        alertDatetime: Timestamp.now(),
        alertId: 123,
        alertLocation: GeoPoint(5.34877, -4.1444797),
        alertStatus: 'IN DANGER',
        alertType: 'NEED HELP',
        companyId: 456,
      ),
      employee: Employee(
        companyId: 456,
        employeeId: 789,
        firstname: 'John',
        password: "Kind@1404",
        lastname: 'Doe',
        phone_number: '+1234567890',
        role: 'USER',
        function: 'Software Developer',
      ),
      employeeAlertId: 1,
    );

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel', //Same as above in initilize,
        actionType: ActionType.Default,
        largeIcon:
            "https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png",
        title: 'Harouna KINDA 🆘🆘🆘',
        body: 'needs help ✋✋✋',
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        autoDismissible: false,
        fullScreenIntent: true,
        roundedLargeIcon: true,
        criticalAlert: true,
        //Other parameters
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(
          key: 'accept',
          label: 'Accept',
          color: kSecondaryColor,
        ),
        NotificationActionButton(
          key: 'reject',
          label: 'Reject',
          color: kPrimaryColor,
        ),
      ],
    );

    HapticFeedback.vibrate();
  }

  void launchSirene() async {
    setState(() {
      sirene = true;
    });
    await Future.delayed(Duration(seconds: 10), () {
      setState(() {
        sirene = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFE7ECEF);
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 5.0 : 30.0;
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          leading: Icon(
            Bootstrap.person_circle,
            size: 30,
            color: kWhite,
          ),
          actions: <Icon>[
            Icon(
              Bootstrap.bell,
              size: 30,
              color: kWhite,
            ),
          ],
          title: AutoSizeText(
            "VBSAlert",
            style: TextStyle(
                color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Image.asset(
                "assets/images/Alert.${sirene ? "gif" : "png"}",
                scale: sirene ? 6.4 : 4,
              ),
            ),
            Expanded(
              child: Center(
                child: Listener(
                  onPointerUp: (_) => setState(() {
                    isPressed = false;
                    alert();
                    launchSirene();
                  }),
                  onPointerDown: (_) => setState(() {
                    isPressed = true;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: bgColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: blur,
                              offset: -distance,
                              color: Colors.white,
                              inset: isPressed),
                          BoxShadow(
                              blurRadius: blur,
                              offset: distance,
                              color: const Color(0xFFA7A9AF),
                              inset: isPressed)
                        ]),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/images/alert_btn.png"),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              elevation: 20,
              child: SizedBox(
                width: double.infinity,
                height: kWidth(context) * 0.14,
              ),
            )
          ]),
        ));
  }
}
