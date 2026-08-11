import 'dart:convert';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.preferredUsername,
    required super.rawClaims,
  });

  factory UserModel.fromJson(dynamic json) {
    Map<String, dynamic> claims = {};
    if (json is String) {
      try {
        claims = Map<String, dynamic>.from(jsonDecode(json));
      } catch (_) {}
    } else if (json is Map) {
      claims = Map<String, dynamic>.from(json);
    }

    return UserModel(
      id: (claims['sub'] ?? claims['id'] ?? '').toString(),
      name: (claims['name'] ?? claims['preferred_username'] ?? 'User').toString(),
      email: (claims['email'] ?? claims['preferred_username'] ?? '').toString(),
      preferredUsername: (claims['preferred_username'] ?? '').toString(),
      rawClaims: claims,
    );
  }
}
