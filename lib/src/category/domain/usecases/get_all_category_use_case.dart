import 'package:contact_x/src/category/domain/models/category.dart';
import 'package:contact_x/src/category/domain/repositories/category_repository.dart';

class GetAllCategoryUseCase {
  final CategoryRepository repository;

  GetAllCategoryUseCase(this.repository);

  Future<List<Category>> execute() async {
    return repository.getAllCategories();
  }
}
