part of 'todos_bloc.dart';

/// Stato base per il bloc dei Todo.
/// Estende [Equatable] per facilitare il confronto tra gli stati.
abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

/// Stato iniziale del bloc dei Todo.
class TodosInitial extends TodosState { }

/// Stato che indica che i Todo sono in fase di caricamento.
class TodosLoading extends TodosState { }

/// Stato che rappresenta il caricamento avvenuto con successo dei Todo.
/// Contiene una lista di [Todo].
class TodosLoaded extends TodosState {
  final List<Todo> todos;

  /// Costruttore che richiede la lista dei Todo caricati.
  const TodosLoaded({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];
}

/// Stato che indica che un nuovo Todo è stato aggiunto con successo.
class TodoAdded extends TodosState { }

/// Stato che rappresenta un errore verificatosi durante le operazioni sui Todo.
/// Contiene un messaggio di errore e opzionalmente dei codici di errore.
class TodoError extends TodosState {
  final String? message;
  final String? errorCode;
  final String? code;

  /// Costruttore che richiede un [message] e opzionalmente [errorCode] e [code].
  const TodoError({
    required this.message,
    this.errorCode,
    this.code,
  });
}
