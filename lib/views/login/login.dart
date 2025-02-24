import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_todo_list/views/utilities/utils.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../home/home.dart';

/// Widget per la pagina di login che permette l'autenticazione tramite Google
class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

/// Stato associato al widget Login
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar personalizzata con sfondo trasparente e senza ombra
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // Elimina il bottone di "back" o altre icone predefinite
        leading: Container(),
        // Imposta lo stile dell'overlay della barra di stato per Android e iOS
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Per Android: sfondo trasparente
          statusBarIconBrightness: Brightness.dark, // Per Android: icone scure (se lo sfondo è chiaro)
          statusBarBrightness: Brightness.light, // Per iOS: icone chiare
        ),
      ),
      // Corpo della pagina centrato
      body: Center(
        child: Container(
          // Margine intorno al contenuto per evitare bordi troppo vicini allo schermo
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Spacer per distribuire lo spazio verticalmente
              Spacer(),
              // Container che visualizza il logo dell'app
              Container(
                child: Image.asset(
                  "assets/gdg-vicenza-logo.png", height: 110,
                ),
              ),
              Spacer(),
              // Container per il messaggio istruttivo
              Container(
                margin: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  "Premi il pulsante sottostante per continuare.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge,
                ),
              ),
              // BlocConsumer per gestire lo stato dell'autenticazione
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  // Se l'autenticazione ha avuto successo, naviga verso la Home Page
                  if (state is AuthStateSuccess) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Home())
                    );
                  }
                },
                builder: (context, state) {
                  // Mostra un indicatore di caricamento se lo stato è in attesa
                  return state is AuthStateLoading
                      ? CircularProgressIndicator.adaptive()
                      : ElevatedButton(
                    // Stile personalizzato per il pulsante
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey[500]!),
                      ),
                    ),
                    // Al click, invia l'evento per l'autenticazione con Google
                    onPressed: () async {
                      context.read<AuthBloc>().add(AuthGoogleLogin());
                    },
                    // Contenuto del pulsante: logo Google e testo esplicativo
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo di Google in formato SVG
                        SvgPicture.asset("assets/google_logo.svg", height: 24,),
                        // Spazio tra il logo e il testo
                        SizedBox(width: 8,),
                        // Testo del pulsante
                        Text(
                          "Accedi con Google",
                          style: context.textTheme.bodyLarge!,
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Spacer finale per bilanciare il layout verticale
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
