import 'dart:io';

import 'package:local_storage/global/constant/global.dart';
import 'package:local_storage/view/home/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class ProductDB {
  Future<Database> initDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'products.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $productTable($fProId INTEGER PRIMARY KEY, $fProName TEXT,$fProImage TEXT, $fProCategory TEXT, $fProPrice REAL,$fProRating REAL)',
        );
      },
      version: 1,
    );
  }

  Future<List<ProductModel>> getProduct() async {
    var db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query(productTable);
    return result.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<void> insertProduct(ProductModel pro) async {
    var db = await initDatabase();
    await db.insert(productTable, pro.toMap());
    print('Add product');
  }

  Future<void> updateProduct(ProductModel pro) async {
    var db = await initDatabase();
    await db.update(
      productTable,
      pro.toMap(),
      where: '$fProId=?',
      whereArgs: [pro.id],
    );
  }

  Future<void> deleteProduct(int proId) async {
    var db = await initDatabase();
    await db.delete(
      productTable,
      where: '$fProId=?',
      whereArgs: [proId],
    );
  }
}
