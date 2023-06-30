import 'dart:typed_data';

class EditBookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final int releaseYear;
  final String genre;
  final Uint8List? image;

  EditBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.releaseYear,
    required this.genre,
    this.image,
  });

  factory EditBookModel.fromJson(Map<String, dynamic> json) {
    return EditBookModel(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      description: json['description'] ?? "",
      releaseYear: json['release_year'] ?? 0,
      genre: json['genre'] ?? "",
      // image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'release_year': releaseYear,
      'genre': genre,
    };
  }
}
