import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class FilterContactsUseCase {
  final ContactRepository repository;

  FilterContactsUseCase(this.repository);

  Future<List<ContactModel>> execute(int categoryId) async {
    return repository.filterContacts(categoryId: categoryId);
  }
}
