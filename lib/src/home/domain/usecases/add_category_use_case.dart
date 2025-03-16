import 'package:contact_x/src/home/domain/models/category.dart';
import 'package:contact_x/src/home/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> execute(Category category) async {
    repository.addCategory(category: category);
  }
}
