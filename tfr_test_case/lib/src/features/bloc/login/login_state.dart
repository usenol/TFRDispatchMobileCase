abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String token;
  const LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);
} 