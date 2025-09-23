import 'package:uuid/uuid.dart';

final uuid = Uuid();

String generateId() => uuid.v4();

class User {
  final String id = generateId();
  final String email;
  final String password;

  User({required this.email, required this.password});
}
