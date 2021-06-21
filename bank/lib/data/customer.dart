import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String accountType;

  @HiveField(3)
  int balance;

  @HiveField(4)
  String gender;
}
