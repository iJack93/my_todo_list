import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/todo.dart';
import '../../data/repositories/database_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

/// Bloc per la gestione degli eventi e stati relativi ai Todo
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  // Repository per l'interazione con il database (Firestore)
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  // Subscription per gestire lo stream dei Todo in tempo reale
  StreamSubscription? _todosSubscription;

  /// Costruttore del bloc che inizializza lo stato e registra gli handler per gli eventi
  TodosBloc() : super(TodosInitial()) {
    // Registra l'handler per l'aggiunta di un nuovo Todo
    on<AddTodoEvent>((event, emit) async {
      await _addTodo(event, emit);
    });
    // Registra l'handler per il caricamento dei Todo
    on<LoadTodos>((event, emit) async {
      await _loadTodos(event, emit);
    });
    // Registra l'handler per la sottoscrizione in tempo reale dei Todo
    on<SubscribeToTodos>((event, emit) async {
      await _onSubscribeToTodos(event, emit);
    });
    // Registra l'handler per l'aggiornamento dei Todo quando lo stream in tempo reale riceve dati
    on<TodosUpdated>((event, emitter) async {
      await _onTodosUpdated(event, emitter);
    });
  }

  /// Gestisce l'aggiunta di un nuovo Todo
  Future<void> _addTodo(AddTodoEvent event, Emitter<TodosState> emit) async {
    try {
      // Aggiunge il Todo tramite il repository
      await _databaseRepository.addTodo(event.todo);
      // Emmette uno stato che indica che il Todo è stato aggiunto
      emit(TodoAdded());
      // Richiede il caricamento aggiornato dei Todo per l'utente
      add(LoadTodos(userUid: event.todo.userUid!));
    } on FirebaseException catch (error) {
      // In caso di errore, emette uno stato di errore con messaggio e codice
      emit(TodoError(
        message: error.message,
        code: error.code,
      ));
    }
  }

  /// Carica i Todo dal database per l'utente specificato
  Future<void> _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    // Emmette uno stato di caricamento
    emit(TodosLoading());

    // Esempio per scopi dimostrativi:
    // await Future.delayed(const Duration(seconds: 5));

    try {
      // Recupera la lista dei Todo per l'utente
      List<Todo> todos = await _databaseRepository.getTodos(userUid: event.userUid);
      // Ordina i Todo in base alla data di creazione in ordine decrescente
      todos.sort((a, b) => int.parse(b.createdAt!).compareTo(int.parse(a.createdAt!)));
      // Emmette lo stato con i Todo caricati
      emit(TodosLoaded(todos: todos));
    } on FirebaseException catch (error) {
      // In caso di errore, emette uno stato di errore con messaggio e codice
      emit(TodoError(
        message: error.message,
        code: error.code,
      ));
    }
  }

  /// Gestisce la sottoscrizione in tempo reale dei Todo per un utente
  Future<void> _onSubscribeToTodos(SubscribeToTodos event, Emitter<TodosState> emit) async {
    // Annulla eventuali sottoscrizioni esistenti prima di iniziarne una nuova
    _todosSubscription?.cancel();

    // Emmette uno stato di caricamento durante l'attesa dei dati
    emit(TodosLoading());

    // Inizia lo stream dei Todo e ascolta i cambiamenti
    _todosSubscription = _databaseRepository
        .streamTodos(userUid: event.userUid)
        .listen((snapshot) {
      // Estrae i Todo dallo snapshot ricevuto
      final todos = _databaseRepository.fetchTodos(snapshot);
      // Aggiunge un evento per aggiornare lo stato dei Todo con i nuovi dati
      add(TodosUpdated(todos: todos));
    });
  }

  /// Gestisce l'aggiornamento dei Todo quando si riceve un nuovo evento dallo stream
  Future<void> _onTodosUpdated(TodosUpdated event, Emitter<TodosState> emit) async {
    // Crea una copia della lista dei Todo per evitare modifiche dirette
    final todos = cloneToDosList(event.todos);
    // Ordina i Todo per data di creazione in ordine decrescente
    todos.sort((a, b) => int.parse(b.createdAt!).compareTo(int.parse(a.createdAt!)));
    // Emmette lo stato con i Todo aggiornati
    emit(TodosLoaded(todos: todos));
  }

  /// Crea una copia della lista di Todo per mantenere l'immutabilità
  List<Todo> cloneToDosList(List<Todo> todosList) {
    return todosList.map((todo) => Todo(
      id: todo.id,
      userUid: todo.userUid,
      content: todo.content,
      done: todo.done,
      createdAt: todo.createdAt,
      updatedAt: todo.updatedAt,
    )).toList();
  }

  /// Override del metodo close per cancellare la sottoscrizione in tempo reale
  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
