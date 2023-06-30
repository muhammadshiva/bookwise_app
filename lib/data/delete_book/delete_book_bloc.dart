import 'package:bloc/bloc.dart';
import 'package:BookWise/repository/book_repository.dart';
import 'package:meta/meta.dart';

part 'delete_book_event.dart';
part 'delete_book_state.dart';

class DeleteBookBloc extends Bloc<DeleteBookEvent, DeleteBookState> {
  DeleteBookBloc() : super(DeleteBookInitial()) {
    on<DeleteBookEvent>((event, emit) async {
      if (event is DeleteBook) {
        try {
          emit(DeleteBookLoading());

          await BookRepository().deleteBook(event.id);

          emit(DeleteBookSuccess());
        } catch (e) {
          emit(DeleteBookFailed(e.toString()));
        }
      }
    });
  }
}
