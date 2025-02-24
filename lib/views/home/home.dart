import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/todo.dart';

import '../../blocs/todos_bloc/todos_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../add_todo/add_todo_page.dart';
import 'cells/todo_cell.dart';

/// Widget principale della Home Page, statoful per gestire i cambiamenti dinamici
class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

/// Stato associato al widget Home
class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    // Dopo il primo frame, esegui il callback per caricare i Todo
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Ottieni l'UID dell'utente autenticato
      final userUid = AuthRepository().authUser!.uid;
      // Invia l'evento al bloc per caricare i todo dell'utente
      context.read<TodosBloc>().add(LoadTodos(userUid: userUid));
      context.read<TodosBloc>().add(SubscribeToTodos(userUid: userUid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Quando si tocca fuori da un campo di testo, la tastiera viene nascosta
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChannels.textInput.invokeMethod("TextInput.hide");
      },
      child: Scaffold(
        // AppBar della pagina
        appBar: AppBar(
          backgroundColor: Colors.green,
          // Imposta lo stile dell'overlay della barra di stato per Android e iOS
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            statusBarIconBrightness: Brightness.light, //<-- Per Android (icone chiare)
            statusBarBrightness: Brightness.light, //<-- Per iOS (icone scure)
          ),
          // Titolo dell'AppBar
          title: Text(
            "My Todo List",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700
            ),
          ),
          // Icona per il refresh della lista dei Todo
          actions: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              onPressed: () {
                // Invia un nuovo evento per ricaricare i Todo
                context.read<TodosBloc>().add(LoadTodos(userUid: AuthRepository().authUser!.uid));
              },
              icon: const Icon(Icons.refresh, color: Colors.white, size: 30,),
            )
          ],
        ),
        // Corpo della pagina gestito tramite BlocConsumer per reagire agli stati del TodosBloc
        body: BlocConsumer<TodosBloc, TodosState>(
          listener: (context, state) {
            // Se un nuovo Todo è stato aggiunto, mostra uno SnackBar di conferma
            if (state is TodoAdded) {
              _showSnackbar(context);
            }
          },
          builder: (context, state) {
            // Stato iniziale o in caricamento: mostra un indicatore di progresso
            if (state is TodosInitial || state is TodosLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            // Stato in cui i Todo sono stati caricati
            else if (state is TodosLoaded) {
              // Ottieni la lista dei Todo dallo stato
              List<Todo> todos = state.todos;
              // Se ci sono Todo, costruisci una ListView
              if(todos.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    Todo todo = todos[index];
                    // Verifica di sicurezza sull'indice (anche se non necessaria, dato che index è sempre minore di todos.length)
                    if(index < todos.length) {
                      // Ritorna la cella personalizzata per il Todo corrente
                      return TodoCell(todo: todo);
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                // Se la lista è vuota, mostra un messaggio di congratulazioni
                return const Center(
                  child: Text(
                      "Evviva!\nNon hai cose da fare",
                      textAlign: TextAlign.center
                  ),
                );
              }
            } else {
              // Stato non gestito: ritorna un Container vuoto
              return Container();
            }
          },
        ),
        // Bottone per aggiungere un nuovo Todo
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Naviga alla pagina per aggiungere un nuovo Todo
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const AddTodoPage()));
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white, size: 36,),
        ),
      ),
    );
  }

  /// Metodo per mostrare uno SnackBar quando un Todo viene aggiunto
  void _showSnackbar(BuildContext context) {
    SnackBar snackBar = const SnackBar(
      content: Text(
        'Todo aggiunta!',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
