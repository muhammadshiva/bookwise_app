part of 'create_book_bloc.dart';

@immutable
abstract class CreateBookState {}

class CreateBookInitial extends CreateBookState {}

class CreateBookLoading extends CreateBookState {}

class CreateBookFailed extends CreateBookState {
  final String e;
  CreateBookFailed(this.e);
}

class CreateBookSuccess extends CreateBookState {}
