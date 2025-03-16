import 'package:contact_x/src/add_contacts/domain/models/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidateFirstName extends ContactEvent {
  final String firstName;
  ValidateFirstName(this.firstName);
  @override
  List<Object?> get props => [firstName];
}

class ValidateLastName extends ContactEvent {
  final String lastName;
  ValidateLastName(this.lastName);
  @override
  List<Object?> get props => [lastName];
}

class ValidateEmail extends ContactEvent {
  final String email;
  ValidateEmail(this.email);
  @override
  List<Object?> get props => [email];
}

class ValidateMobileNumber extends ContactEvent {
  final String mobileNumber;
  ValidateMobileNumber(this.mobileNumber);
  @override
  List<Object?> get props => [mobileNumber];
}

class AddContact extends ContactEvent {
  final ContactModel contact;

  AddContact({required this.contact});

  @override
  List<Object?> get props => [contact];
}

class SelectCategory extends ContactEvent {
  final dynamic category;

  SelectCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SetContactImage extends ContactEvent {
  final String imagePath;

  SetContactImage(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
