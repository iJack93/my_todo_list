import 'package:flutter/material.dart';
import '../styles/styles.dart';

/// Widget personalizzato per un campo di input testuale con stili personalizzati
class CustomTextFormField extends StatelessWidget {
  /// Indica se il campo è abilitato o meno (default: true)
  final bool enabled;
  /// Testo di suggerimento da mostrare quando il campo è vuoto
  final String hintText;
  /// Etichetta opzionale da visualizzare sopra il campo
  final String? labelText;
  /// Controller per gestire il testo inserito
  final TextEditingController? controller;
  /// Stile opzionale per l'etichetta
  final TextStyle? labelStyle;
  /// Espressione regolare opzionale per la validazione del testo
  final RegExp? regExp;
  /// Indica se il campo deve usare un layout più compatto
  final bool? isDense;
  /// FocusNode opzionale per gestire il focus del campo
  final FocusNode? focusNode;
  /// Callback da invocare quando il testo cambia
  final Function(String)? onChanged;
  /// Tipo di input della tastiera (es. testo, numero, email, ecc.)
  final TextInputType? textInputType;
  /// Flag che indica se il campo è destinato all'input email (default: false)
  final bool email;

  /// Costruttore per il CustomTextFormField
  const CustomTextFormField({
    super.key,
    this.enabled = true,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.labelStyle,
    this.regExp,
    this.isDense,
    this.focusNode,
    this.onChanged,
    this.textInputType,
    this.email = false,
  });

  @override
  Widget build(BuildContext context) {
    // Utilizza un Theme personalizzato per modificare il colore dei widget disabilitati
    return Theme(
      data: ThemeData(
        disabledColor: Styles.black,
      ),
      // Campo di input testuale con stili e comportamenti personalizzati
      child: TextFormField(
        // Capitalizza la prima lettera di ogni frase
        textCapitalization: TextCapitalization.sentences,
        // Abilita o disabilita il campo in base al parametro 'enabled'
        enabled: enabled,
        // Controller per gestire il testo
        controller: controller,
        // FocusNode per gestire il focus sul campo
        focusNode: focusNode,
        // Callback per notificare i cambiamenti del testo
        onChanged: onChanged,
        // Tipo di input della tastiera
        keyboardType: textInputType,
        // Impostazioni della decorazione del campo di input
        decoration: InputDecoration(
          // Etichetta del campo, se fornita
          labelText: labelText,
          // Stile dell'etichetta, se specificato
          labelStyle: labelStyle,
          // Testo di suggerimento (placeholder)
          hintText: hintText,
          // Stile del suggerimento, impostato in base al tema corrente e a uno stile personalizzato
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Styles.grey1,
          ),
          // Padding interno del contenuto del campo
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          // Rimuove i bordi predefiniti del campo
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          // Imposta se il campo deve avere un layout denso
          isDense: isDense,
        ),
      ),
    );
  }
}
