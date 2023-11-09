class GetSubject {
  final int id;
  final String name;

  GetSubject({required this.id, required this.name});

  factory GetSubject.fromJson(Map<String, dynamic> json) {
    return GetSubject(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
