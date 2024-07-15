class UserModel {
  String? token;
  String? name;

  UserModel({
    this.token,
    this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    return data;
  }
}
