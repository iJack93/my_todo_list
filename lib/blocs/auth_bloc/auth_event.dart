part of 'auth_bloc.dart';

/// Evento base per l'autenticazione.
/// Utilizza una sealed class per garantire che tutte le possibili sottoclassi siano conosciute e controllate.
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Evento che indica l'inizio del processo di autenticazione.
/// Può essere utilizzato per attivare logiche iniziali o per preparare lo stato dell'autenticazione.
class AuthStarted extends AuthEvent {}

/// Evento che avvia il processo di login tramite Google.
/// Quando questo evento viene emesso, il bloc di autenticazione gestisce l'accesso con Google.
class AuthGoogleLogin extends AuthEvent {}
