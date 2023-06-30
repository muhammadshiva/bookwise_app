part of 'edit_book_bloc.dart';

@immutable
abstract class EditBookEvent {}

class EditBook extends EditBookEvent {
  final EditBookModel data;

  EditBook(this.data);
}
