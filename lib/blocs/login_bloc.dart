import 'dart:async';

import 'package:patronbloc/blocs/validaciones.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validaciones {
  final _emailControl = BehaviorSubject<String>();
  final _passwordControl = BehaviorSubject<String>();

  //Recuperar los datos del stream

  Stream<String> get emailStream =>
      _emailControl.stream.transform(validarEmail);
  Stream<String> get passStream =>
      _passwordControl.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passStream, (e, p) => true);

  //get y set
  Function(String) get changeEmail => _emailControl.sink.add;
  Function(String) get changePassword => _passwordControl.sink.add;

  //obtener el ultimo valor
  String get email => _emailControl.value;
  String get password => _passwordControl.value;

  dispose() {
    _emailControl?.close();
    _passwordControl?.close();
  }
}
