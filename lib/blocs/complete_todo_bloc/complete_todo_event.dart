part of 'complete_todo_bloc.dart';

/// Evento base per l'aggiornamento di un Todo.
/// Estende [Equatable] per facilitare il confronto tra eventi.
abstract class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();

  @override
  List<Object?> get props => [];
}

/// Evento specifico per il completamento di un Todo.
/// Contiene il [Todo] da aggiornare e viene gestito dal [CompleteTodoBloc].
class CompleteTodoEvent extends UpdateTodoEvent {
  /// Il Todo da aggiornare.
  final Todo todo;

  /// Costruttore che richiede il [todo] da aggiornare.
  const CompleteTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}
