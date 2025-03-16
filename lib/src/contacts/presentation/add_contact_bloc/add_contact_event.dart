import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:equatable/equatable.dart';

abstract class AddContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidateFirstName extends AddContactEvent {
  final String firstName;
  ValidateFirstName(this.firstName);
  @override
  List<Object?> get props => [firstName];
}

class ValidateLastName extends AddContactEvent {
  final String lastName;
  ValidateLastName(this.lastName);
  @override
  List<Object?> get props => [lastName];
}

class ValidateEmail extends AddContactEvent {
  final String email;
  ValidateEmail(this.email);
  @override
  List<Object?> get props => [email];
}

class ValidateMobileNumber extends AddContactEvent {
  final String mobileNumber;
  ValidateMobileNumber(this.mobileNumber);
  @override
  List<Object?> get props => [mobileNumber];
}

class AddContact extends AddContactEvent {
  final ContactModel contact;

  AddContact({required this.contact});

  @override
  List<Object?> get props => [contact];
}

class SelectCategory extends AddContactEvent {
  final dynamic category;

  SelectCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SetContactImage extends AddContactEvent {
  final String imagePath;

  SetContactImage(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
