part of 'todos_bloc.dart';

/// Evento base per il bloc dei Todo.
/// Estende [Equatable] per facilitare il confronto tra eventi.
abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

/// Evento per l'aggiunta di un nuovo Todo.
/// Contiene il [Todo] da aggiungere.
class AddTodoEvent extends TodosEvent {
  final Todo todo;

  /// Costruttore che richiede il [todo] da aggiungere.
  const AddTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

/// Evento per il caricamento dei Todo di un utente specifico.
/// Contiene il [userUid] dell'utente.
class LoadTodos extends TodosEvent {
  final String userUid;

  /// Costruttore che richiede il [userUid] per caricare i Todo.
  const LoadTodos({
    required this.userUid,
  });

  @override
  List<Object?> get props => [userUid];
}

/// Evento per sottoscrivere in tempo reale i cambiamenti dei Todo.
/// Contiene il [userUid] dell'utente per il quale sottoscriversi.
class SubscribeToTodos extends TodosEvent {
  final String userUid;

  /// Costruttore che richiede il [userUid] per iniziare la sottoscrizione.
  const SubscribeToTodos({
    required this.userUid,
  });

  @override
  List<Object?> get props => [userUid];
}

/// Evento per aggiornare lo stato dei Todo quando si ricevono nuovi dati.
/// Contiene la lista aggiornata dei [Todo].
class TodosUpdated extends TodosEvent {
  final List<Todo> todos;

  /// Costruttore che richiede la lista dei [todos] aggiornati.
  const TodosUpdated({
    required this.todos,
  });

  @override
  List<Object?> get props => [todos];
}
