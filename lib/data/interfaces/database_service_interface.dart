import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

/// Interfaccia che definisce le operazioni essenziali per interagire con il database.
/// In particolare, queste operazioni riguardano la gestione dei Todo in Firestore.
abstract class IDatabaseServiceInterface {
  /// Recupera i Todo dall'archivio per l'utente specificato tramite [userUid].
  /// Ritorna un [Future] che contiene un [QuerySnapshot] con i documenti trovati.
  Future<QuerySnapshot<Object?>> getTodos({required String userUid});

  /// Fornisce uno stream in tempo reale dei Todo per l'utente specificato tramite [userUid].
  /// Questo stream consente di ricevere aggiornamenti immediati quando i dati cambiano.
  Stream<QuerySnapshot<Object?>> streamTodos({required String userUid});

  /// Aggiunge un nuovo [Todo] al database.
  Future<void> addTodo(Todo todo);

  /// Aggiorna un [Todo] esistente nel database.
  Future<void> updateTodo(Todo todo);
}
