import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:systechmt/data/repositories/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      const validUsername = 'emilys';
      const validPassword = 'emilyspass';
      if (event.username == validUsername && event.password == validPassword) {
        try {
          await apiService.loginUser(
              userName: event.username, password: event.password);
          emit(LoginSuccess('Login Success'));
        } catch (e) {
          emit(LoginFailure('Login Failed:$e'));
        }
      } else {
        emit(LoginFailure('Invalid username and password'));
      }
    });
  }
}
