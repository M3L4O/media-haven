class UserTokenParams {
  String? token;

  UserTokenParams({this.token});

  UserTokenParams.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = token;
    return data;
  }
}
