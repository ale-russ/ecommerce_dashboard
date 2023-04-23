import 'dart:convert';

class Users {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? userId;

  Users({
    this.email,
    this.firstName,
    this.lastName,
    this.userId,
  });
  Users copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? userId,
  }) {
    return Users(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userId': userId
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'users(email: $email, firstName: $firstName, lastName: $lastName, userId: $userId)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
    return other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        userId.hashCode;
  }
}
