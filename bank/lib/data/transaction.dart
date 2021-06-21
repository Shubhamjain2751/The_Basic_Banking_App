import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  String sender;

  @HiveField(1)
  String receiver;

  @HiveField(2)
  String transaction_amount;

  @HiveField(3)
  DateTime time;
}
