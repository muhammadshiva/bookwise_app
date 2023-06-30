part of 'create_book_bloc.dart';

@immutable
abstract class CreateBookEvent {}

class CreateBook extends CreateBookEvent {
  final CreateBookModel book;

  CreateBook(this.book);
}
