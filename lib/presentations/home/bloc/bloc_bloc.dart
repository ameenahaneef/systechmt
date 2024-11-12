import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:systechmt/data/models/model.dart';
import 'package:systechmt/data/repositories/api_services.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  final ApiService apiService;
  BlocBloc(this.apiService) : super(BlocInitial()) {
    on<Loaded>((event, emit)async {
      try {
        final students=await apiService.getDetails();
        emit(BlocLoaded(stud: students));
      } catch (e) {
        emit(BlocError(e.toString()));
      }
    });
  }
}
