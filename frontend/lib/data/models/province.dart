class Province {
  final int id;
  final String name;

  const Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: (json['id'] as num?)?.toInt() ?? 0,
        name: (json['name'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
