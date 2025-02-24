import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/confirm_button.dart';
import '../components/custom_text_form_field.dart';
import '../styles/styles.dart';

/// Pagina per aggiungere un nuovo Todo
class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // Chiave globale per il form, utilizzata per la validazione
  final _formKey = GlobalKey<FormState>();
  // FocusNode per gestire il focus del campo di input del todo
  final FocusNode _todoFC = FocusNode();
  // Controller per il campo di input del todo
  final TextEditingController _todoTEC = TextEditingController();
  // ValueNotifier per abilitare/disabilitare il pulsante di conferma in base al contenuto del campo di input
  final ValueNotifier<bool> _confirmButtonEnabled = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con sfondo verde e impostazioni per la status bar
      appBar: AppBar(
        backgroundColor: Colors.green,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green,
          statusBarIconBrightness: Brightness.light, //<-- Icone chiare per Android
          statusBarBrightness: Brightness.light, //<-- Icone chiare per iOS
        ),
        title: Text(
          "Aggiungi todo",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // Corpo della pagina che occupa tutta l'altezza dello schermo
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            // Rimuove il padding predefinito in alto e in basso
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: SingleChildScrollView(
                // Consente di nascondere la tastiera scorrendo manualmente
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  // Padding orizzontale per il contenuto
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Form per inserire il nuovo todo
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // Margine verticale per separare il campo di input
                              margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Titolo del form
                                  Text(
                                    "Aggiungi una cosa da fare",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    // Margine superiore e padding interno per il campo di input
                                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    // Decorazione del container con bordo arrotondato e bordo grigio
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(color: Styles.grey4),
                                    ),
                                    // Campo di input personalizzato per il testo del todo
                                    child: CustomTextFormField(
                                      hintText: "Scrivi qui..",
                                      focusNode: _todoFC,
                                      controller: _todoTEC,
                                      onChanged: (text) {
                                        // Valida il campo ogni volta che il testo cambia
                                        _validateFields();
                                      },
                                      textInputType: TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Sezione inferiore della pagina contenente il pulsante di conferma
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              // Pulsante di conferma personalizzato che utilizza il ValueNotifier per abilitarsi o disabilitarsi
              child: ConfirmButton(
                confirmButtonEnabled: _confirmButtonEnabled,
                todoTEC: _todoTEC,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Controlla se il TextEditingController è vuoto
  bool isTextControllerEmpty(TextEditingController controller) {
    bool result = false;
    if (controller.value.text.isEmpty) {
      return true;
    }
    return result;
  }

  /// Valida il campo di input e aggiorna lo stato del pulsante di conferma
  void _validateFields() {
    bool result = true;
    // Se il campo di testo è vuoto, il pulsante di conferma viene disabilitato
    if (isTextControllerEmpty(_todoTEC)) {
      result = false;
    }
    // Aggiorna il ValueNotifier con il nuovo stato (abilitato/disabilitato)
    _confirmButtonEnabled.value = result;
  }
}
