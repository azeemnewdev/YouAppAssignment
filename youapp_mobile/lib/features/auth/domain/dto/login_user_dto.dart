// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginUserDto {
  final String email;
  final String password;

  LoginUserDto(this.email, this.password);

  LoginUserDto copyWith({String? email, String? password}) {
    return LoginUserDto(email ?? this.email, password ?? this.password);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory LoginUserDto.fromMap(Map<String, dynamic> map) {
    return LoginUserDto(map['email'] as String, map['password'] as String);
  }

  String toJson() => json.encode(toMap());

  factory LoginUserDto.fromJson(String source) =>
      LoginUserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginUserDto(email: $email, password: $password)';

  @override
  bool operator ==(covariant LoginUserDto other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
