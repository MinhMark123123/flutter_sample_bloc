import 'dart:async';
import 'package:flutter_sample_bloc/main.dart';

final String STATE_LOADING = 'loading';
final String STATE_LOGIN_SUCCESS = 'sucess';
final String STATE_LOGIN_FAILED = 'failed';

class LoginBloc extends BlocBase {
  String _userName;
  String _password;
  StreamController<String> _loginSuccessController = StreamController.broadcast();
  StreamController<String> _userNameController = StreamController();
  StreamController<String> _passwordController = StreamController();
  Stream<String> get loginState => _loginSuccessController.stream;

  StreamSink<String> get userNameIn => _userNameController.sink;

  StreamSink<String> get passWordIn => _passwordController.sink;

  LoginBloc() {
    _userNameController.stream.listen(_handUserName);
    _passwordController.stream.listen(_handlePassWord);
  }

  void _handUserName(String userName) {
    _userName = userName;
  }

  void _handlePassWord(String password) {
    _password = password;
  }

  void doLogin() {
    _loginSuccessController.add(STATE_LOADING);
    Future.delayed(Duration(milliseconds: 3000), () {
      if (_userName == 'minhok' && _password == 'oktata') {
        _loginSuccessController.add(STATE_LOGIN_SUCCESS);
      } else {
        _loginSuccessController.add(STATE_LOGIN_FAILED);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.close();
    _userNameController.close();
    _loginSuccessController.close();
  }
}
