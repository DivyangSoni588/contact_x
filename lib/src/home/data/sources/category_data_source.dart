import 'package:contact_x/src/home/domain/models/category.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getAllCategories();

  Future<void> deleteCategory({required int id});

  Future<void> addCategory({required Category category});
}
