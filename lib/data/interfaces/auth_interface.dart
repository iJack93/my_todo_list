/// Interfaccia che definisce il contratto per l'autenticazione.
/// In particolare, dichiara il metodo per l'accesso tramite Google.
abstract class AuthInterface {
  /// Avvia il processo di autenticazione tramite Google.
  /// Ritorna un [Future<bool>] che indica se l'autenticazione ha avuto successo (true) o meno (false).
  Future<bool> signInWithGoogle();
}