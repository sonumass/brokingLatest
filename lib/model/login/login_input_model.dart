class LoginInputModel {
  String username;
  String password;
  String type;

  LoginInputModel(
      {required this.username, required this.password, required this.type});

  Map toJson() => {'username': username, 'password': password, 'type': type};
}
