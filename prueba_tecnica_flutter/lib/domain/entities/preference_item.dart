

/// PreferenceItem
/// 
/// This class represents a preference item with properties for ID, title, custom name, and image URL.
///  
class PreferenceItem {
  final int? id;
  final String title;
  final String? customName;
  final String? imageUrl;

  PreferenceItem({
    this.id,
    required this.title,
    this.customName,
    this.imageUrl,
  });


  /// Converts the PreferenceItem to a Map.
  factory PreferenceItem.fromMap(Map<String, dynamic> json) {
    return PreferenceItem(
      id: json['id'] as int?,
      title: json['title'],
      customName: json['customName'],
      imageUrl: json['imageUrl'],
    );
  }

  /// Overrides the equality operator.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'customName': customName,
      'imageUrl': imageUrl,
    };
  }
}
