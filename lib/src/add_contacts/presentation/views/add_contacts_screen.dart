import 'package:contact_x/core/constants/app_route_constants.dart';
import 'package:contact_x/core/extensions/context_extension.dart';
import 'package:contact_x/core/helper/app_image_picker_helper.dart';
import 'package:contact_x/core/helper/app_ui_helper.dart';
import 'package:contact_x/core/resources/app_string_keys.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:contact_x/core/widgets/app_circular_image.dart';
import 'package:contact_x/core/widgets/app_dropdown_field.dart';
import 'package:contact_x/core/widgets/app_text_field.dart';
import 'package:contact_x/core/widgets/app_text_widget.dart';
import 'package:contact_x/core/widgets/common_app_bar.dart';
import 'package:contact_x/src/add_contacts/domain/models/contact.dart';
import 'package:contact_x/src/add_contacts/presentation/contact_bloc/contact_bloc.dart';
import 'package:contact_x/src/add_contacts/presentation/contact_bloc/contact_event.dart';
import 'package:contact_x/src/add_contacts/presentation/contact_bloc/contact_state.dart';
import 'package:contact_x/src/home/domain/models/category.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_bloc.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_event.dart';
import 'package:contact_x/src/home/presentation/add_or_edit_category_bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactsScreen extends StatefulWidget {
  static const routeName = AppRouteConstants.addContactsScreen;

  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addListenersToControllers();
    context.read<CategoryBloc>().add(LoadCategories());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        String? firstNameError;
        String? lastNameError;
        String? emailError;
        String? mobileNumberError;
        String? userImage;

        if (state is ContactValidationState) {
          firstNameError = state.firstNameError;
          lastNameError = state.lastNameError;
          emailError = state.emailError;
          mobileNumberError = state.mobileNumberError;
          userImage = state.imagePath;
        }
        return Scaffold(
          appBar: CommonAppBar(appBarTitle: AppStringKeys.addContacts),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () async {
                      final imagePath = await showImagePickerBottomSheet(
                        context: context,
                      );
                      if (imagePath != null) {
                        if (context.mounted) {
                          context.read<ContactBloc>().add(
                            SetContactImage(imagePath),
                          );
                        }
                      }
                    },
                    child: AppCircularImage(imagePath: userImage),
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    textEditingController: _firstNameController,
                    hintText: getText(AppStringKeys.firstName),
                    errorText: firstNameError ?? '',
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    textEditingController: _lastNameController,
                    hintText: getText(AppStringKeys.lastName),
                    errorText: lastNameError ?? '',
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    textEditingController: _emailController,
                    hintText: getText(AppStringKeys.email),
                    errorText: emailError ?? '',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    textEditingController: _mobileNumberController,
                    hintText: getText(AppStringKeys.mobileNumber),
                    errorText: mobileNumberError ?? '',
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 12),
                  // Category dropdown with loading state handling
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, categoryState) {
                      if (categoryState is CategoryLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (categoryState is CategoryError) {
                        return Text(
                          categoryState.message,
                          style: TextStyle(color: Colors.red),
                        );
                      } else if (categoryState is CategoryLoaded) {
                        // Get the current selected category from ContactState
                        dynamic selectedCategory;
                        if (state is ContactValidationState) {
                          selectedCategory = state.selectedCategory;
                        }

                        return AppDropdownField(
                          items:
                              categoryState.categories
                                  .map((category) => category.name)
                                  .toList(),
                          selectedValue: selectedCategory,
                          onChanged: (value) {
                            context.read<ContactBloc>().add(
                              SelectCategory(value),
                            );
                          },
                          hintText: getText(AppStringKeys.category),
                        );
                      } else {
                        return AppDropdownField(
                          items: [],
                          selectedValue: null,
                          onChanged: (_) {},
                          hintText: getText(AppStringKeys.category),
                        );
                      }
                    },
                  ),

                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: AppTextWidget(
                      text: AppStringKeys.save,
                      textStyle: AppTextStyle.boldFont,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getText(String text) {
    return context.appLocalizations.translate(text);
  }

  void _submitForm() {
    // Get current state values
    final contactState = context.read<ContactBloc>().state;
    String? imagePath;
    dynamic selectedCategory;

    if (contactState is ContactValidationState) {
      imagePath = contactState.imagePath;
      selectedCategory = contactState.selectedCategory;
    }

    // Get category ID if a category is selected
    int? categoryId;
    final categoryState = context.read<CategoryBloc>().state;
    if (categoryState is CategoryLoaded && selectedCategory != null) {
      final category = categoryState.categories.firstWhere(
        (category) => category.name == selectedCategory,
        orElse: () => Category(name: ''),
      );
      categoryId = category.id;
    }

    if (categoryId == null) {
      AppUIHelper.showSnackBar(
        context: context,
        message: 'Please choose or add category',
      );
      return;
    }

    // Validate all required fields
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _mobileNumberController.text.trim();

    // Check if any required field is empty
    if (firstName.isEmpty) {
      context.read<ContactBloc>().add(ValidateFirstName(''));
      return;
    }

    if (lastName.isEmpty) {
      context.read<ContactBloc>().add(ValidateLastName(''));
      return;
    }

    if (email.isEmpty) {
      context.read<ContactBloc>().add(ValidateEmail(''));
      return;
    }

    if (phone.isEmpty) {
      context.read<ContactBloc>().add(ValidateMobileNumber(''));
      return;
    }

    // Check for any validation errors in the current state
    if (contactState is ContactValidationState) {
      if (contactState.firstNameError != null ||
          contactState.lastNameError != null ||
          contactState.emailError != null ||
          contactState.mobileNumberError != null) {
        // Don't submit if there are validation errors
        return;
      }
    }

    // If all validations pass, create and add the contact
    final name = '$firstName $lastName';

    final contactModel = ContactModel(
      name: name,
      phone: phone,
      email: email,
      image: imagePath,
      categoryId: categoryId,
    );

    context.read<ContactBloc>().add(AddContact(contact: contactModel));
  }

  void addListenersToControllers() {
    _mobileNumberController.addListener(() {
      context.read<ContactBloc>().add(
        ValidateMobileNumber(_mobileNumberController.text),
      );
    });
    _firstNameController.addListener(() {
      context.read<ContactBloc>().add(
        ValidateFirstName(_firstNameController.text),
      );
    });
    _lastNameController.addListener(() {
      context.read<ContactBloc>().add(
        ValidateLastName(_lastNameController.text),
      );
    });
    _emailController.addListener(() {
      context.read<ContactBloc>().add(ValidateEmail(_emailController.text));
    });
  }

  static Future<String?> showImagePickerBottomSheet({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blue),
                title: AppTextWidget(
                  text: AppStringKeys.camera,
                  textStyle: AppTextStyle.regularFont,
                ),
                onTap: () async {
                  final image =
                      await AppImagePickerHelper().pickImageFromCamera();
                  if (context.mounted) {
                    Navigator.pop(context, image);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.green),
                title: AppTextWidget(
                  text: AppStringKeys.gallery,
                  textStyle: AppTextStyle.regularFont,
                ),
                onTap: () async {
                  final image =
                      await AppImagePickerHelper().pickImageFromGallery();
                  if (context.mounted) {
                    Navigator.pop(context, image);
                  }
                },
              ),
              SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
