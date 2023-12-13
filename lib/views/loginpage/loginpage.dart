import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sos_vision/views/components/defaltBtn.dart';
import 'package:sos_vision/views/components/defaultTextField.dart';
import 'package:sos_vision/views/constants.dart';
import 'package:sos_vision/views/homepage/homepage.dart';
import 'package:sos_vision/views/loginpage/components/autorizationItem.dart';
import 'package:sos_vision/views/loginpage/components/companyBadge.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool isAgree = false;
  bool isLogin = false;
  PageController controller = PageController();
  final loader = SpinKitCircle(
    color: kSecondaryColor,
    size: 50.0,
  );

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void toStart() async {
    if (!isAgree) {
    } else {
      //Go to login Page
      toPage(1);
    }
  }

  void login(String phone, String password) async {
    setState(() {
      isLogin = true;
    });
    await Future.delayed(Duration(milliseconds: 3000), () {
      toPage(2);
    });
    setState(() {
      isLogin = false;
    });
  }

  void toPage(int page) {
    controller.animateToPage(page,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              height: kHeight(context) * 0.5,
              width: kWidth(context),
              decoration: BoxDecoration(color: kWhite),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: kHeight(context) * 0.08,
                    ),
                    AutoSizeText(
                      "VBSAlert",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      "votre assistance en danger est un droit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: kHeight(context) * 0.03),
                    Container(
                        child: Image.asset("assets/images/started-img.png",
                            scale: kHeight(context) / (kWidth(context) * 0.6)))
                  ]),
            ),
          ),
          Positioned(
              top: kHeight(context) * 0.5,
              child: Container(
                height: kHeight(context) * 0.5,
                width: kWidth(context),
                decoration: BoxDecoration(color: kPrimaryColor),
              )),
          Positioned(
              top: kHeight(context) * 0.4,
              left: 0,
              child: Material(
                color: Colors.transparent,
                elevation: 40,
                child: Container(
                  height: kHeight(context) * 0.55,
                  width: kWidth(context),
                  color: Colors.transparent,
                  child: PageView(
                    controller: controller,
                    allowImplicitScrolling: false,
                    physics: NeverScrollableScrollPhysics(),
                    padEnds: false,
                    children: [
                      //================STARTED VIEW================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  height: kHeight(context) * 0.55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        AutorizationItem(
                                            icon: Bootstrap.geo_alt,
                                            title:
                                                "Geolocalisation en temps réel"),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        AutorizationItem(
                                            icon: Bootstrap.telephone_fill,
                                            title:
                                                "Appel immédiat en cas d'alerte"),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.65,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: isAgree,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isAgree = value!;
                                                  });
                                                },
                                                activeColor: kSecondaryColor,
                                              ),
                                              Container(
                                                width: kWidth(context) * 0.51,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAgree = !isAgree;
                                                      });
                                                    },
                                                    child: AutoSizeText(
                                                      "J'accepte les conditions et les politiques de confidentialités.",
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.5,
                                          child: DefaultBtn(
                                              event: () {
                                                toStart();
                                              },
                                              titleSize: 15,
                                              title: "COMMENCER",
                                              bgColor: kSecondaryColor),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.02,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.5,
                                          child: AutoSizeText(
                                            "En continuant vous acceptez être géolocaliser ou/et téléphoner via VBSAlert en cas d'alerte de votre part.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                        ],
                      ),

                      //================LOGIN VIEW================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  height: kHeight(context) * 0.55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: kHeight(context) * 0.02,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () => toPage(0),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 27,
                                                ),
                                              ),
                                              Container()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.08,
                                        ),
                                        DefaultTextField(
                                            controller: _phoneController,
                                            hintText: 'Ex:+226 60 60 60 60',
                                            title: "Téléphone",
                                            prefixIcon:
                                                Bootstrap.telephone_fill,
                                            width: kWidth(context) * 0.55),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        DefaultTextField(
                                            controller: _passwordController,
                                            hintText:
                                                'Entrer votre mot de passe',
                                            title: "Mot de passe",
                                            obscurText: true,
                                            prefixIcon: Bootstrap.key_fill,
                                            width: kWidth(context) * 0.55),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.5,
                                          child: isLogin
                                              ? loader
                                              : DefaultBtn(
                                                  event: () {
                                                    login(
                                                        _phoneController.text,
                                                        _passwordController
                                                            .text);

                                                    _passwordController.clear();
                                                    _phoneController.clear();
                                                  },
                                                  titleSize: 15,
                                                  title: "SE CONNECTER",
                                                  bgColor: kSecondaryColor),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                        ],
                      ),

                      //================COMPANIES SELECT VIEW================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  height: kHeight(context) * 0.55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: kHeight(context) * 0.02,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () => toPage(1),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 27,
                                                ),
                                              ),
                                              Container()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.05,
                                        ),
                                        Container(
                                          width: kWidth(context) * 0.6,
                                          child: AutoSizeText(
                                            "Choisissez votre entreprise",
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: kHeight(context) * 0.05,
                                        ),
                                        CompanyBadge(
                                            company: "Vision Business Solution",
                                            event: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      duration: Duration(
                                                          milliseconds: 1000),
                                                      type: PageTransitionType
                                                          .scale,
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Homepage()));
                                            },
                                            logo: "assets/images/vbs-logo.jpg"),
                                        SizedBox(
                                          height: kHeight(context) * 0.03,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            width: kWidth(context) * 0.1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ]));
  }
}
