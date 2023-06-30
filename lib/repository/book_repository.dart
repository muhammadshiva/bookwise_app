import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/models/create_book_model.dart';
import 'package:BookWise/models/edit_book_model.dart';
import 'package:BookWise/shared/shared_value.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class BookRepository {
  late final GraphQLClient _client;

  BookRepository() {
    final Link link = HttpLink(baseUrl);
    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }

  Future<List<BookModel>> getAllBooks() async {
    final query = r'''
      query {
        getSingleUploads {
          _id
          title
          author
          description
          release_year
          genre
          image
          createdAt
          updatedAt
        }
    }
    ''';

    final result = await _client.query(QueryOptions(
      document: gql(query),
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final List<dynamic> bookData = result.data!['getSingleUploads'];
    final List<BookModel> books = bookData.map((data) => BookModel.fromJson(data)).toList();
    return books;
  }

  Future<BookModel> createBook(CreateBookModel book) async {
    final mutation = r'''
    mutation singleUpload($file: Upload!, $title: String!, $author: String!, $description: String!, $release_year: Int!, $genre: String!) {
      singleUpload(
        file: $file
        title: $title
        author: $author
        description: $description
        release_year: $release_year
        genre: $genre
      ) {
        message
      }
    }
  ''';

    var file = http.MultipartFile.fromBytes(
      'file',
      book.image,
      filename: 'photo-${DateTime.now().second}.jpg',
      contentType: MediaType('image', 'jpg'),
    );

    final variables = {
      'file': file,
      'title': book.title,
      'author': book.author,
      'description': book.description,
      'release_year': book.releaseYear,
      'genre': book.genre,
    };

    final result = await _client.mutate(MutationOptions(
      document: gql(mutation),
      variables: variables,
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final bookData = result.data!['singleUpload'];
    return BookModel.fromJson(bookData);
  }

  Future<EditBookModel> editBook(EditBookModel book) async {
    final mutation = r'''
    mutation singleUploadEdit($id: ID!, $file: Upload!, $title: String!, $author: String!, $description: String!, $release_year: Int!, $genre: String!){
      singleUploadEdit(
        id: $id
        file: $file
        title: $title
        author: $author
        description: $description
        release_year: $release_year
        genre: $genre
      ) {
        _id
        title
        author
        description
        release_year
        genre
     
      }
    }
    ''';

    var file = http.MultipartFile.fromBytes(
      'file',
      book.image!,
      filename: 'photo-${DateTime.now().second}.jpg',
      contentType: MediaType('image', 'jpg'),
    );

    final variables = {
      'id': book.id,
      'file': file,
      'title': book.title,
      'author': book.author,
      'description': book.description,
      'release_year': book.releaseYear,
      'genre': book.genre,
    };

    final result = await _client.mutate(MutationOptions(
      document: gql(mutation),
      variables: variables,
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final bookData = result.data!['singleUploadEdit'];
    return EditBookModel.fromJson(bookData);
  }

  Future<void> deleteBook(String id) async {
    final mutation = r'''
    mutation deleteSingleUpload ($id: ID!){
      deleteSingleUpload(id: $id) {
        message
      }
    }
    ''';

    final variables = {
      'id': id,
    };

    final result = await _client.mutate(MutationOptions(
      document: gql(mutation),
      variables: variables,
    ));

    if (result.hasException) {
      throw result.exception!;
    }
  }

  Future<BookModel> getBookById(String id) async {
    final query = r'''
      query GetBookById($id: String!) {
        getBookById(_id: $id) {
          _id
          title
          author
          description
          release_year
          genre
        }
      }
    ''';

    final variables = {
      'id': id,
    };

    final result = await _client.query(QueryOptions(
      document: gql(query),
      variables: variables,
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final bookData = result.data!['getBookById'];
    return BookModel.fromJson(bookData);
  }
}


// ----------------------------- BACKUP ----------------------------- //

// import 'package:BookWise/models/book_model.dart';
// import 'package:BookWise/shared/shared_value.dart';
// import 'package:graphql/client.dart';

// class BookRepository {
//   late final GraphQLClient _client;

//   BookRepository() {
//     final Link link = HttpLink(baseUrl);
//     _client = GraphQLClient(
//       cache: GraphQLCache(),
//       link: link,
//     );
//   }

//   Future<List<BookModel>> getAllBooks() async {
//     final query = r'''
//       query GetAllBooks {
//         getAllBooks {
//           _id
//           title
//           author
//           description
//           release_year
//           genre
//         }
//       }
//     ''';

//     final result = await _client.query(QueryOptions(
//       document: gql(query),
//     ));

//     if (result.hasException) {
//       throw result.exception!;
//     }

//     final List<dynamic> bookData = result.data!['getAllBooks'];
//     final List<BookModel> books = bookData.map((data) => BookModel.fromJson(data)).toList();
//     return books;
//   }

//   Future<BookModel> createBook(BookModel book) async {
//     final mutation = r'''
//       mutation CreateBook($book: BookInput!) {
//         createBook(
//           title: $book.title
//           author: $book.author
//           description: $book.description
//           release_year: $book.releaseYear
//           genre: $book.genre
//         ) {
//           _id
//           title
//           author
//           description
//           release_year
//           genre
//         }
//       }
//     ''';

//     final variables = {
//       'book': book.toJson(),
//     };

//     final result = await _client.mutate(MutationOptions(
//       document: gql(mutation),
//       variables: variables,
//     ));

//     if (result.hasException) {
//       throw result.exception!;
//     }

//     final bookData = result.data!['createBook'];
//     return BookModel.fromJson(bookData);
//   }

//   Future<BookModel> updateBook(BookModel book, String id) async {
//     final mutation = r'''
//       mutation UpdateBook($id: String!, $book: BookInput!) {
//         updateBook(
//           _id: $id
//           title: $book.title
//           author: $book.author
//           description: $book.description
//           release_year: $book.releaseYear
//           genre: $book.genre
//         ) {
//           _id
//           title
//           author
//           description
//           release_year
//           genre
//         }
//       }
//     ''';

//     final variables = {
//       'id': id,
//       'book': book.toJson(),
//     };

//     final result = await _client.mutate(MutationOptions(
//       document: gql(mutation),
//       variables: variables,
//     ));

//     if (result.hasException) {
//       throw result.exception!;
//     }

//     final bookData = result.data!['updateBook'];
//     return BookModel.fromJson(bookData);
//   }

//   Future<void> deleteBook(String id) async {
//     final mutation = r'''
//       mutation DeleteBook($id: String!) {
//         deleteBook(_id: $id)
//       }
//     ''';

//     final variables = {
//       'id': id,
//     };

//     final result = await _client.mutate(MutationOptions(
//       document: gql(mutation),
//       variables: variables,
//     ));

//     if (result.hasException) {
//       throw result.exception!;
//     }
//   }

//   Future<BookModel> getBookById(String id) async {
//     final query = r'''
//       query GetBookById($id: String!) {
//         getBookById(_id: $id) {
//           _id
//           title
//           author
//           description
//           release_year
//           genre
//         }
//       }
//     ''';

//     final variables = {
//       'id': id,
//     };

//     final result = await _client.query(QueryOptions(
//       document: gql(query),
//       variables: variables,
//     ));

//     if (result.hasException) {
//       throw result.exception!;
//     }

//     final bookData = result.data!['getBookById'];
//     return BookModel.fromJson(bookData);
//   }
// }
