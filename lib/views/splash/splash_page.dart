import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/auth_repository.dart';
import '../home/home.dart';
import '../login/login.dart';

/// Pagina di Splash che mostra il logo e gestisce la logica di avvio dell'app
class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  _SplashPageState createState() => _SplashPageState();
}

/// Stato della SplashPage, che utilizza il mixin [TickerProviderStateMixin] per eventuali animazioni
class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    // Dopo il primo frame, esegue la logica di avvio (startup logic)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await handleStartUpLogic(context);
    });
  }

  /// Gestisce la logica di avvio:
  /// - Nasconde la tastiera (se aperta)
  /// - Attende 1 secondo
  /// - Verifica se l'utente è autenticato e reindirizza alla Home o alla Login
  Future handleStartUpLogic(BuildContext context) async {
    // Rimuove il focus attivo per nascondere la tastiera
    FocusManager.instance.primaryFocus?.unfocus();
    // Nasconde la tastiera attraverso il canale dei metodi di sistema
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    // Attende 1 secondo prima di procedere
    Future.delayed(const Duration(seconds: 1), () {
      // Se l'utente è autenticato, naviga alla Home
      if (AuthRepository().isAuthenticated()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          )
        );
      } else {
        // Altrimenti, naviga alla pagina di Login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Login(),
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Imposta lo stile della barra di stato: icone scure e sfondo bianco
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      )
    );
    // Stampa di debug per segnalare l'inizializzazione della splash screen
    debugPrint("Splash screen initialized");
    // Ritorna lo scaffold semplice definito nel metodo [returnSimpleScaffold]
    return returnSimpleScaffold(context);
  }

  /// Costruisce e ritorna uno Scaffold semplice per la splash screen
  Widget returnSimpleScaffold(BuildContext context) {
    return Scaffold(
      // Evita il ridimensionamento del layout quando viene visualizzata la tastiera
      resizeToAvoidBottomInset: false,
      // Estende il body oltre l'AppBar, se presente
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // Utilizza uno Stack per posizionare l'immagine al centro dello schermo
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                // Arrotonda gli angoli del container
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              // Visualizza l'immagine del logo al centro del container
              child: Center(
                  child: Image.asset("assets/gdg-vicenza-logo.png")
              ),
            ),
          ),
        ],
      ),
    );
  }
}
