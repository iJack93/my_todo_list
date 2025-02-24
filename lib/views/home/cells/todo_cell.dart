import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/todo.dart';
import '../../../blocs/complete_todo_bloc/complete_todo_bloc.dart';
import '../../components/custom_checkbox.dart';

/// Widget che rappresenta una cella della lista dei Todo
class TodoCell extends StatelessWidget {
  // Variabile che contiene i dati del Todo
  final Todo todo;

  /// Costruttore che richiede il Todo da visualizzare
  const TodoCell({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Margine verticale per separare le celle
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        // Arrotondamento degli angoli del container
        borderRadius: BorderRadius.circular(9),
        // Ombreggiatura per dare profondità alla cella
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 8.0,
            spreadRadius: 0.0,
            offset: const Offset(
              0.0, 2.0, // Spostamento orizzontale e verticale dell'ombra
            ),
          ),
        ]
      ),
      // ListTile per strutturare il contenuto della cella
      child: ListTile(
        // Widget personalizzato per il checkbox
        leading: CustomCheckbox(
          // Stato selezionato in base al campo 'done' del Todo, se nullo assume false
          selected: todo.done ?? false,
          // Callback che viene chiamato quando lo stato del checkbox cambia
          onChanged: (bool done) {
            // Aggiorna lo stato del Todo
            todo.done = done;
            // Invia un evento al CompleteTodoBloc per aggiornare il Todo
            context.read<CompleteTodoBloc>().add(CompleteTodoEvent(todo: todo));
          },
        ),
        // Titolo del ListTile che mostra il contenuto del Todo
        title: Text(
          todo.content ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
