import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllContactsEvent extends ContactsEvent {}

class EditContactEvent extends ContactsEvent {
  final ContactModel contact;

  const EditContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class DeleteContactEvent extends ContactsEvent {
  final int id;

  const DeleteContactEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchContactEvent extends ContactsEvent {
  final String query;

  const SearchContactEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterContactsByCategoryEvent extends ContactsEvent {
  final String category;

  const FilterContactsByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class ClearFiltersEvent extends ContactsEvent {}
