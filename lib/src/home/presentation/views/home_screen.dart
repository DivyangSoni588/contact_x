import 'package:contact_x/core/constants/app_route_constants.dart';
import 'package:contact_x/core/extensions/context_extension.dart';
import 'package:contact_x/core/helper/app_ui_helper.dart';
import 'package:contact_x/core/resources/app_colors.dart';
import 'package:contact_x/core/resources/app_string_keys.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:contact_x/core/widgets/app_text_field.dart';
import 'package:contact_x/core/widgets/app_text_widget.dart';
import 'package:contact_x/core/widgets/common_app_bar.dart';
import 'package:contact_x/src/home/domain/models/category.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_bloc.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_event.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_state.dart';
import 'package:contact_x/src/home/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = AppRouteConstants.homeScreenRoute;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController addCategoryController;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
    addCategoryController = TextEditingController();
  }

  @override
  void dispose() {
    addCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryDuplicateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: CommonAppBar(
          leadingWidget: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
              );
            },
          ),
          appBarTitle: AppStringKeys.createAndStoreCategory,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 60),
                AppTextField(
                  textEditingController: addCategoryController,
                  hintText: context.appLocalizations.translate(AppStringKeys.addCategory),
                ),
                SizedBox(height: 34),
                ElevatedButton(
                  onPressed: () {
                    final text = addCategoryController.text.trim();
                    if (text.isNotEmpty) {
                      context.read<CategoryBloc>().add(AddCategory(Category(name: text)));
                      addCategoryController.clear();
                    } else {
                      AppUIHelper.showSnackBar(
                        context: context,
                        message: context.appLocalizations.translate(AppStringKeys.categoryAddError),
                      );
                    }
                  },
                  child: AppTextWidget(text: AppStringKeys.save, textStyle: AppTextStyle.boldFont),
                ),
                Expanded(
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CategoryLoaded) {
                        if (state.categories.isEmpty) {
                          return Align(
                            alignment: Alignment.center,
                            child: AppTextWidget(
                              text: AppStringKeys.noDataFound,
                              textStyle: AppTextStyle.regularBoldFont,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.categories.length,
                          padding: EdgeInsets.only(top: 32),
                          itemBuilder: (context, index) {
                            final Category category = state.categories[index];
                            return ListTile(
                              title: Text(category.name),
                              tileColor: AppColors.lightOrange,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showEditCategoryDialog(context, category);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<CategoryBloc>().add(
                                        DeleteCategory(category.id ?? -1),
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is CategoryError) {
                        return Center(child: Text("Error: ${state.message}"));
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showEditCategoryDialog(BuildContext context, Category category) {
    TextEditingController categoryController = TextEditingController(text: category.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AppTextWidget(
            text: AppStringKeys.enterCategoryName,
            textStyle: AppTextStyle.regularBoldFont,
          ),
          content: AppTextField(
            textEditingController: categoryController,
            hintText: context.appLocalizations.translate(AppStringKeys.enterCategoryName),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: AppTextWidget(text: AppStringKeys.cancel, textStyle: AppTextStyle.regularBoldFont),
            ),
            ElevatedButton(
              onPressed: () {
                final categoryName = categoryController.text.trim();
                if (categoryName.isNotEmpty) {
                  context.read<CategoryBloc>().add(
                    UpdateCategory(Category(name: categoryName, id: category.id)),
                  );
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: AppTextWidget(text: AppStringKeys.save, textStyle: AppTextStyle.boldFont),
            ),
          ],
        );
      },
    );
  }
}
