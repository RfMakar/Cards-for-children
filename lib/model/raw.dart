class Raw {
  final int id;
  final String raw;

  Raw({required this.id, required this.raw});

  factory Raw.fromMap(Map<String, dynamic> json) => Raw(
        id: json['id'],
        raw: json['raw'],
      );
}
