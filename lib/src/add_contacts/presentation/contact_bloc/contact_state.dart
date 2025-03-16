import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactValidationState extends ContactState {
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? mobileNumberError;
  final String? imageError;
  final dynamic selectedCategory;
  final String? imagePath; // Add this

  ContactValidationState({
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.mobileNumberError,
    this.imageError,
    this.selectedCategory,
    this.imagePath, // Add this
  });

  // Update copyWith to include imagePath
  ContactValidationState copyWith({
    String? firstNameError,
    String? lastNameError,
    String? emailError,
    String? mobileNumberError,
    String? imageError,
    Object? selectedCategory = const _Unset(),
    Object? imagePath = const _Unset(), // Add this
  }) {
    return ContactValidationState(
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
      emailError: emailError ?? this.emailError,
      mobileNumberError: mobileNumberError ?? this.mobileNumberError,
      imageError: imageError ?? this.imageError,
      selectedCategory:
          selectedCategory == const _Unset()
              ? this.selectedCategory
              : selectedCategory,
      imagePath:
          imagePath == const _Unset()
              ? this.imagePath
              : imagePath as String?, // Add this
    );
  }

  @override
  List<Object?> get props => [
    firstNameError,
    lastNameError,
    emailError,
    mobileNumberError,
    imageError,
    selectedCategory,
    imagePath,
  ];
}

// Sentinel class for optional parameters
class _Unset {
  const _Unset();
}

class ContactAdded extends ContactState {}

class ContactError extends ContactState {
  final String message;
  ContactError(this.message);

  @override
  List<Object?> get props => [message];
}
