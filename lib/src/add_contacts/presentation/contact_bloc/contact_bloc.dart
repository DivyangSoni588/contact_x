import 'package:contact_x/src/add_contacts/domain/usecases/insert_contact_use_case.dart';
import 'package:contact_x/src/add_contacts/presentation/contact_bloc/contact_event.dart';
import 'package:contact_x/src/add_contacts/presentation/contact_bloc/contact_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _mobileNumberError;
  String? _imageError;
  String? _imagePath;
  dynamic _selectedCategory;
  final InsertContactUseCase _insertContactUseCase =
      GetIt.instance.get<InsertContactUseCase>();

  ContactBloc() : super(ContactInitial()) {
    on<ValidateFirstName>(_validateFirstName);
    on<ValidateLastName>(_validateLastName);
    on<ValidateEmail>(_validateEmail);
    on<ValidateMobileNumber>(_validateMobileNumber);
    on<AddContact>(_addContact);
    on<SelectCategory>(_selectCategory);
    on<SetContactImage>(_setContactImage);
  }

  void _setContactImage(SetContactImage event, Emitter<ContactState> emit) {
    _imagePath = event.imagePath;
    _emitCurrentValidationState(emit);
  }

  void _selectCategory(SelectCategory event, Emitter<ContactState> emit) {
    _selectedCategory = event.category;
    _emitCurrentValidationState(emit);
  }

  void _validateFirstName(ValidateFirstName event, Emitter<ContactState> emit) {
    if (event.firstName.isEmpty) {
      _firstNameError = "First name cannot be empty";
    } else {
      _firstNameError = null;
    }
    _emitCurrentValidationState(emit);
  }

  void _validateLastName(ValidateLastName event, Emitter<ContactState> emit) {
    if (event.lastName.isEmpty) {
      _lastNameError = "Last name cannot be empty";
    } else {
      _lastNameError = null;
    }
    _emitCurrentValidationState(emit);
  }

  void _validateEmail(ValidateEmail event, Emitter<ContactState> emit) {
    if (event.email.isEmpty) {
      _emailError = "Email cannot be empty";
    } else if (!EmailValidator.validate(event.email)) {
      _emailError = "Invalid email format";
    } else {
      _emailError = null;
    }
    _emitCurrentValidationState(emit);
  }

  void _validateMobileNumber(
    ValidateMobileNumber event,
    Emitter<ContactState> emit,
  ) {
    if (event.mobileNumber.isEmpty) {
      _mobileNumberError = "Mobile number cannot be empty";
    } else if (event.mobileNumber.length != 10) {
      _mobileNumberError = "Mobile number must be 10 digits";
    } else {
      _mobileNumberError = null;
    }
    _emitCurrentValidationState(emit);
  }

  void _emitCurrentValidationState(Emitter<ContactState> emit) {
    emit(
      ContactValidationState(
        firstNameError: _firstNameError,
        lastNameError: _lastNameError,
        emailError: _emailError,
        mobileNumberError: _mobileNumberError,
        imageError: _imageError,
        selectedCategory: _selectedCategory,
        imagePath: _imagePath,
      ),
    );
  }

  void _addContact(AddContact event, Emitter<ContactState> emit) {
    // Validate all fields before adding
    bool isValid =
        _firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _mobileNumberError == null;

    if (isValid) {
      _insertContactUseCase.execute(event.contact);
      emit(ContactAdded());
    } else {
      _emitCurrentValidationState(emit);
    }
  }
}
