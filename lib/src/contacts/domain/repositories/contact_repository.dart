import 'package:contact_x/src/contacts/domain/models/contact.dart';

abstract class ContactRepository {
  Future<void> addContact({required ContactModel contact});
}
