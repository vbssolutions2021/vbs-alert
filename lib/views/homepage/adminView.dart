import 'package:accordion/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:geolocator/geolocator.dart";
import 'package:latlong2/latlong.dart';
import 'package:accordion/accordion.dart';
import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter_map_animations/flutter_map_animations.dart';
import "package:flutter/material.dart";
import 'package:icons_plus/icons_plus.dart';
import 'package:sos_vision/models/alert.dart';
import 'package:sos_vision/models/alertPivot.dart';
import 'package:sos_vision/models/employee.dart';
import 'package:sos_vision/services/firbase_sevices.dart';
import "package:sos_vision/views/constants.dart";
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sos_vision/views/homepage/components/accordionListItem.dart';
import "package:sos_vision/views/homepage/components/bottomBarBtn.dart";
import 'package:sos_vision/views/homepage/components/needHelpPopup.dart';
import 'package:sos_vision/views/homepage/components/alertBtn.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool sosStarted = false;
  double lat = 12.3095079;
  double long = -1.5389797;
  @override
  void initState() {
    super.initState();
    //launchPermissions();
  }

  void alert() async {
    await addAlertPivot(
      alert: Alert(
        alertDatetime: Timestamp.now(),
        alertId: 123,
        alertLocation: GeoPoint(5.34877, -4.1444797),
        alertStatus: 'IN PROGRESS',
        alertType: 'GENERAL',
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
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.glass,
      looping: false, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false,
    );
  }

  void stopAlert() {
    FlutterRingtonePlayer.stop();
  }

  void launchPermissions() async {
    await Geolocator.checkPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    });
    //await telephony.requestPhoneAndSmsPermissions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: kHeight(context) * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BottomBarBtn(icon: Icons.person, title: "Police"),
              InkWell(
                onTap: () {
                  if (sosStarted) {
                    stopAlert();
                    setState(() {
                      sosStarted = false;
                    });
                  } else {
                    alert();
                    setState(() {
                      sosStarted = true;
                    });
                  }
                },
                child: const AlertBtn(),
              ),
              const BottomBarBtn(
                  icon: BoxIcons.bxs_ambulance, title: "Medical/Fire"),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          child: Column(children: [
            Expanded(
                child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: kHeight(context) * 0.8,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(lat, long),
                        initialZoom: 16,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.sos_vision',
                        ),
                        StreamBuilder<List<AlertPivot>>(
                          stream:
                              streamAlertPivots(), // Utilisez la fonction de streaming que nous avons définie précédemment
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {}

                            List<AlertPivot> alertPivots = snapshot.data ?? [];

                            List<AnimatedMarker> animatedMarkers =
                                alertPivots.map((alertPivot) {
                              final LatLng point = LatLng(
                                alertPivot.alert.alertLocation.latitude,
                                alertPivot.alert.alertLocation.longitude,
                              );

                              return AnimatedMarker(
                                point: point,
                                width: kWidth(context) * 0.7,
                                height: kWidth(context) * 0.55 / 1,
                                builder: (_, animation) {
                                  final size = 50.0 * animation.value;
                                  return Container(
                                      child: Column(children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/user.jpg")),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: kSecondaryColor)),
                                    ),
                                    Icon(
                                      Bootstrap.geo_alt_fill,
                                      color: kPrimaryColor,
                                    ),
                                  ]));
                                },
                              );
                            }).toList();

                            return AnimatedMarkerLayer(
                              markers: animatedMarkers,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Accordion(
                    headerBorderColorOpened: Colors.transparent,
                    contentBackgroundColor: kWhite,
                    contentBorderColor: kSecondaryColor,
                    contentBorderWidth: 1,
                    contentHorizontalPadding: 15,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children: [
                      AccordionSection(
                        isOpen: false,
                        headerBorderRadius: 7,
                        leftIcon:
                            Icon(Bootstrap.geo_alt, color: kWhite, size: 18),
                        header: AutoSizeText(
                          ' ${sosStarted ? "Alerted employees" : "Employees needing help"}',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                        headerBackgroundColor: kSecondaryColor,
                        content: SizedBox(
                          height: kHeight(context) * 0.5,
                          child: StreamBuilder<List<AlertPivot>>(
                              stream: streamAlertPivots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {}

                                List<AlertPivot> alertPivots =
                                    snapshot.data ?? [];

                                // Faites quelque chose avec les données mises à jour
                                // (par exemple, mettez à jour votre interface utilisateur)

                                return ListView.builder(
                                    itemCount: alertPivots.length,
                                    itemBuilder: (context, index) {
                                      return AccordionListItem(
                                        role: alertPivots[index]
                                            .employee
                                            .function,
                                        firstname: alertPivots[index]
                                            .employee
                                            .firstname,
                                        lastname: alertPivots[index]
                                            .employee
                                            .lastname,
                                        urlProfil: "assets/images/user.jpg",
                                        status:
                                            alertPivots[index].alert.alertType,
                                      );
                                    });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: kHeight(context) * 0.4,
                    left: kWidth(context) * 0.15,
                    child: Container(
                        width: kWidth(context) * 0.7,
                        height: kWidth(context) * 0.55 / 1,
                        child: NeedHelpPopup(
                          name: "Harouna Kinda",
                          profilUrlSize: 50.0,
                          role: "Company IT",
                          alertType: "NEED HELP",
                          alertStatus: "IN DANGER",
                          phone: "74578186",
                          profilUrl: "assets/images/user.jpg",
                        )))
              ],
            )),
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
