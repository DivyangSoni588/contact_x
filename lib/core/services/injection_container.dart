import 'package:contact_x/src/add_contacts/data/repositories/contact_repository_impl.dart';
import 'package:contact_x/src/add_contacts/data/sources/contact_dao.dart';
import 'package:contact_x/src/add_contacts/data/sources/contact_data_source.dart';
import 'package:contact_x/src/add_contacts/data/sources/local_contact_data_source.dart';
import 'package:contact_x/src/add_contacts/domain/repositories/contact_repository.dart';
import 'package:contact_x/src/add_contacts/domain/usecases/insert_contact_use_case.dart';
import 'package:contact_x/src/home/data/repositories/category_repository_impl.dart';
import 'package:contact_x/src/home/data/sources/category_dao.dart';
import 'package:contact_x/src/home/data/sources/category_data_source.dart';
import 'package:contact_x/src/home/data/sources/local_category_data_source.dart';
import 'package:contact_x/src/home/domain/repositories/category_repository.dart';
import 'package:contact_x/src/home/domain/usecases/add_category_use_case.dart';
import 'package:contact_x/src/home/domain/usecases/delete_category_use_case.dart';
import 'package:contact_x/src/home/domain/usecases/edit_category_use_case.dart';
import 'package:contact_x/src/home/domain/usecases/get_all_category_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Register Database DAO
  getIt.registerLazySingleton<CategoryDao>(() => CategoryDao());
  getIt.registerLazySingleton<ContactDao>(() => ContactDao());

  // Register Data Sources
  getIt.registerLazySingleton<CategoryDataSource>(
    () => LocalCategoryDataSource(getIt<CategoryDao>()),
  );
  getIt.registerLazySingleton<ContactDataSource>(
    () => LocalContactDataSource(getIt<ContactDao>()),
  );

  // Register Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDataSource>()),
  );
  getIt.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(getIt<ContactDataSource>()),
  );

  // Register Use Category Cases
  getIt.registerLazySingleton(
    () => GetAllCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCategoryUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => EditCategoryUseCase(getIt<CategoryRepository>()),
  );

  // Register Use Contact Cases
  getIt.registerLazySingleton(
    () => InsertContactUseCase(getIt<ContactRepository>()),
  );
}
