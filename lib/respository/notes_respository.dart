import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modles/note.dart';

class NotesRespository{
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

  static Future<Database> _database() async{
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), _dbName),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  static insert({required Note note}) async{
    final db = await _database();

    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }
  //
  // static Future<List<Note>> getNotes() async{
  //   final db = await _database();
  //
  //   // Query the table for all the dogs.
  //   final List<Map<String, Object?>> maps = await db.query(_tableName);
  //
  //   // Convert the list of each dog's fields into a list of `Dog` objects.
  //   return [
  //     for (final {
  //     'id': id as int,
  //     'title': title as String,
  //     'description': description as String,
  //     'createdAt': createdAt as DateTime,
  //     } in maps)
  //       Note(id: id, title: 'title', description: 'description', createdAt: DateTime.parse('createdAt')),
  //   ];
  // }

static Future<List<Note>> getNotes() async{
    final db = await _database();
    final List<Map<String,dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i){
      return Note(
          id: maps[i]['id'] as int,

          title: maps[i]['title'] as String,
          description: maps[i]['description'] as String,
          createdAt: DateTime.parse(maps[i]['createdAt']));
    });
}

 static update({required Note note}) async{
    final db = await _database();

    await db.update(
        _tableName,
        note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id]

        );
 }

 static delete({required Note note}) async{
   final db = await _database();
   await db.delete(_tableName,
   where: 'id =?',
    whereArgs: [note.id]);
 }

}