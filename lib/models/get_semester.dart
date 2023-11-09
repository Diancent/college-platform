class GetSemester {
  final int id;
  final int value;

  GetSemester({required this.id, required this.value});

  factory GetSemester.fromJson(Map<String, dynamic> json) {
    return GetSemester(
      id: json['id'] as int,
      value: json['vale'] as int,
    );
  }
}
