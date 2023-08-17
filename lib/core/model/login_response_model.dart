class LoginResponseModel {
  String? accessToken;
  User? user;

  LoginResponseModel({this.accessToken, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json['accessToken'] as String?,
        user: json['user'] == null ? null : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'user': user?.toJson(),
      };
}

class User {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;

  User({this.firstName, this.lastName, this.userName, this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        userName: json['user_name'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'user_name': userName,
        'email': email,
      };
}
