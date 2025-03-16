import 'dart:async';

import 'package:contact_x/core/constants/app_route_constants.dart';
import 'package:contact_x/core/extensions/context_extension.dart';
import 'package:contact_x/core/resources/app_colors.dart';
import 'package:contact_x/core/resources/app_string_keys.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:contact_x/core/widgets/app_circular_image.dart';
import 'package:contact_x/core/widgets/app_text_field.dart';
import 'package:contact_x/core/widgets/app_text_widget.dart';
import 'package:contact_x/core/widgets/common_app_bar.dart';
import 'package:contact_x/src/category/domain/models/category.dart';
import 'package:contact_x/src/category/presentation/add_or_edit_category_bloc/category_bloc.dart';
import 'package:contact_x/src/category/presentation/add_or_edit_category_bloc/category_event.dart';
import 'package:contact_x/src/category/presentation/add_or_edit_category_bloc/category_state.dart';
import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/presentation/contacts_bloc/contacts_bloc.dart';
import 'package:contact_x/src/contacts/presentation/contacts_bloc/contacts_event.dart';
import 'package:contact_x/src/contacts/presentation/contacts_bloc/contacts_state.dart';
import 'package:contact_x/src/contacts/presentation/widgets/filter_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListScreen extends StatefulWidget {
  static const String routeName = AppRouteConstants.contactListScreen;

  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _searchContactController = TextEditingController();
  final _selectedCategoryController = StreamController<Category?>.broadcast();
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(GetAllContactsEvent());
    context.read<CategoryBloc>().add(LoadCategories());
    addSearchTextControllerListener();
  }

  @override
  void dispose() {
    _searchContactController.dispose();
    _selectedCategoryController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        appBarTitle: AppStringKeys.contactList,
        actionWidgets: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              if (categoryState is CategoryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (categoryState is CategoryError) {
                return Text(categoryState.message, style: TextStyle(color: Colors.red));
              } else if (categoryState is CategoryLoaded) {
                return StreamBuilder<Category?>(
                  stream: _selectedCategoryController.stream,
                  initialData: _selectedCategory,
                  builder: (context, snapshot) {
                    final selectedCategory = snapshot.data;

                    return Row(
                      children: [
                        if (selectedCategory != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.lightOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  selectedCategory.name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    _clearFilter();
                                  },
                                  child: Icon(Icons.close, size: 14),
                                ),
                              ],
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            _showFilterDialogWidget(
                              categoryState.categories,
                              selectedCategory,
                              _applyFilter,
                            );
                          },
                          icon: Icon(
                            Icons.filter_alt,
                            color: selectedCategory != null ? Theme.of(context).primaryColor : null,
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: AppTextField(
              textEditingController: _searchContactController,
              hintText: context.appLocalizations.translate(AppStringKeys.searchContacts),
            ),
          ),
          Expanded(
            child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                if (state is ContactsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContactsLoaded) {
                  return _buildContactList(state.contacts);
                } else if (state is ContactsError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                }
                return const Center(child: Text("No contacts found."));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(List<ContactModel> contacts) {
    if (contacts.isEmpty) {
      return Center(
        child: AppTextWidget(text: AppStringKeys.noDataFound, textStyle: AppTextStyle.regularBoldFont),
      );
    }

    return ListView.builder(
      itemCount: contacts.length,
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: AppCircularImage(size: 40, imagePath: contact.image),
            title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(contact.phone),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditContactBottomSheet(context, contact);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    if (contact.id != null) {
                      context.read<ContactsBloc>().add(DeleteContactEvent(contact.id!));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditContactBottomSheet(BuildContext context, ContactModel contact) {
    TextEditingController firstNameController = TextEditingController(text: contact.name);
    TextEditingController phoneController = TextEditingController(text: contact.phone);
    TextEditingController emailController = TextEditingController(text: contact.email);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextWidget(text: AppStringKeys.editContact, textStyle: AppTextStyle.regularBoldFont),

              SizedBox(height: 10),

              // First Name
              AppTextField(textEditingController: firstNameController, hintText: AppStringKeys.lastName),
              SizedBox(height: 20),
              // Email
              AppTextField(
                textEditingController: emailController,
                hintText: AppStringKeys.email,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              // Mobile Number
              AppTextField(
                textEditingController: phoneController,
                hintText: AppStringKeys.mobileNumber,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (firstNameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    ContactModel updatedContact = ContactModel(
                      id: contact.id,
                      name: firstNameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      categoryId: contact.categoryId,
                    );

                    // Dispatch update event
                    context.read<ContactsBloc>().add(EditContactEvent(updatedContact));

                    // Close bottom sheet
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Please enter valid details!")));
                  }
                },
                child: AppTextWidget(text: AppStringKeys.save, textStyle: AppTextStyle.boldFont),
              ),

              SizedBox(height: 64),
            ],
          ),
        );
      },
    );
  }

  void addSearchTextControllerListener() {
    _searchContactController.addListener(() {
      final String searchText = _searchContactController.text.trim();
      if (searchText.isEmpty) {
        _reloadContacts();
      } else {
        _clearFilter();
        context.read<ContactsBloc>().add(SearchContactEvent(searchText));
      }
    });
  }

  void _showFilterDialogWidget(
    List<Category> categories,
    Category? selectedCategory,
    Function(Category?) onApply,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => FilterDialogWidget(
            categories: categories,
            selectedCategory: selectedCategory,
            onApply: onApply,
          ),
    );
  }

  void _applyFilter(Category? category) {
    _selectedCategory = category;
    _selectedCategoryController.add(category);
    _reloadContacts();
  }

  void _clearFilter() {
    _selectedCategory = null;
    _selectedCategoryController.add(null);
    _reloadContacts();
  }

  void _reloadContacts() async {
    if (_selectedCategory != null) {
      _searchContactController.clear();
      await Future.delayed(Duration(milliseconds: 500));

      filterContacts();
    } else if (_searchContactController.text.isNotEmpty) {
      context.read<ContactsBloc>().add(SearchContactEvent(_searchContactController.text));
    } else {
      context.read<ContactsBloc>().add(GetAllContactsEvent());
    }
  }

  // Helper method to get the categoryId from the selected category name
  int? _getCategoryId() {
    if (_selectedCategory == null) {
      return null;
    }

    return _selectedCategory?.id;
  }

  void filterContacts() {
    context.read<ContactsBloc>().add(FilterContactsByCategoryEvent(_getCategoryId() ?? -1));
  }
}
