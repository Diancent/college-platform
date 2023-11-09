import 'package:college_platform_mobile/models/subject.dart';

class Semester {
  final int semesterNumber;

  List<Subject> subjects;

  Semester({required this.semesterNumber, required this.subjects});
}
