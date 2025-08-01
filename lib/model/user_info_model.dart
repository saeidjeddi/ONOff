class UserinfoModel {
  String? username;
  String? email;
  String? fullName;
  String? department;



  UserinfoModel();



  UserinfoModel.fromJson(Map<String, dynamic> element) {
    username = element['username'];
    email = element['email'];
    fullName = element['full_name'];
    department = element['department'];

  }
}
