import 'package:contact_x/src/contacts/domain/models/contact.dart';
import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class SearchContactUseCase {
  final ContactRepository repository;

  SearchContactUseCase(this.repository);

  Future<List<ContactModel>> execute(String searchQuery) async {
    return repository.searchContact(searchQuery: searchQuery);
  }
}
