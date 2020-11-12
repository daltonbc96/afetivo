import 'package:validators/validators.dart' as validator;
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/MyTextFormField.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  static final tag = "/createUser";
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _pageTitle = "Criar Usuario";
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  RegisterError error = RegisterError.NotAnError;
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    final loginStore = LoginStore();

    final userField = MyTextFormField(
      isEmail: true,
      labelText: 'E-Mail',
      onSaved: (value) {
        username = value;
      },
      validator: (value) => validator.isEmail(value) ? null : "Email Invalido",
    );

    final passwordField = MyTextFormField(
      isPassword: true,
      labelText: 'Senha',
      onSaved: (value) {
        password = value;
      },
      validator: (value) {
        _formKey.currentState.save();
        if (value.length < 6)
          return 'Escolha uma senha com pelo menos 6 digitos.';

        return null;
      },
    );

    final passwordConfirmationField = MyTextFormField(
      isPassword: true,
      labelText: 'Confirme a Senha',
      validator: (value) =>
          value == password ? null : "As senhas não correspondem.",
    );

    final finishButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: new MaterialButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0)),
        height: 40.0,
        minWidth: 70.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text("Registrar", style: TextStyle(fontSize: 16.0)),
        onPressed: () async {
          if (!_formKey.currentState.validate()) return;
          _formKey.currentState.save();
          setState(() {
            isLoading = true;
          });
          try {
            await loginStore.createUser(username, password);
          } on RegisterError catch (e) {
            setState(() {
              isLoading = false;
              error = e;
            });
          } catch (_) {
            setState(() {
              isLoading = false;
              error = RegisterError.UnknownError;
            });
          }
        },
        splashColor: Colors.redAccent,
      ),
    );

    final errorMessage = Container(
      child: Builder(
        builder: (context) {
          switch (error) {
            case RegisterError.Invalid:
              return Text("Usuario ou senha invalido",
                  style: TextStyle(color: Colors.redAccent));
            case RegisterError.WeakPassword:
              return Text("Senha Fraca",
                  style: TextStyle(color: Colors.redAccent));
            case RegisterError.Unavailable:
              return Text("Usuario já cadastrado",
                  style: TextStyle(color: Colors.redAccent));
            case RegisterError.UnknownError:
              return Text(
                  "Erro desconhecido, tente alterar sua senha e/ou e-mail",
                  style: TextStyle(color: Colors.redAccent));
            default:
              return Text("");
          }
        },
      ),
    );

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pageTitle),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  userField,
                  passwordField,
                  passwordConfirmationField,
                  errorMessage,
                  finishButton,
                ]),
          ),
        ),
      ),
    );
  }
}
