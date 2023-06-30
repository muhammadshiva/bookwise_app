import 'package:bloc/bloc.dart';
import 'package:BookWise/repository/book_repository.dart';
import 'package:meta/meta.dart';

part 'fetch_book_by_id_event.dart';
part 'fetch_book_by_id_state.dart';

class FetchBookByIdBloc extends Bloc<FetchBookByIdEvent, FetchBookByIdState> {
  FetchBookByIdBloc() : super(FetchBookByIdInitial()) {
    on<FetchBookByIdEvent>((event, emit) async {
      if (event is FetchBookById) {
        try {
          emit(FetchBookByIdLoading());

          await BookRepository().getBookById(event.id);

          emit(FetchBookByIdSuccess());
        } catch (e) {
          emit(FetchBookByIdFailed(e.toString()));
        }
      }
    });
  }
}
