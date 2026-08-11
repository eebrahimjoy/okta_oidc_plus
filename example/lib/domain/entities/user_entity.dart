class UserEntity {
  final String id;
  final String name;
  final String email;
  final String preferredUsername;
  final Map<String, dynamic> rawClaims;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.preferredUsername,
    required this.rawClaims,
  });

  factory UserEntity.empty() {
    return const UserEntity(
      id: '',
      name: 'Guest',
      email: '',
      preferredUsername: '',
      rawClaims: {},
    );
  }
}
