

/// LocalImageEntity
/// 
/// This class represents a local image entity with properties for ID, author, download URL, and custom name. 
/// 
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


  /// Converts the LocalImageEntity to a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'download_url': downloadUrl,
      'custom_name': customName,
    };
  }


  /// Creates a LocalImageEntity from a Map.
  factory LocalImageEntity.fromMap(Map<String, dynamic> map) {
    return LocalImageEntity(
      id: map['id'].toString(),
      author: map['author']?.toString() ?? '',
      downloadUrl: map['download_url']?.toString() ?? '',
      customName: map['custom_name']?.toString(),
    );
  }


/// Overrides the equality operator.
  @override
  String toString() =>
      'LocalImageEntity(id: $id, author: $author, downloadUrl: $downloadUrl, customName: $customName)';
}
