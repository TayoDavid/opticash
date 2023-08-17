class UserModel {
  String firstname;
  String lastname;
  String email;
  String password;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstname,
      "last_name": lastname,
      "email": email,
      "password": password,
    };
  }
}

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
