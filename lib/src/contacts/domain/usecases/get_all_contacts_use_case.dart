import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class GetAllContactsUseCase {
  final ContactRepository repository;

  GetAllContactsUseCase(this.repository);

  Future<List<ContactModel>> execute() async {
    return repository.getAllContacts();
  }
}
