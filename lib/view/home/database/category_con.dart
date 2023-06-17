import 'dart:io';

import 'package:local_storage/global/constant/global.dart';
import 'package:local_storage/view/home/model/category_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class CategoryDB {
  Future<Database> initDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $categoryTableName($fCategoryId INTEGER PRIMARY KEY, $fCategoryName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<CategoryModel>> getCategory() async {
    var db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query(categoryTableName);
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<void> insertCategory(CategoryModel category) async {
    var db = await initDatabase();
    await db.insert(categoryTableName, category.toMap());
  }

  Future<void> updateCategory(CategoryModel category) async {
    var db = await initDatabase();
    await db.update(
      categoryTableName,
      category.toMap(),
      where: '$fCategoryId=?',
      whereArgs: [category.id],
    );
  }

  Future<void> deleteCategory(int categoryId) async {
    var db = await initDatabase();
    await db.delete(
      categoryTableName,
      where: '$fCategoryId=?',
      whereArgs: [categoryId],
    );
  }
}
