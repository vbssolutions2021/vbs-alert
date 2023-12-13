import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_vision/models/alert.dart';
import 'package:sos_vision/models/employee.dart';

class AlertPivot {
  final Alert alert;
  final Employee employee;
  final int employeeAlertId;

  AlertPivot({
    required this.alert,
    required this.employee,
    required this.employeeAlertId,
  });

  factory AlertPivot.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AlertPivot(
      alert: Alert.fromMap(data['alert']),
      employee: Employee.fromMap(data['employee']),
      employeeAlertId: data['employeeAlertId'],
    );
  }
}
