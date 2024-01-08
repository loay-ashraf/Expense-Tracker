import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'category.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class Expense {
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Expense.withID({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  factory Expense.fromMap({required Map<String, Object?> map}) {
    var id = map['id'] as String;
    var title = map['title'] as String;
    var amount = map['amount'] as double;
    var date = formatter.parse(map['date'] as String);
    var category = Category.fromValue(map['category'] as String);
    return Expense(
        id: id, title: title, amount: amount, date: date, category: category);
  }

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, Object?> get map {
    var id = this.id;
    var title = this.title;
    var amount = this.amount;
    var date = formatter.format(this.date);
    var category = this.category.value;
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category
    };
  }
}
