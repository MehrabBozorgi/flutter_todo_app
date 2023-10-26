import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

/// flutter packages pub run build_runner build
@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  bool isDone;

  UserModel({
    required this.username,
    required this.title,
    required this.description,
    required this.isDone,
  });
}
