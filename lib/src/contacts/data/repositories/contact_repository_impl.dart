import 'package:contact_x/src/contacts/data/sources/contact_data_source.dart';
import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource _contactDataSource;

  ContactRepositoryImpl(ContactDataSource contactDataSource) : _contactDataSource = contactDataSource;

  @override
  Future<void> addContact({required ContactModel contact}) {
    _contactDataSource.addContact(contact: contact);
    return Future.value();
  }
}
