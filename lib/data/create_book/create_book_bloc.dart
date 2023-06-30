import 'package:bloc/bloc.dart';
import 'package:BookWise/models/book_model.dart';
import 'package:BookWise/models/create_book_model.dart';
import 'package:BookWise/repository/book_repository.dart';
import 'package:meta/meta.dart';

part 'create_book_event.dart';
part 'create_book_state.dart';

class CreateBookBloc extends Bloc<CreateBookEvent, CreateBookState> {
  CreateBookBloc() : super(CreateBookInitial()) {
    on<CreateBookEvent>((event, emit) async {
      if (event is CreateBook) {
        try {
          emit(CreateBookLoading());

          await BookRepository().createBook(event.book);

          emit(CreateBookSuccess());
        } catch (e) {
          emit(CreateBookFailed(e.toString()));
        }
      }
    });
  }
}
