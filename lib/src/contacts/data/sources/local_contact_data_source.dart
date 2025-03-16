import 'package:contact_x/src/contacts/data/sources/contact_dao.dart';
import 'package:contact_x/src/contacts/data/sources/contact_data_source.dart';
import 'package:contact_x/src/contacts/domain/models/contact.dart';

class LocalContactDataSource implements ContactDataSource {
  final ContactDao _contactDao;

  LocalContactDataSource(ContactDao contactDao) : _contactDao = contactDao;

  @override
  Future<void> addContact({required ContactModel contact}) {
    _contactDao.insertContact(contact);
    return Future.value();
  }

  @override
  Future<List<ContactModel>> getAllContacts() {
    return _contactDao.getContacts();
  }

  @override
  Future<void> deleteContact({required int id}) {
    _contactDao.deleteContact(id);
    return Future.value();
  }

  @override
  Future<void> editContact({required ContactModel contact}) {
    _contactDao.updateContact(contact);
    return Future.value();
  }

  @override
  Future<List<ContactModel>> searchContact({required String searchQuery}) {
    return _contactDao.searchContacts(searchQuery);
  }

  @override
  Future<List<ContactModel>> filterContacts({required int categoryId}) {
    return _contactDao.filterContacts(categoryId);
  }
}
