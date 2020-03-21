import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiet_time/bloc/login/login.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add( 
        LoginButtonPressed( 
          username:  _usernameController.text,
          password: _passwordController.text
        ),
      );
    }
    return BlocListener <LoginBloc, LoginState>(
         listener: (context, state) {
           if(state is LoginFailure) {
             Scaffold.of(context).showSnackBar(
                  SnackBar( 
                 content: Text('${state.error}'),
                 backgroundColor: Colors.red,
               ),
             ) ;         
           }
         },
         child: BlocBuilder<LoginBloc, LoginState> (
           builder: (context, state) {
             return Form( 
               child:  SingleChildScrollView(
                                child: Column(
                   children: <Widget>[
                     TextFormField(
                       decoration: InputDecoration( labelText: 'username'),
                       controller: _usernameController,
                     ),
                     TextFormField( 
                       decoration: InputDecoration( labelText: 'password'),
                       controller: _passwordController,
                     ),
                     RaisedButton(
                       onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                       child:  Text('Login'),
                       ),
                       Container(
                         child: state is LoginLoading ? CircularProgressIndicator() : null,
                       )

                   ],
                   ),
               ),
             );
           } ,
           )
          
    );
  }
}