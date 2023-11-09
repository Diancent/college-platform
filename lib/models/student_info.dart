class StudentInfo {
  final String email;
  final String name;
  final String surname;
  final String patronim;
  final bool isBudget;
  final int groupId;
  final String studentCardNumber;
  final DateTime entryDate;
  final int ukrainianLanguageScore;
  final int mathematicsScore;
  final int diplomaGrade;
  final int competitiveScore;

  StudentInfo({
    required this.email,
    required this.name,
    required this.surname,
    required this.patronim,
    required this.isBudget,
    required this.groupId,
    required this.studentCardNumber,
    required this.entryDate,
    required this.ukrainianLanguageScore,
    required this.mathematicsScore,
    required this.diplomaGrade,
    required this.competitiveScore,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      patronim: json['patronim'],
      isBudget: json['isBudget'],
      groupId: json['groupId'],
      studentCardNumber: json['studentCardNumber'],
      entryDate: DateTime.parse(json['entryDate']),
      ukrainianLanguageScore: json['ukrainianLanguageScore'],
      mathematicsScore: json['mathematicsScore'],
      diplomaGrade: json['diplomaGrade'],
      competitiveScore: json['competitiveScore'],
    );
  }
}
