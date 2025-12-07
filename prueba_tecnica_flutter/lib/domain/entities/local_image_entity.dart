
class LocalImageEntity {
  final String id;
  final String author;
  final String downloadUrl;
  final String? customName;

  LocalImageEntity({
    required this.id,
    required this.author,
    required this.downloadUrl,
    this.customName,
  });

  LocalImageEntity copyWith({
    String? id,
    String? author,
    String? downloadUrl,
    String? customName,
  }) {
    return LocalImageEntity(
      id: id ?? this.id,
      author: author ?? this.author,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      customName: customName ?? this.customName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'download_url': downloadUrl,
      'custom_name': customName,
    };
  }

  factory LocalImageEntity.fromMap(Map<String, dynamic> map) {
    return LocalImageEntity(
      id: map['id'].toString(),
      author: map['author']?.toString() ?? '',
      downloadUrl: map['download_url']?.toString() ?? '',
      customName: map['custom_name']?.toString(),
    );
  }

  @override
  String toString() =>
      'LocalImageEntity(id: $id, author: $author, downloadUrl: $downloadUrl, customName: $customName)';
}
