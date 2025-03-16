import 'package:contact_x/src/home/data/repositories/category_repository_impl.dart';
import 'package:contact_x/src/home/data/sources/category_dao.dart';
import 'package:contact_x/src/home/data/sources/category_data_source.dart';
import 'package:contact_x/src/home/data/sources/local_category_data_source.dart';
import 'package:contact_x/src/home/domain/repositories/category_repository.dart';
import 'package:contact_x/src/home/domain/usecases/add_category_use_case.dart';
import 'package:contact_x/src/home/domain/usecases/delete_category_use_case.dart';
import 'package:contact_x/src/home/domain/usecases/get_all_category_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Register Database DAO
  getIt.registerLazySingleton<CategoryDao>(() => CategoryDao());

  // Register Data Sources
  getIt.registerLazySingleton<CategoryDataSource>(
    () => LocalCategoryDataSource(getIt<CategoryDao>()),
  );

  // Register Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton(
    () => GetAllCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCategoryUseCase(getIt<CategoryRepository>()),
  );
}
