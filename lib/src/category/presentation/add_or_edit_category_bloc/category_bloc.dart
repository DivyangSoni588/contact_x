import 'package:contact_x/src/category/domain/usecases/add_category_use_case.dart';
import 'package:contact_x/src/category/domain/usecases/delete_category_use_case.dart';
import 'package:contact_x/src/category/domain/usecases/edit_category_use_case.dart';
import 'package:contact_x/src/category/domain/usecases/get_all_category_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoryUseCase _getAllCategoryUseCase =
      GetIt.instance.get<GetAllCategoryUseCase>();
  final AddCategoryUseCase _addCategoryUseCase =
      GetIt.instance.get<AddCategoryUseCase>();
  final DeleteCategoryUseCase _deleteCategoryUseCase =
      GetIt.instance.get<DeleteCategoryUseCase>();
  final EditCategoryUseCase _editCategoryUseCase =
      GetIt.instance.get<EditCategoryUseCase>();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await _getAllCategoryUseCase.execute();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Failed to load categories"));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is CategoryLoaded) {
        bool isDuplicate = currentState.categories.any(
          (category) =>
              category.name.toLowerCase() == event.category.name.toLowerCase(),
        );

        if (isDuplicate) {
          emit(CategoryDuplicateError("Category already exists"));
          emit(CategoryLoaded(currentState.categories));
          return;
        }
      }

      await _addCategoryUseCase.execute(event.category);
      add(LoadCategories()); // Refresh the list after adding
    } catch (e) {
      emit(CategoryError("Failed to add category"));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is CategoryLoaded) {
        bool isDuplicate = currentState.categories.any(
          (category) =>
              category.name.toLowerCase() == event.category.name.toLowerCase(),
        );

        if (isDuplicate) {
          emit(CategoryDuplicateError("Category already exists"));
          emit(CategoryLoaded(currentState.categories));
          return;
        }
      }

      await _editCategoryUseCase.execute(category: event.category);
      add(LoadCategories()); // Refresh the list after updating
    } catch (e) {
      emit(CategoryError("Failed to update category"));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _deleteCategoryUseCase.execute(event.categoryId);
      add(LoadCategories()); // Refresh the list after deleting
    } catch (e) {
      emit(CategoryError("Failed to delete category"));
    }
  }
}
