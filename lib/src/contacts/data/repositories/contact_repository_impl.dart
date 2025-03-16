import 'package:contact_x/src/contacts/data/sources/contact_data_source.dart';
import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource _contactDataSource;

  ContactRepositoryImpl(ContactDataSource contactDataSource)
    : _contactDataSource = contactDataSource;

  @override
  Future<void> addContact({required ContactModel contact}) {
    _contactDataSource.addContact(contact: contact);
    return Future.value();
  }

  @override
  Future<List<ContactModel>> getAllContacts() {
    return _contactDataSource.getAllContacts();
  }

  @override
  Future<void> deleteContact({required int id}) {
    _contactDataSource.deleteContact(id: id);
    return Future.value();
  }

  @override
  Future<void> editContact({required ContactModel contact}) {
    _contactDataSource.editContact(contact: contact);
    return Future.value();
  }

  @override
  Future<List<ContactModel>> searchContact({required String searchQuery}) {
    return _contactDataSource.searchContact(searchQuery: searchQuery);
  }

  @override
  Future<List<ContactModel>> filterContacts({required int categoryId}) {
    return _contactDataSource.filterContacts(categoryId: categoryId);
  }
}
