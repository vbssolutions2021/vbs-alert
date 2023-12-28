import 'package:sos_vision/models/employee.dart';
import 'package:sos_vision/services/local_db_services.dart';
import 'package:sos_vision/views/homepage/adminView.dart';
import 'package:sos_vision/views/homepage/employeeView.dart';
import "package:flutter/material.dart";
import 'package:sos_vision/views/loginpage/loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String view = "ADMIN";
  bool isConnect = false;

  void initState() {
    super.initState();
    //logout();
    fetchEmployeeInformation();
  }

  void logout() async {
    await DatabaseManager.instance.clearDatabase();
  }

  void fetchEmployeeInformation() async {
    final Employee? loggedInEmployee =
        await DatabaseManager.instance.getLoggedInEmployee();

    if (loggedInEmployee != null) {
      setState(() {
        isConnect = true;
        view = loggedInEmployee.role;
      });
      print(loggedInEmployee);
    } else {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isConnect
        ? (view == "USER" ? EmployeeView() : AdminView())
        : Loginpage();
  }
}
