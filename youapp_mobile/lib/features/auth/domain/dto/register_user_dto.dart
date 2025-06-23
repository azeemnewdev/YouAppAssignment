// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterUserDto {
  final String email;
  final String username;
  final String password;

  RegisterUserDto(this.email, this.username, this.password);

  RegisterUserDto copyWith({
    String? email,
    String? username,
    String? password,
  }) {
    return RegisterUserDto(
      email ?? this.email,
      username ?? this.username,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory RegisterUserDto.fromMap(Map<String, dynamic> map) {
    return RegisterUserDto(
      map['email'] as String,
      map['username'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterUserDto.fromJson(String source) =>
      RegisterUserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterUserDto(email: $email, username: $username, password: $password)';

  @override
  bool operator ==(covariant RegisterUserDto other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ username.hashCode ^ password.hashCode;
}
