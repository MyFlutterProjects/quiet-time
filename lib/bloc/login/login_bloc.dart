import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiet_time/bloc/authentication_bloc/authentication.dart';
import 'package:quiet_time/repository/user_repository.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   final UserRepository userRepository;
   final AuthenticationBloc authenticationBloc;

   LoginBloc({ 
     @required  this.userRepository,
     @required  this.authenticationBloc
   });
   
  @override
  LoginState get initialState => null;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event)  async*{
      if (event is LoginButtonPressed) {
        yield  LoginLoading();

        try { 
          final token = await  userRepository.authenticate(
            username: event.username,
             password: event.password
             );
             authenticationBloc.add(LoggedIn(token: token));
             yield  LoginInitial();
        } catch(error) {
          yield  LoginFailure(error: error.toString());
        }
      }
  }

}