import 'package:desktop/models/member.dart';

class Tables {
  String table;
  List<Member>? members;

  Tables({required this.table, this.members = const []});
}
