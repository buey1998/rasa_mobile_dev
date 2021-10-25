part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class SignUp extends AuthenticationEvent {
  final String fullname, email, password;
  SignUp(this.fullname, this.email, this.password);
}
