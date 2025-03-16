import 'package:contact_x/core/local_storage/database_manager.dart';
import 'package:contact_x/src/home/domain/models/category.dart';

class CategoryDao {
  Future<int> insertCategory(Category category) async {
    final db = await DatabaseHelper.database;
    return await db.insert(DatabaseHelper.categoryTable, category.toMap());
  }

  Future<List<Category>> getCategories() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.categoryTable,
    );
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  Future<int> updateCategory(Category category) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      DatabaseHelper.categoryTable,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      DatabaseHelper.categoryTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
