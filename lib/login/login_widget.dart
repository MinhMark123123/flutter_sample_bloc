import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc/home/home_widget.dart';
import 'package:flutter_sample_bloc/main.dart';
import 'login_bloc.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(),
      child: _Login(),
    );
  }
}

class _Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginSate();
  }
}

class LoginSate extends State<_Login> {
  LoginBloc _bloc;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _bloc = BlocProvider.of<LoginBloc>(context);
    _userNameController.addListener(() => _bloc.userNameIn.add(_userNameController.text));
    _passWordController.addListener(() => _bloc.passWordIn.add(_passWordController.text));
    _bloc.loginState.listen((state) {
      if (state == STATE_LOGIN_SUCCESS) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeWidget()));
      }
    });
    Widget buildUserTextField = Container(
      margin: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: TextField(
        controller: _userNameController,
        decoration: InputDecoration(hintText: 'Username'),
      ),
    );
    Widget buildPasswordTextField = Container(
      margin: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: TextField(
        controller: _passWordController,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder<String>(
              stream: _bloc.loginState,
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.data != null) {
                  print('${snapshot.data}');
                }
                if (snapshot != null && snapshot.data == STATE_LOADING) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildUserTextField,
                      buildPasswordTextField,
                      RaisedButton(
                        onPressed: () => _bloc.doLogin(),
                        child: Text('Login'),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
