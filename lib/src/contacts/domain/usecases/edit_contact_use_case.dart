import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class EditContactUseCase {
  final ContactRepository repository;

  EditContactUseCase(this.repository);

  Future<void> execute(ContactModel contact) async {
    repository.editContact(contact: contact);
  }
}
