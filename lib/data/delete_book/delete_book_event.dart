part of 'delete_book_bloc.dart';

@immutable
abstract class DeleteBookEvent {}

class DeleteBook extends DeleteBookEvent {
  final String id;

  DeleteBook(this.id);
}
