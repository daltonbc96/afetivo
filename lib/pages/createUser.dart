import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/MyTextFormField.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;
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
    final loginStore = Provider.of<LoginStore>(context);

    final userField = MyTextFormField(
      isEmail: true,
      hintText: 'E-Mail',
      onSaved: (value) {
        username = value;
      },
      validator: (value) => validator.isEmail(value) ? null : "Email Invalido",
    );

    final passwordField = MyTextFormField(
      isPassword: true,
      hintText: 'Senha',
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
      hintText: 'Confirme a Senha',
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
              error = e;
            });
          } catch (_) {
            setState(() {
              error = RegisterError.UnknownError;
            });
          } finally {
            setState(() {
              isLoading = false;
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
              return Text("Senha Fraca");
            case RegisterError.Unavailable:
              return Text("Usuario já cadastrado");
            case RegisterError.UnknownError:
              return Text("Erro desconhecido");
            default:
              return Text("");
          }
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  userField,
                  passwordField,
                  passwordConfirmationField,
                  finishButton,
                  errorMessage,
                ]),
          ),
        ),
      ),
    );
  }
}
