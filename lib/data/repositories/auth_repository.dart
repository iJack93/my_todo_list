import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_todo_list/data/services/auth_service.dart';

/// Repository per l'autenticazione che funge da intermediario tra il servizio di autenticazione e l'applicazione.
class AuthRepository {
  // Costruttore privato per implementare il pattern singleton
  AuthRepository._();

  // Istanza singleton condivisa di AuthRepository
  static final AuthRepository shared = AuthRepository._();

  // Factory constructor che restituisce sempre l'istanza singleton
  factory AuthRepository() {
    return shared;
  }

  // Istanza di AuthService che gestisce le operazioni di autenticazione
  final AuthService _authService = AuthService();

  /// Ritorna l'utente attualmente autenticato, se presente
  User? get authUser => _authService.user;

  /// Verifica se un utente è attualmente autenticato
  bool isAuthenticated() {
    return _authService.isUserLoggedIn;
  }

  /// Avvia il processo di autenticazione tramite Google.
  /// Ritorna true se l'accesso ha successo, false altrimenti.
  Future<bool> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }
}
