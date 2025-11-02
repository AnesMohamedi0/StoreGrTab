class Admin {
  final String id;
  final String email;
  final String passwordHash;

  const Admin({
    required this.id,
    required this.email,
    required this.passwordHash,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: (json['id'] as String?) ?? '',
        email: (json['email'] as String?) ?? '',
        passwordHash: (json['passwordHash'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'passwordHash': passwordHash,
      };
}
