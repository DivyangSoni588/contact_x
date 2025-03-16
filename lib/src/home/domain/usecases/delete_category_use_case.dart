import 'package:contact_x/src/home/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> execute(int categoryId) async {
    repository.deleteCategory(id: categoryId);
  }
}
