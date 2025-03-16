import 'package:contact_x/src/contacts/domain/usecases/delete_contact_use_case.dart';
import 'package:contact_x/src/contacts/domain/usecases/edit_contact_use_case.dart';
import 'package:contact_x/src/contacts/domain/usecases/get_all_contacts_use_case.dart';
import 'package:contact_x/src/contacts/domain/usecases/search_contact_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'contacts_event.dart';
import 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetAllContactsUseCase _getAllContactsUseCase =
      GetIt.instance.get<GetAllContactsUseCase>();
  final DeleteContactUseCase _deleteContactUseCase =
      GetIt.instance.get<DeleteContactUseCase>();
  final EditContactUseCase _editContactUseCase =
      GetIt.instance.get<EditContactUseCase>();
  final SearchContactUseCase _searchContactUseCase =
      GetIt.instance.get<SearchContactUseCase>();

  ContactsBloc() : super(ContactsInitial()) {
    on<GetAllContactsEvent>(_onGetAllContacts);
    on<EditContactEvent>(_onEditContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<SearchContactEvent>(_onSearchContact);
    // on<FilterContactsByCategoryEvent>(_onFilterContactsByCategory);
    // on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onGetAllContacts(
    GetAllContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await _getAllContactsUseCase.execute();
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError('Failed to load contacts: ${e.toString()}'));
    }
  }

  Future<void> _onEditContact(
    EditContactEvent event,
    Emitter<ContactsState> emit,
  ) async {
    if (state is ContactsLoaded) {
      emit(ContactsLoading());
      try {
        await _editContactUseCase.execute(event.contact);
        final updatedContacts = await _getAllContactsUseCase.execute();

        emit(ContactsLoaded(contacts: updatedContacts));
      } catch (e) {
        emit(ContactsError('Failed to edit contact: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteContact(
    DeleteContactEvent event,
    Emitter<ContactsState> emit,
  ) async {
    if (state is ContactsLoaded) {
      try {
        await _deleteContactUseCase.execute(event.id);

        // Get the current state
        if (state is ContactsLoaded) {
          final currentState = state as ContactsLoaded;

          // Create a new list without the deleted contact
          final updatedContacts =
              currentState.contacts.where((c) => c.id != event.id).toList();

          // Emit the new state with updated contacts and applied filters
          emit(ContactsLoaded(contacts: updatedContacts));
        }
      } catch (e) {
        emit(ContactsError('Failed to delete contact: ${e.toString()}'));
      }
    }
  }

  void _onSearchContact(
    SearchContactEvent event,
    Emitter<ContactsState> emit,
  ) async {
    if (state is ContactsLoaded) {
      emit(ContactsLoading());
      try {
        final contacts = await _searchContactUseCase.execute(event.query);

        emit(ContactsLoaded(contacts: contacts));
      } catch (e) {
        emit(ContactsError('Failed to edit contact: ${e.toString()}'));
      }
    }
  }

  //
  // void _onFilterContactsByCategory(FilterContactsByCategoryEvent event, Emitter<ContactsState> emit) {
  //   if (state is ContactsLoaded) {
  //     final currentState = state as ContactsLoaded;
  //
  //     List<Contact> filteredContacts = _applyFilters(
  //       currentState.contacts,
  //       currentState.searchQuery,
  //       event.category,
  //     );
  //
  //     emit(currentState.copyWith(filteredContacts: filteredContacts, activeCategory: event.category));
  //   }
  // }
  //
  // void _onClearFilters(ClearFiltersEvent event, Emitter<ContactsState> emit) {
  //   if (state is ContactsLoaded) {
  //     final currentState = state as ContactsLoaded;
  //     emit(
  //       currentState.copyWith(
  //         filteredContacts: currentState.contacts,
  //         searchQuery: null,
  //         activeCategory: null,
  //       ),
  //     );
  //   }
  // }
  //
}
