import 'package:sos_vision/views/homepage/adminView.dart';
import 'package:sos_vision/views/homepage/employeeView.dart';
import "package:flutter/material.dart";

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    String view = "ADMIN";

    return view == "USER" ? EmployeeView() : AdminView();
  }
}
