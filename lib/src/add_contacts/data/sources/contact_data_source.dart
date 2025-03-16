import 'package:contact_x/src/add_contacts/domain/models/contact.dart';

abstract class ContactDataSource {
  Future<void> addContact({required ContactModel contact});
}
