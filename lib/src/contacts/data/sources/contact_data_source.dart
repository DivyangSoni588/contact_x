import 'package:contact_x/src/contacts/domain/models/contact.dart';

abstract class ContactDataSource {
  Future<void> addContact({required ContactModel contact});
  Future<void> editContact({required ContactModel contact});
  Future<List<ContactModel>> getAllContacts();
  Future<void> deleteContact({required int id});
  Future<List<ContactModel>> searchContact({required String searchQuery});

  Future<List<ContactModel>> filterContacts({required int categoryId});
}
