import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_todo_list/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc responsabile per gestire gli eventi e gli stati relativi all'autenticazione.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Istanza del repository di autenticazione per gestire l'accesso e la verifica dello stato dell'utente.
  final AuthRepository _authRepository = AuthRepository();

  /// Costruttore del bloc.
  /// Imposta lo stato iniziale a [AuthStateInitial] e registra gli handler per gli eventi.
  AuthBloc() : super(AuthStateInitial()) {
    // Gestisce l'evento [AuthStarted] per verificare se l'utente è già autenticato.
    on<AuthStarted>((event, emit) async {
      await _checkIfUserIsLoggedIn(event, emit);
    });
    // Gestisce l'evento [AuthGoogleLogin] per avviare il processo di login tramite Google.
    on<AuthGoogleLogin>((event, emit) async {
      await _authGoogleLogin(event, emit);
    });
  }

  /// Metodo per verificare se l'utente è già autenticato.
  /// Se l'utente è autenticato, emette [AuthStateSuccess],
  /// altrimenti rimane in [AuthStateInitial].
  Future<void> _checkIfUserIsLoggedIn(
      AuthStarted event,
      Emitter<AuthState> emit,
      ) async {
    try {
      // Se l'utente è autenticato, emette uno stato di successo.
      if (_authRepository.isAuthenticated()) {
        emit(const AuthStateSuccess());
      } else {
        // Altrimenti, rimane nello stato iniziale.
        emit(const AuthStateInitial());
      }
    } catch (error) {
      // In caso di eccezione, emette uno stato di errore con il messaggio e uno status code.
      emit(AuthStateError(message: error.toString(), statusCode: 401));
    }
  }

  /// Metodo per gestire l'autenticazione tramite Google.
  /// Prova a eseguire il login con Google e, in caso di successo, emette [AuthStateSuccess].
  /// In caso di errore, emette [AuthStateError].
  Future<void> _authGoogleLogin(
      AuthGoogleLogin event,
      Emitter<AuthState> emit,
      ) async {
    try {
      // Avvia il processo di autenticazione con Google.
      await _authRepository.signInWithGoogle();
      // Se il login ha successo, emette lo stato di successo.
      emit(const AuthStateSuccess());
    } catch (error) {
      // In caso di errore, emette uno stato di errore con il messaggio e uno status code.
      emit(AuthStateError(message: error.toString(), statusCode: 401));
    }
  }
}
