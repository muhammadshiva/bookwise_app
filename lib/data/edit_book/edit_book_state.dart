part of 'edit_book_bloc.dart';

@immutable
abstract class EditBookState {}

class EditBookInitial extends EditBookState {}

class EditBookLoading extends EditBookState {}

class EditBookFailed extends EditBookState {
  final String e;
  EditBookFailed(this.e);
}

class EditBookSuccess extends EditBookState {}
