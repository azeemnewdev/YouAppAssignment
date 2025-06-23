class User {
  final String email;
  String? accessToken;
  String? username;
  String? displayName;
  DateTime? birthDay;
  int? gender;
  String? height;
  String? weight;
  String? horoscope;
  String? zodiac;
  String? image;
  List<String>? interests;

  User({
    required this.email,
    this.accessToken,
    this.username,
    this.displayName,
    this.birthDay,
    this.gender,
    this.height,
    this.weight,
    this.horoscope,
    this.zodiac,
    this.image,
    this.interests,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accessToken': accessToken,
      'username': username,
      'displayName': displayName,
      'birthDay': birthDay?.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'horoscope': horoscope,
      'zodiac': zodiac,
      'image': image,
      'interests': interests,
    };
  }

  // Create object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      accessToken: json['accessToken'],
      username: json['username'],
      displayName: json['displayName'],
      birthDay: json['birthDay'] != null
          ? DateTime.parse(json['birthDay'])
          : null,
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      image: json['image'],
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : null,
    );
  }

  @override
  String toString() {
    return 'User(email: $email, username: $username, displayName: $displayName, birthDay: $birthDay)';
  }
}
