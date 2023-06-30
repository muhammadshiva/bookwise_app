import 'package:bloc/bloc.dart';
import 'package:BookWise/models/edit_book_model.dart';
import 'package:BookWise/repository/book_repository.dart';
import 'package:meta/meta.dart';

part 'edit_book_event.dart';
part 'edit_book_state.dart';

class EditBookBloc extends Bloc<EditBookEvent, EditBookState> {
  EditBookBloc() : super(EditBookInitial()) {
    on<EditBookEvent>((event, emit) async {
      if (event is EditBook) {
        try {
          emit(EditBookLoading());

          await BookRepository().editBook(event.data);

          emit(EditBookSuccess());
        } catch (e) {
          emit(EditBookFailed(e.toString()));
        }
      }
    });
  }
}
