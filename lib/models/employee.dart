class Employee {
  final int companyId;
  final int employeeId;
  final String firstname;
  final String password;
  final String lastname;
  final String phone_number;
  final String role;
  final String job;
  final String companyName;
  final String profilUrl;

  Employee(
      {required this.companyId,
      required this.employeeId,
      required this.firstname,
      required this.lastname,
      required this.password,
      required this.phone_number,
      required this.role,
      required this.job,
      required this.companyName,
      required this.profilUrl});

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
        companyId: map['companyId'],
        employeeId: map['employeeId'],
        password: map['password'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        phone_number: map['phone_number'],
        role: map['role'],
        job: map['job'],
        companyName: map['companyName'],
        profilUrl: map['profilUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'employeeId': employeeId,
      'firstname': firstname,
      'password': password,
      'lastname': lastname,
      'phone_number': phone_number,
      'role': role,
      'job': job,
      'companyName': companyName,
      'profilUrl': profilUrl
    };
  }
}
