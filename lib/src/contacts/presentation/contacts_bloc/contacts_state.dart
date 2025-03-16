import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactModel> contacts;

  const ContactsLoaded({required this.contacts});

  @override
  List<Object?> get props => [contacts];

  ContactsLoaded copyWith({
    List<ContactModel>? contacts,
    List<ContactModel>? filteredContacts,
    String? searchQuery,
    int? activeCategory,
  }) {
    return ContactsLoaded(contacts: contacts ?? this.contacts);
  }
}

class ContactsError extends ContactsState {
  final String message;

  const ContactsError(this.message);

  @override
  List<Object?> get props => [message];
}
