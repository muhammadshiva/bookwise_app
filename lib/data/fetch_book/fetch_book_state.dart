part of 'fetch_book_bloc.dart';

@immutable
abstract class FetchBookState {}

class FetchBookInitial extends FetchBookState {}

class FetchBookLoading extends FetchBookState {}

class FetchBookFailed extends FetchBookState {
  final String e;
  FetchBookFailed(this.e);
}

class FetchBookSuccess extends FetchBookState {
  final List<BookModel> books;
  FetchBookSuccess(this.books);
}
