import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class InsertContactUseCase {
  final ContactRepository repository;

  InsertContactUseCase(this.repository);

  Future<void> execute(ContactModel contact) async {
    repository.addContact(contact: contact);
  }
}
