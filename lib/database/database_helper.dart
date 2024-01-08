import 'dart:io' show Platform;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'database_table.dart';
import 'database_table_exists_extension.dart';

class DatabaseHelper<Table extends DatabaseTable> {
  DatabaseHelper({required Database database}) : _database = database;

  final Database _database;

  static Future<DatabaseHelper<Table>?> initialize<Table extends DatabaseTable>(
      {required String databaseFile}) async {
    String databasePath = '';
    if (Platform.isAndroid) {
      databasePath = join(await getDatabasesPath(), databaseFile);
    } else if (Platform.isIOS || Platform.isMacOS) {
      var libraryDirectory = await getLibraryDirectory();
      databasePath = join(libraryDirectory.path, databaseFile);
    }
    Database database = await openDatabase(databasePath);
    return DatabaseHelper<Table>(database: database);
  }

  Future createTable(
      {required Table table, required List<Map<String, Object>> fields}) async {
    if (!(await _database.tableExists(table.name))) {
      String query = 'CREATE TABLE ${table.name} (';
      for (final field in fields) {
        String fieldName = field['name'] as String;
        String fieldType = field['type'] as String;
        bool fieldIsPrimary = field['isPrimary'] as bool;
        query = '$query$fieldName $fieldType';
        if (fieldIsPrimary) {
          query = '$query PRIMARY KEY, ';
        } else {
          query = '$query, ';
        }
      }
      query = query.substring(0, query.length - 2);
      query = '$query)';
      await _database.execute(query);
    }
  }

  Future deleteTable({required Table table}) async {
    await _database.execute('DROP TABLE ${table.name}');
  }

  void addItem({required Table table, required Map<String, Object?> item}) {
    _database.insert(table.name, item);
  }

  void addItems(
      {required Table table, required List<Map<String, Object?>> items}) {
    if (items.isNotEmpty) {
      for (final item in items) {
        _database.insert(table.name, item);
      }
    }
  }

  Future<List<Map<String, Object?>>?> getItems(
      {required Table table, String? predicate}) async {
    if (await _database.tableExists(table.name)) {
      return await _database.query(table.name, where: predicate);
    } else {
      return null;
    }
  }

  void updateItems(
      {required Table table,
      required Map<String, Object?> item,
      String? predicate}) {
    _database.update(table.name, item, where: predicate);
  }

  void deleteItems({required Table table, String? predicate}) {
    _database.delete(table.name, where: predicate);
  }
}
