class TokenModel {
  String? accessToken;
  String? username;

  TokenModel({
    this.accessToken,
    this.username,
  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['username'] = username;
    return data;
  }
}
