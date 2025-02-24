import 'package:flutter/material.dart';

/// Widget personalizzato che implementa una checkbox circolare
/// con stato gestito tramite [ValueNotifier] e callback [onChanged]
class CustomCheckbox extends StatefulWidget {
  /// Indica se la checkbox è selezionata
  final bool selected;

  /// Altezza della checkbox (opzionale, default: 24)
  final double? height;

  /// Larghezza della checkbox (opzionale, default: 24)
  final double? width;

  /// Funzione di callback che viene chiamata quando lo stato cambia
  final Function(bool) onChanged;

  /// Costruttore della [CustomCheckbox]
  const CustomCheckbox({
    super.key,
    required this.selected,
    required this.onChanged,
    this.height = 24,
    this.width = 24,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  // ValueNotifier per gestire e notificare i cambiamenti dello stato della checkbox
  final ValueNotifier<bool> _selected = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    // Inizializza _selected con il valore fornito dal widget padre
    _selected.value = widget.selected;
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se il valore 'selected' del widget padre cambia, aggiorna _selected di conseguenza
    if (oldWidget.selected != widget.selected) {
      _selected.value = widget.selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Utilizza ValueListenableBuilder per ricostruire il widget ogni volta che _selected cambia
    return ValueListenableBuilder(
      valueListenable: _selected,
      builder: (context, selected, _) {
        return GestureDetector(
          // Al tocco, inverte lo stato della checkbox e invoca il callback onChanged
          onTap: () {
            _selected.value = !selected;
            widget.onChanged(!selected);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            // Imposta la decorazione del container: forma circolare, colore di sfondo e bordo
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Se selezionata, il colore di sfondo è verde; altrimenti, bianco
              color: selected ? Colors.green : Colors.white,
              // Se non selezionata, mostra un bordo verde; se selezionata, il bordo è trasparente
              border: Border.all(color: selected ? Colors.transparent : Colors.green, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              // Se la checkbox è selezionata, mostra un'icona di spunta; altrimenti, mostra un container vuoto
              child: selected
                  ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
                  : Container(),
            ),
          ),
        );
      },
    );
  }
}
