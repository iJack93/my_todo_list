import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../interfaces/auth_interface.dart';

/// Servizio di autenticazione che implementa [AuthInterface]
/// Utilizza FirebaseAuth e GoogleSignIn per gestire l'accesso con Google
class AuthService implements AuthInterface {
  // Costruttore privato per implementare il pattern singleton
  AuthService._();

  // Istanza singleton condivisa di AuthService
  static final AuthService shared = AuthService._();

  // Factory constructor che restituisce sempre l'istanza singleton
  factory AuthService() {
    return shared;
  }

  /// Istanza di FirebaseAuth per gestire l'autenticazione
  final _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  /// Ritorna l'utente attualmente autenticato, se presente
  User? get user => _auth.currentUser;

  /// Verifica se un utente è attualmente loggato
  bool get isUserLoggedIn => user != null;

  /// Metodo per eseguire l'autenticazione con Google
  /// Ritorna true se l'accesso ha avuto successo, false altrimenti
  @override
  Future<bool> signInWithGoogle() async {
    bool result = false;
    try {
      // Avvia il flusso di autenticazione con Google, richiedendo i permessi per profilo ed email
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ["profile", "email"]).signIn();

      // Ottiene i dettagli di autenticazione (access token e id token) dalla risposta di Google
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Crea una nuova credenziale utilizzando i token ottenuti
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Esegue il login su Firebase utilizzando le credenziali create
      final userCredentials = await FirebaseAuth.instance.signInWithCredential(credential);

      // Se l'utente autenticato non è nullo, l'accesso è andato a buon fine
      if (userCredentials.user != null) {
        result = true;
      }
    } on FirebaseAuthException catch (error) {
      // Gestisce le eccezioni specifiche di FirebaseAuth
      print(error);
      result = false;
    } catch (error) {
      // Gestisce eventuali altre eccezioni
      print(error);
      result = false;
    }
    // Ritorna il risultato dell'operazione di autenticazione
    return result;
  }
}
