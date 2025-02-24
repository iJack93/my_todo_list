import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/views/splash/splash_page.dart';
import 'package:my_todo_list/views/styles/styles.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/complete_todo_bloc/complete_todo_bloc.dart';
import 'blocs/todos_bloc/todos_bloc.dart';
import 'firebase_options.dart';

// Funzione principale che inizializza Firebase e avvia l'applicazione
Future<void> main() async {
  // Assicura che i binding di Flutter siano inizializzati
  WidgetsFlutterBinding.ensureInitialized();
  // Inizializza Firebase utilizzando le opzioni predefinite per la piattaforma corrente
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Avvia l'applicazione MyApp
  runApp(const MyApp());
}

/// Widget principale dell'applicazione
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Fornisce i vari Bloc necessari per la gestione dello stato dell'applicazione
      providers: [
        // Bloc per gestire l'autenticazione dell'utente
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        // Bloc per gestire la lista dei Todo
        BlocProvider<TodosBloc>(
          create: (context) => TodosBloc(),
        ),
        // Bloc per gestire il completamento dei Todo
        BlocProvider<CompleteTodoBloc>(
          create: (context) => CompleteTodoBloc(),
        ),
      ],
      child: MaterialApp(
        // Titolo dell'applicazione
        title: 'TO-DO List',
        // Rimuove il banner di debug in alto a destra
        debugShowCheckedModeBanner: false,
        // Imposta il tema principale dell'applicazione
        theme: Styles.mainThemeData(),
        // Imposta la SplashPage come pagina iniziale
        home: SplashPage(),
      ),
    );
  }
}
