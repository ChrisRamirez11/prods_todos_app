import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prods_todos_app/models/checked_product.dart';
import 'package:sqflite/sqflite.dart';


class CheckedProductsSqlite {
  Database? _database;
  CheckedProductsSqlite db = CheckedProductsSqlite._();

  CheckedProductsSqlite._();

  final String _table = 'Prods';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ProdsDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('CREATE TABLE $_table ('
            'id INTEGER PRIMARY KEY,'
            'name TEXT'
            'description TEXT'
            'state TEXT'
            ')');
      },
    );
  }

  //Adding checked product
  addProduct(CheckedProduct checkedProduct) async {
    final db = await database;

    final res = await db.insert(_table, checkedProduct.toMap());
    return res;
  }

  //Get all checked product
  Future<List<CheckedProduct>> getProducts() async {
    final db = await database;

    final res = await db.query(_table);

    final List<CheckedProduct> list = res.isNotEmpty
        ? res
            .map(
              (e) => CheckedProduct.fromMap(e),
            )
            .toList()
        : [];
    return list;
  }


  //Get Pagination checked Product
  Future<List<CheckedProduct>> getPaginatedProduct(int offset) async {
    final db = await database;

    final res = await db.query(_table, limit: 7, offset: offset);
    final List<CheckedProduct> list = res.isNotEmpty
        ? res
            .map(
              (e) => CheckedProduct.fromMap(e),
            )
            .toList()
        : [];
    return list;
  }


  //Get Single checked Product
  Future<CheckedProduct?> getSingleProduct(int id) async {
    final db = await database;

    final res = await db.query(_table, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? CheckedProduct.fromMap(res.first) : null;
  }


  //Update checked Product
  Future<int> updateProduct(CheckedProduct checkedProduct) async {
    final db = await database;

    final res = await db.update(_table, checkedProduct.toMap(),
        where: 'id = ?', whereArgs: [checkedProduct.id]);
    return res;
  }

  //Delete product
  Future<int> deleteProduct(int id) async {
    final db = await database;

    final res = await db.delete(_table, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //Delete all products
  Future<int> deleteAll() async {
    final db = await database;

    final res = await db.delete(_table);
    return res;
  }
}
