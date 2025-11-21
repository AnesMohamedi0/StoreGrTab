class Province {
  final int id;
  final String name;
  final double homeDeliveryFee;
  final double deskDeliveryFee;

  const Province({
    required this.id,
    required this.name,
    required this.homeDeliveryFee,
    required this.deskDeliveryFee,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: (json['id'] as num?)?.toInt() ?? 0,
    name: (json['name'] as String?) ?? '',
    homeDeliveryFee: (json['homeDeliveryFee'] as num?)?.toDouble() ?? 0.0,
    deskDeliveryFee: (json['deskDeliveryFee'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'homeDeliveryFee': homeDeliveryFee,
    'deskDeliveryFee': deskDeliveryFee,
  };
}
