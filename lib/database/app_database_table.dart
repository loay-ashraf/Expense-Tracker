import 'database_table.dart';

enum AppDatatbaseTable implements DatabaseTable {
  expenses('expenses');

  const AppDatatbaseTable(this.name);

  @override
  final String name;
}
