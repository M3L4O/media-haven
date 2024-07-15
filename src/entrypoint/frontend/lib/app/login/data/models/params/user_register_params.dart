class UserRegisterParams {
  String? name;
  String? email;
  String? password;

  UserRegisterParams({this.name, this.email, this.password});

  UserRegisterParams.fromJson(Map<String, dynamic> json) {
    name = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
