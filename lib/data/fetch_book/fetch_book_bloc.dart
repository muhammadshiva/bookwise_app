import 'package:bloc/bloc.dart';
import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/repository/book_repository.dart';
import 'package:meta/meta.dart';

part 'fetch_book_event.dart';
part 'fetch_book_state.dart';

class FetchBookBloc extends Bloc<FetchBookEvent, FetchBookState> {
  FetchBookBloc() : super(FetchBookInitial()) {
    on<FetchBookEvent>((event, emit) async {
      if (event is FetchBooks) {
        try {
          emit(FetchBookLoading());

          final List<BookModel> books = await BookRepository().getAllBooks();

          emit(FetchBookSuccess(books));
        } catch (e) {
          emit(FetchBookFailed(e.toString()));
        }
      }
    });
  }
}
