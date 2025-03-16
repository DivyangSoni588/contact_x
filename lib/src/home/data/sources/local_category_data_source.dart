import 'package:contact_x/src/home/data/sources/category_dao.dart';
import 'package:contact_x/src/home/data/sources/category_data_source.dart';
import 'package:contact_x/src/home/domain/models/category.dart';

class LocalCategoryDataSource implements CategoryDataSource {
  final CategoryDao categoryDao;

  LocalCategoryDataSource(this.categoryDao);
  @override
  Future<void> deleteCategory({required int id}) {
    categoryDao.deleteCategory(id);
    return Future.value();
  }

  @override
  Future<List<Category>> getAllCategories() {
    return categoryDao.getCategories();
  }

  @override
  Future<void> addCategory({required Category category}) {
    categoryDao.insertCategory(category);
    return Future.value();
  }

  @override
  Future<void> editCategory({required Category category}) {
    categoryDao.updateCategory(category);
    return Future.value();
  }
}
