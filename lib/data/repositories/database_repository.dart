import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo.dart';
import '../services/database_service.dart';

/// Repository che funge da intermediario tra il servizio di database e l'applicazione,
/// gestendo operazioni sui Todo.
class DatabaseRepository {
  // Costruttore privato per implementare il pattern singleton
  DatabaseRepository._();

  // Istanza singleton condivisa di DatabaseRepository
  static final DatabaseRepository shared = DatabaseRepository._();

  // Factory constructor che restituisce sempre l'istanza singleton
  factory DatabaseRepository() {
    return shared;
  }

  // Istanza del DatabaseService che interagisce direttamente con Firestore
  final DatabaseService _databaseService = DatabaseService();

  /// Recupera la lista dei Todo per un determinato utente identificato da [userUid].
  /// Effettua una chiamata al DatabaseService e trasforma i dati grezzi in oggetti [Todo].
  Future<List<Todo>> getTodos({required String userUid}) async {
    List<Todo> results = [];
    // Recupera i dati grezzi dei Todo da Firestore tramite il DatabaseService
    final rawData = await _databaseService.getTodos(userUid: userUid);
    // Converte i dati grezzi in una lista di oggetti Todo
    results = fetchTodos(rawData);
    return results;
  }

  /// Converte i dati grezzi ottenuti da Firestore (QuerySnapshot) in una lista di oggetti [Todo].
  List<Todo> fetchTodos(QuerySnapshot<Object?> rawData) {
    List<Todo> results = [];
    // Itera su ciascun documento contenuto nello snapshot
    for (var doc in rawData.docs) {
      // Converte il documento in un oggetto Todo utilizzando il metodo fromJson
      Todo todo = Todo.fromJson(doc.data());
      results.add(todo);
    }
    return results;
  }

  /// Ritorna uno stream continuo di dati (QuerySnapshot) per i Todo dell'utente identificato da [userUid].
  Stream<QuerySnapshot<Object?>> streamTodos({required String userUid}) {
    return _databaseService.streamTodos(userUid: userUid);
  }

  /// Aggiunge un nuovo [todo] al database.
  Future<void> addTodo(Todo todo) {
    return _databaseService.addTodo(todo);
  }

  /// Aggiorna un [todo] esistente nel database.
  Future<void> updateTodo(Todo todo) {
    return _databaseService.updateTodo(todo);
  }
}
