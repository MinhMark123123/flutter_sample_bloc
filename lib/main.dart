import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc/login/login_widget.dart';
import 'home/home_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginWidget(),
    );
  }
}


abstract class BlocBase {
  ///clear and close all resource please. Make sure we closed all stream after this method
  void dispose();
}

class BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  BlocProvider({Key key, @required T bloc, Widget child})
      : this.bloc = bloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Type _typeOf<T>() => T;

  static T of<T extends BlocBase>(BuildContext context) {
    var type = _typeOf<BlocProvider<T>>();
    return (context.inheritFromWidgetOfExactType(type) as BlocProvider<T>).bloc;
  }
}
