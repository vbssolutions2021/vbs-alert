import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_vision/models/alert.dart';
import 'package:sos_vision/models/alertPivot.dart';
import 'package:sos_vision/models/employee.dart';

Stream<List<AlertPivot>> streamAlertPivots(int companyId) {
  return FirebaseFirestore.instance
      .collection('alert_pivot')
      .where('companyId', isEqualTo: companyId)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((doc) => AlertPivot.fromFirestore(doc))
        .toList();
  });
}

Future<void> addAlertPivot({
  required Alert alert,
  required Employee employee,
  required int employeeAlertId,
}) async {
  try {
    await FirebaseFirestore.instance.collection('alert_pivot').add({
      'alert': alert.toMap(),
      'employee': employee.toMap(),
      'employeeAlertId': employeeAlertId,
    });
    print('Document added successfully!');
  } catch (e) {
    print('Error adding document: $e');
  }
}
