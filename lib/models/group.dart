import 'package:college_platform_mobile/models/student_group.dart';

class Group {
  final String name;
  final int? curatorId;
  final String? curatorName;
  final String? curatorSurname;
  final String? curatorPatronim;
  final int? leaderId;
  final String? leaderName;
  final String? leaderSurname;
  final String? leaderPatronim;
  final List<StudentGroup> students;

  Group({
    required this.name,
    this.curatorId,
    this.curatorName,
    this.curatorSurname,
    this.curatorPatronim,
    this.leaderId,
    this.leaderName,
    this.leaderSurname,
    this.leaderPatronim,
    required this.students,
  });
}
