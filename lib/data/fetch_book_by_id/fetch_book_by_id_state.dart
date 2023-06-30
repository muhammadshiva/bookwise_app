part of 'fetch_book_by_id_bloc.dart';

@immutable
abstract class FetchBookByIdState {}

class FetchBookByIdInitial extends FetchBookByIdState {}

class FetchBookByIdLoading extends FetchBookByIdState {}

class FetchBookByIdFailed extends FetchBookByIdState {
  final String e;
  FetchBookByIdFailed(this.e);
}

class FetchBookByIdSuccess extends FetchBookByIdState {}
