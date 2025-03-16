import 'package:contact_x/core/local_storage/database_manager.dart';
import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  Future<int> insertContact(ContactModel contact) async {
    final db = await DatabaseHelper.database;
    return await db.insert(DatabaseHelper.contactTable, contact.toMap());
  }

  Future<List<ContactModel>> getContacts({int? categoryId}) async {
    final db = await DatabaseHelper.database;
    List<Map<String, dynamic>> maps;

    if (categoryId != null) {
      maps = await db.query(
        DatabaseHelper.contactTable,
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
    } else {
      maps = await db.query(DatabaseHelper.contactTable);
    }

    return maps.map((e) => ContactModel.fromMap(e)).toList();
  }

  Future<int> updateContact(ContactModel contact) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      DatabaseHelper.contactTable,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      DatabaseHelper.contactTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ContactModel>> searchContacts(String searchQuery) async {
    final db = await DatabaseHelper.database;

    List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.contactTable,
      where: 'name LIKE ? OR phone LIKE ? OR email LIKE ?',
      whereArgs: ['%$searchQuery%', '%$searchQuery%', '%$searchQuery%'],
    );

    return maps.map((e) => ContactModel.fromMap(e)).toList();
  }
}
