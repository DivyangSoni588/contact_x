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
}
