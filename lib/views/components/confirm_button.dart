import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/views/utilities/utils.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/todos_bloc/todos_bloc.dart';
import '../../data/models/todo.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/database_service.dart';
import '../styles/styles.dart';

/// Widget che rappresenta il pulsante di conferma per salvare un nuovo Todo
class ConfirmButton extends StatelessWidget {
  /// Costruttore del ConfirmButton che richiede:
  /// - [confirmButtonEnabled]: un ValueNotifier che indica se il pulsante deve essere abilitato
  /// - [todoTEC]: il controller del TextField contenente il testo del Todo
  const ConfirmButton({
    super.key,
    required ValueNotifier<bool> confirmButtonEnabled,
    required TextEditingController todoTEC,
  })  : _confirmButtonEnabled = confirmButtonEnabled,
        _todoTEC = todoTEC;

  // Notifier per abilitare o disabilitare il pulsante in base alla validità del testo
  final ValueNotifier<bool> _confirmButtonEnabled;
  // Controller per ottenere il testo inserito dall'utente
  final TextEditingController _todoTEC;

  @override
  Widget build(BuildContext context) {
    // Utilizza ValueListenableBuilder per ricostruire il widget quando _confirmButtonEnabled cambia
    return ValueListenableBuilder(
      valueListenable: _confirmButtonEnabled,
      builder: (context, enabled, _) {
        // BlocListener per ascoltare gli eventi del TodosBloc
        return BlocListener<TodosBloc, TodosState>(
          listener: (context, state) async {
            // Se un nuovo Todo è stato aggiunto, chiudi la pagina corrente
            if (state is TodoAdded) {
              Navigator.of(context).pop();
            }
          },
          // BlocBuilder per ricostruire il pulsante in base allo stato del TodosBloc
          child: BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              // Se lo stato è in caricamento, mostra un indicatore di progresso
              if (state is TodosLoading) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                  width: double.infinity,
                  child: const CircularProgressIndicator.adaptive(),
                );
              } else {
                // Altrimenti, mostra il pulsante di conferma
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    shadowColor: Colors.transparent,
                    // Imposta il colore di sfondo in base allo stato di abilitazione
                    backgroundColor: enabled ? Colors.green : Styles.grey4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    // Crea un nuovo Todo con i dati inseriti dall'utente
                    final todo = Todo(
                      // Genera un ID unico per il Todo
                      id: const Uuid().v1(),
                      // Imposta l'UID dell'utente autenticato
                      userUid: AuthRepository().authUser!.uid,
                      // Contenuto del Todo preso dal TextEditingController
                      content: _todoTEC.value.text,
                      done: false,
                      // Imposta i timestamp di creazione e aggiornamento usando il DatabaseService
                      createdAt: DatabaseService().timestamp.millisecondsSinceEpoch.toString(),
                      updatedAt: DatabaseService().timestamp.millisecondsSinceEpoch.toString(),
                    );
                    // Invia l'evento per aggiungere il nuovo Todo al bloc
                    context.read<TodosBloc>().add(AddTodoEvent(todo: todo));
                  },
                  // Testo visualizzato sul pulsante
                  child: Text(
                    "Salva",
                    style: context.textTheme.bodyLarge?.copyWith(
                      // Il colore del testo cambia in base allo stato di abilitazione
                      color: enabled ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
