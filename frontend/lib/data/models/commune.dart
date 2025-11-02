class Commune {
  final int id;
  final String name;
  final int provinceId;

  const Commune({
    required this.id,
    required this.name,
    required this.provinceId,
  });

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: (json['id'] as num?)?.toInt() ?? 0,
        name: (json['name'] as String?) ?? '',
        provinceId: (json['provinceId'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'provinceId': provinceId,
      };
}
