import 'package:contact_x/src/category/data/sources/category_data_source.dart';
import 'package:contact_x/src/category/domain/models/category.dart';
import 'package:contact_x/src/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _categoryDataSource;

  CategoryRepositoryImpl(CategoryDataSource categoryDataSource)
    : _categoryDataSource = categoryDataSource;

  @override
  Future<void> deleteCategory({required int id}) {
    _categoryDataSource.deleteCategory(id: id);
    return Future.value();
  }

  @override
  Future<List<Category>> getAllCategories() {
    return _categoryDataSource.getAllCategories();
  }

  @override
  Future<void> addCategory({required Category category}) {
    _categoryDataSource.addCategory(category: category);
    return Future.value();
  }

  @override
  Future<void> editCategory({required Category category}) {
    _categoryDataSource.editCategory(category: category);
    return Future.value();
  }
}
