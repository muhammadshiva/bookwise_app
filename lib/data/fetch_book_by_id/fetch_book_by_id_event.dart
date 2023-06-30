part of 'fetch_book_by_id_bloc.dart';

@immutable
abstract class FetchBookByIdEvent {}

class FetchBookById extends FetchBookByIdEvent {
  final String id;

  FetchBookById(this.id);
}
