import 'package:cloud_firestore/cloud_firestore.dart';

import '../interfaces/database_service_interface.dart';
import '../models/todo.dart';

/// Implementazione del servizio database che interagisce con Firestore
/// e implementa l'interfaccia [IDatabaseServiceInterface]
class DatabaseService implements IDatabaseServiceInterface {
  // Costruttore privato per implementare il pattern singleton
  DatabaseService._();

  // Istanza singleton condivisa di DatabaseService
  static final DatabaseService shared = DatabaseService._();

  // Factory constructor che restituisce sempre l'istanza singleton
  factory DatabaseService() {
    return shared;
  }

  // Riferimento alla collezione "todos" su Firestore
  final CollectionReference _todos = FirebaseFirestore.instance.collection("todos");

  // Getter per accedere alla collezione "todos"
  CollectionReference get todos => _todos;

  // Istanza di Timestamp ottenuta al momento dell'inizializzazione
  final Timestamp _timestamp = Timestamp.now();

  // Getter per accedere al timestamp
  Timestamp get timestamp => _timestamp;

  /// Recupera i Todo per un determinato utente basandosi sul suo [userUid]
  @override
  Future<QuerySnapshot<Object?>> getTodos({required String userUid}) {
    // Esegue una query su Firestore filtrando per "userUid" e ritorna i documenti trovati
    return _todos.where("userUid", isEqualTo: userUid).get();
  }

  /// Fornisce uno stream continuo dei Todo per un determinato utente
  @override
  Stream<QuerySnapshot<Object?>> streamTodos({required String userUid}) {
    // Ritorna uno stream di query snapshot filtrato per "userUid"
    return _todos.where("userUid", isEqualTo: userUid).snapshots();
  }

  /// Aggiunge un nuovo Todo a Firestore
  @override
  Future<void> addTodo(Todo todo) async {
    // Crea un nuovo documento con l'ID del Todo e imposta i dati convertiti in JSON
    _todos.doc(todo.id).set(todo.toJson());
  }

  /// Aggiorna un Todo esistente su Firestore
  @override
  Future<void> updateTodo(Todo todo) async {
    // Aggiorna il documento corrispondente all'ID del Todo con i nuovi dati in JSON
    _todos.doc(todo.id).update(todo.toJson());
  }
}
