import 'package:contact_x/src/home/domain/models/category.dart';
import 'package:contact_x/src/home/domain/repositories/category_repository.dart';

class EditCategoryUseCase {
  final CategoryRepository repository;

  EditCategoryUseCase(this.repository);

  Future<void> execute({required Category category}) async {
    repository.editCategory(category: category);
    return Future.value();
  }
}
