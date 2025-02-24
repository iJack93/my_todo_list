import 'package:equatable/equatable.dart';

/// Classe che rappresenta un Todo.
/// Estende Equatable per facilitare il confronto tra istanze.
class Todo extends Equatable {
  /// Identificatore univoco del Todo.
  String? id;

  /// UID dell'utente a cui appartiene il Todo.
  String? userUid;

  /// Descrizione o contenuto del Todo.
  String? content;

  /// Stato di completamento del Todo: true se completato, false altrimenti.
  bool? done;

  /// Timestamp della creazione del Todo, rappresentato come stringa.
  String? createdAt;

  /// Timestamp dell'ultimo aggiornamento del Todo, rappresentato come stringa.
  String? updatedAt;

  /// Costruttore principale per creare un nuovo Todo.
  Todo({
    this.id,
    this.userUid,
    this.content,
    this.done,
    this.createdAt,
    this.updatedAt,
  });

  /// Costruttore che crea un oggetto Todo a partire da una mappa JSON.
  Todo.fromJson(dynamic json) {
    id = json['id'];
    userUid = json['userUid'];
    content = json['content'];
    done = json['done'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  /// Converte l'oggetto Todo in una mappa JSON.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userUid'] = userUid;
    map['content'] = content;
    map['done'] = done;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  /// Crea una copia del Todo aggiornando solo i campi specificati.
  Todo copyWith({
    String? id,
    String? userUid,
    String? content,
    bool? done,
    String? createdAt,
    String? updatedAt,
  }) => Todo(
    id: id ?? this.id,
    userUid: userUid ?? this.userUid,
    content: content ?? this.content,
    done: done ?? this.done,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /// Lista dei campi utilizzati per il confronto delle istanze (Equatable).
  @override
  List<Object?> get props => [id, userUid, content, done, createdAt, updatedAt];
}
