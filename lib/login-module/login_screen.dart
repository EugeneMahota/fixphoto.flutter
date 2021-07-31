import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/widgets/text_with_loader.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginViewModel model = serviceLocator<LoginViewModel>();

  final TextEditingController _loginController =
      TextEditingController(text: 'stasmina');
  final TextEditingController _passwordController =
      TextEditingController(text: 'stasmina123321');

  final Image logo = Image.asset('lib/assets/images/login-page-logo.png');
  final double padding = 15;

  @override
  void initState() {
    super.initState();
    _loginController.addListener(
      () => model.loginListener(_loginController),
    );
    _passwordController.addListener(
      () => model.passwordListener(_passwordController),
    );
    model.initForm(_loginController, _passwordController);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => _loginPage(),
      ),
    );
  }

  Widget _loginPage() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: <Widget>[
                _logo(),
                _title(),
                _loginField(),
                _passwordField(),
                _forgotButton(),
                _loginButton(),
                ..._loveText(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Center(
        child: Container(
          height: 80,
          child: logo,
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.only(
        top: padding,
        bottom: padding,
      ),
      child: Center(
        child: Container(
          child: Text(
            'FIXPhoto',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors().pink,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: CupertinoTextField(
        keyboardType: TextInputType.text,
        prefix: _fieldIcon(CupertinoIcons.person),
        padding: _paddingField(),
        placeholder: 'Введите логин',
        controller: _loginController,
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: EdgeInsets.only(
        left: padding,
        right: padding,
        top: padding,
      ),
      child: CupertinoTextField(
        prefix: _fieldIcon(CupertinoIcons.eye_slash),
        obscureText: true,
        padding: _paddingField(),
        placeholder: 'Пароль',
        controller: _passwordController,
      ),
    );
  }

  EdgeInsets _paddingField() {
    return EdgeInsets.only(
      top: padding,
      bottom: padding,
      left: padding,
    );
  }

  Widget _fieldIcon(icon) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: Icon(icon),
    );
  }

  Widget _forgotButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Забыл пароль',
        style: TextStyle(
          color: AppColors().pink,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: 270,
      child: CupertinoButton(
        color: AppColors().pink,
        child: TextWithLoader(
          title: 'Войти',
          isLoading: model.isLoading,
          fontSize: 25,
        ),
        onPressed: () => model.login(context),
      ),
    );
  }

  List<Widget> _loveText() {
    return [
      SizedBox(
        height: 15,
      ),
      Text('Created with Love by Eugene'),
    ];
  }
}
