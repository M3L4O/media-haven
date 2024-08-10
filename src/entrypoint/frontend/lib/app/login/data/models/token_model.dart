class TokenModel {
  String? access;
  String? username;
  String? email;
  String? refresh;

  TokenModel({
    this.access,
    this.username,
    this.email,
    this.refresh,
  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    username = json['username'];
    email = json['email'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['username'] = username;
    data['email'] = email;
    data['refresh'] = refresh;
    return data;
  }
}
