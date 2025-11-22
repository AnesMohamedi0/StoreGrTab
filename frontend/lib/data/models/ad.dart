class Ad {
  final int id;
  final String title;
  final String? imageUrl;
  final String? link;
  final bool isDark;

  Ad({
    required this.id,
    required this.title,
    this.imageUrl,
    this.link,
    this.isDark = false,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: int.tryParse(json['id'].toString()) ?? 0,
    title: (json['title'] as String?) ?? '',
    imageUrl: json['imageUrl'] as String?,
    link: json['link'] as String?,
    isDark: (json['isDark'] as bool?) ?? false,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'link': link,
      'isDark': isDark,
    };
  }
}
