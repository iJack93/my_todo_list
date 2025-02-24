import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/todo.dart';
import '../../data/repositories/database_repository.dart';

part 'complete_todo_event.dart';
part 'complete_todo_state.dart';

/// Bloc responsabile per il completamento di un Todo.
/// Si occupa di aggiornare il Todo nel database e di emettere gli stati relativi all'operazione.
class CompleteTodoBloc extends Bloc<CompleteTodoEvent, CompleteTodosState> {
  // Istanza del DatabaseRepository per interagire con il database.
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  /// Costruttore del bloc che inizializza lo stato a [CompleteTodoInitial]
  /// e registra l'handler per l'evento [CompleteTodoEvent].
  CompleteTodoBloc() : super(CompleteTodoInitial()) {
    on<CompleteTodoEvent>((event, emit) async {
      await _updateTodo(event, emit);
    });
  }

  /// Metodo privato che gestisce l'aggiornamento di un Todo.
  /// Se l'operazione ha successo, emette [CompleteTodoDone].
  /// In caso di errore (FirebaseException), emette uno stato [TodoError] con dettagli sull'errore.
  Future<void> _updateTodo(CompleteTodoEvent event, Emitter<CompleteTodosState> emit) async {
    try {
      // Aggiorna il Todo nel database utilizzando il repository
      await _databaseRepository.updateTodo(event.todo);
      // Emmette lo stato di completamento riuscito del Todo
      emit(CompleteTodoDone());
    } on FirebaseException catch (error) {
      // In caso di errore, emette uno stato di errore con il messaggio e il codice dell'errore
      emit(TodoError(
        message: error.message,
        code: error.code,
      ));
    }
  }
}
