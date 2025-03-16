import 'package:contact_x/src/category/domain/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();

  Future<void> deleteCategory({required int id});

  Future<void> addCategory({required Category category});

  Future<void> editCategory({required Category category});
}
