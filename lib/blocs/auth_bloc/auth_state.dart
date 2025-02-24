part of 'auth_bloc.dart';

/// Stato base per l'autenticazione.
/// Definito come sealed class per limitare l'ereditarietà a questo file e garantire
/// che tutte le possibili sottoclassi siano note e controllate.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Stato iniziale dell'autenticazione.
/// Indica che il processo di autenticazione non è ancora iniziato.
class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object> get props => [];
}

/// Stato che indica l'inizio del processo di autenticazione.
/// Può essere usato per attivare eventuali animazioni o logiche iniziali.
class AuthStateStarted extends AuthState {
  const AuthStateStarted();

  @override
  List<Object> get props => [];
}

/// Stato che indica che il processo di autenticazione è in corso.
/// Durante questo stato, si potrebbe mostrare un indicatore di caricamento.
class AuthStateLoading extends AuthState {
  const AuthStateLoading();

  @override
  List<Object> get props => [];
}

/// Stato che indica il successo dell'autenticazione.
/// Significa che l'utente ha effettuato l'accesso correttamente.
class AuthStateSuccess extends AuthState {
  const AuthStateSuccess();

  @override
  List<Object> get props => [];
}

/// Stato che indica che l'utente si è disconnesso.
/// Può essere usato per reindirizzare l'utente alla schermata di login.
class AuthStateSignedOut extends AuthState {
  const AuthStateSignedOut();

  @override
  List<Object> get props => [];
}

/// Stato che rappresenta un errore durante il processo di autenticazione.
/// Contiene un messaggio di errore, ed opzionalmente un codice di errore e uno status code.
class AuthStateError extends AuthState {
  final String message;
  final String? errorCode;
  final int? statusCode;

  /// Costruttore che richiede un [message] e opzionalmente [errorCode] e [statusCode].
  const AuthStateError({
    required this.message,
    this.errorCode,
    this.statusCode,
  });

  @override
  List<Object> get props => [message];
}
