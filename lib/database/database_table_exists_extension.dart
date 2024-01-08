import 'package:sqflite/sqflite.dart';

extension TableExists on Database {
  Future<bool> tableExists(String table) async {
    var queryResult =
        await query('sqlite_master', where: 'name = ?', whereArgs: [table]);
    return queryResult.isNotEmpty;
  }
}
