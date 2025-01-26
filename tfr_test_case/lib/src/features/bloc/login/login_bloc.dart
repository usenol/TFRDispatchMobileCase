import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../../services/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    try {
      final loginRequest = LoginRequestModel(
        username: event.username,
        password: event.password,
      );

      final response = await ApiService.login(loginRequest);

      if (response.error != null) {
        emit(LoginFailure(response.error!));
      } else {
        emit(LoginSuccess(response.token));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
} 