import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignUp>(signUp);
  }
  signUp(SignUp event, emit) async {
    var result = await addUser(event.fullname, event.password, event.email);
    print(result);
    emit(SignUpSucess());
  }

  Future addUser(fullName, password, email) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    try {
      return users.add({
        'fullname': fullName, // John Doe
        'password': password, // Stokes and Sons
        'email': email // 42
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
