part of 'delete_book_bloc.dart';

@immutable
abstract class DeleteBookState {}

class DeleteBookInitial extends DeleteBookState {}

class DeleteBookLoading extends DeleteBookState {}

class DeleteBookFailed extends DeleteBookState {
  final String e;
  DeleteBookFailed(this.e);
}

class DeleteBookSuccess extends DeleteBookState {}
