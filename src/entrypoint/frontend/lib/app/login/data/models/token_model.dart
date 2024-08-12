class TokenModel {
  String? access;
  String? email;
  String? refresh;

  TokenModel({
    this.access,
    this.email,
    this.refresh,
  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    email = json['email'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['email'] = email;
    data['refresh'] = refresh;
    return data;
  }
}
