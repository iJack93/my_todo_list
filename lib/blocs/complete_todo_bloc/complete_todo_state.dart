part of 'complete_todo_bloc.dart';

/// Stato base per il bloc del completamento dei Todo.
/// Estende [Equatable] per facilitare il confronto e garantire l'immutabilità degli stati.
abstract class CompleteTodosState extends Equatable {
  const CompleteTodosState();

  @override
  List<Object> get props => [];
}

/// Stato iniziale del bloc per il completamento dei Todo.
class CompleteTodoInitial extends CompleteTodosState { }

/// Stato che indica che l'operazione di completamento del Todo è in corso.
class CompleteTodoLoading extends CompleteTodosState { }

/// Stato che indica che il Todo è stato completato con successo.
class CompleteTodoDone extends CompleteTodosState { }

/// Stato che rappresenta un errore verificatosi durante il completamento del Todo.
/// Contiene un messaggio di errore e, opzionalmente, dei codici di errore.
class TodoError extends CompleteTodosState {
  final String? message;
  final String? errorCode;
  final String? code;

  /// Costruttore che richiede il [message] e opzionalmente [errorCode] e [code].
  const TodoError({
    required this.message,
    this.errorCode,
    this.code,
  });
}
