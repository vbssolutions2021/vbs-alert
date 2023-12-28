import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:sos_vision/models/alert.dart';
import 'package:sos_vision/models/alertPivot.dart';
import 'package:sos_vision/models/apiResponseModel.dart';
import 'package:sos_vision/models/employee.dart';
import 'package:sos_vision/services/firbase_sevices.dart';
import 'package:sos_vision/services/local_db_services.dart';

const token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTcwMjA1MDIzOSwiZXhwIjoxNzMzNTg2MjM5fQ.vlAMLEwlVnkDYZRt5pz9QqaJtWoenAbf76gvrcNBSHk";
Future<dynamic> axios(String url,
    {String methode = 'GET', Map<String, dynamic>? donnees}) async {
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };

  http.Response response;

  try {
    switch (methode) {
      case 'GET':
        response = await http.get(Uri.parse(url), headers: headers);
        break;
      case 'POST':
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(donnees));
        break;
      case 'PUT':
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(donnees));
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse(url), headers: headers);
        break;
      default:
        throw Exception("Méthode HTTP non supportée");
    }

    print(response.body);
    return json.decode(response.body);
  } catch (e) {
    print(e);
    return {"message": "$e"};
  }
}

Future<ApiResponseModel> loginAPI(String phone, String password) async {
  final response = await axios(
      'https://sore-gray-cygnet-wear.cyclic.app/api/login',
      methode: 'POST',
      donnees: {'phone_number': phone, 'password': password});

  try {
    if (response["message"] == "L'utilisateur s'est connecté avec succès.") {
      await DatabaseManager.instance.addEmployee(Employee(
          companyId: response["data"]['companyId'],
          employeeId: response["data"]['employeeId'],
          firstname: response["data"]['firstname'],
          lastname: response["data"]['lastname'],
          password: password,
          profilUrl: response["data"]['profilUrl'],
          phone_number: response["data"]['phone_number'],
          role: response["data"]['role'],
          job: response["data"]['job'],
          companyName: response['data']['companyName']));
    }

    return ApiResponseModel(
        message: response["message"], data: response["data"]);
  } catch (e) {
    return ApiResponseModel(message: "$e");
  }
}

Future<ApiResponseModel> addAlertApi(
    AlertPivot alertPivot, double longitude, double latitude) async {
  final response = await axios(
      'https://sore-gray-cygnet-wear.cyclic.app/api/alerts',
      methode: 'POST',
      donnees: {
        'companyId': alertPivot.employee.companyId,
        'employeeId': alertPivot.employee.employeeId,
        'alertType': alertPivot.alert.alertType,
        'alertStatus': alertPivot.alert.alertStatus,
        'alertLocation': {
          'longitude': longitude,
          'latitude': latitude,
        },
      });

  try {
    if (response["message"] == true) {
      await addAlertPivot(
        alert: Alert(
          alertDatetime: alertPivot.alert.alertDatetime,
          alertId: response["data"]["alert"]['alertId'],
          alertLocation: alertPivot.alert.alertLocation,
          alertStatus: alertPivot.alert.alertStatus,
          alertType: alertPivot.alert.alertType,
          companyId: alertPivot.alert.companyId,
        ),
        employee: alertPivot.employee,
        employeeAlertId: response["data"]["employeeAlertId"],
      );
    }

    return ApiResponseModel(
        message: response["message"], data: response["data"]);
  } catch (e) {
    return ApiResponseModel(message: e);
  }
}
