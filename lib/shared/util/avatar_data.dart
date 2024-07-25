class AvatarData {
  final String avatarURL, avatarURLName;

  AvatarData({required this.avatarURL, required this.avatarURLName});

  factory AvatarData.fromJson(Map<String, dynamic> json) {
    return AvatarData(
        avatarURL: json['avatarURL'], avatarURLName: json['avatarURLName']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avatarURL': avatarURL,
      'avatarURLName': avatarURLName
    };
  }
}
