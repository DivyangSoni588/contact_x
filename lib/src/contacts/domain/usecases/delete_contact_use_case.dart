import 'package:contact_x/src/contacts/domain/repositories/contact_repository.dart';

class DeleteContactUseCase {
  final ContactRepository repository;

  DeleteContactUseCase(this.repository);

  Future<void> execute(int contactId) async {
    repository.deleteContact(id: contactId);
  }
}
