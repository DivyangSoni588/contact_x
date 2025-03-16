import 'package:contact_x/src/category/domain/models/category.dart';
import 'package:contact_x/src/category/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> execute(Category category) async {
    repository.addCategory(category: category);
  }
}
