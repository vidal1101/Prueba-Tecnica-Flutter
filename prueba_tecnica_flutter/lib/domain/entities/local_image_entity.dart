class LocalImageEntity {
  final String id;
  final String author;
  final String downloadUrl;

  LocalImageEntity({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  // copyWith para crear nuevas instancias modificadas (inmutabilidad)
  LocalImageEntity copyWith({
    String? id,
    String? author,
    String? downloadUrl,
  }) {
    return LocalImageEntity(
      id: id ?? this.id,
      author: author ?? this.author,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  // Convertir a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'download_url': downloadUrl,
    };
  }

  // Crear entidad desde Map (SQLite / DB)
  factory LocalImageEntity.fromMap(Map<String, dynamic> map) {
    return LocalImageEntity(
      id: map['id'].toString(),
      author: map['author']?.toString() ?? '',
      downloadUrl: map['download_url']?.toString() ?? '',
    );
  }

  @override
  String toString() =>
      'LocalImageEntity(id: $id, author: $author, downloadUrl: $downloadUrl)';
}
