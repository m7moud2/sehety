class AuthState {}

class AuthInitialState extends AuthState {}

//login
class LoginLoadingStat extends AuthState {}

class LoginSuccessStat extends AuthState {}

class LoginErrorStat extends AuthState {
  final String error;
  LoginErrorStat({required this.error});
}


//register
class RegisterLoadingStat extends AuthState {}

class RegisterSuccessStat extends AuthState {}

class RegisterErrorStat extends AuthState {
  final String error;
  RegisterErrorStat({required this.error});
}


