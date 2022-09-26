import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';
import '../xelauikit/models/xela_button_models.dart';
import '../xelauikit/xela_button.dart';
import '../xelauikit/xela_color.dart';
import '../xelauikit/xela_text_style.dart';
import '../xelauikit/xela_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: XelaColor.Gray4,
        title: const Text(
          'Cobra Kind',
          style: TextStyle(color: XelaColor.Yellow),
        ),
        titleTextStyle: XelaTextStyle.XelaSubheadline,
      ),
      body: Column(
        children: [
          // TextField(
          //   controller: _email,
          //   enableSuggestions: false,
          //   autocorrect: false,
          //   keyboardType: TextInputType.emailAddress,
          //   decoration: const InputDecoration(
          //     hintText: 'Enter your email here',
          //   ),
          // ),
          XelaTextField(
            textEditingController: _email,
            placeholder: "User Name",
            background: Colors.white,
            borderDefaultColor: XelaColor.Gray12,
            placeholderColor: XelaColor.Gray8,
            textfieldColor: XelaColor.Gray2,
            borderFocusColor: XelaColor.Gray12,
            defaultHelperTextColor: XelaColor.Gray8,
          ),
          XelaTextField(
            textEditingController: _password,
            placeholder: "Password",
            background: Colors.white,
            borderDefaultColor: XelaColor.Gray12,
            placeholderColor: XelaColor.Gray8,
            textfieldColor: XelaColor.Gray2,
            borderFocusColor: XelaColor.Gray12,
            defaultHelperTextColor: XelaColor.Gray8,
            secureField: true,
          ),
          // TextField(
          //   controller: _password,
          //   obscureText: true,
          //   enableSuggestions: false,
          //   autocorrect: false,
          //   decoration: const InputDecoration(
          //     hintText: 'Enter your password',
          //   ),
          // ),
          // TextButton(
          //   onPressed: () async {
          //     final email = _email.text;
          //     final password = _password.text;
          //     final navigator = Navigator.of(context);
          //     try {
          //       await AuthService.firebase().logIn(
          //         email: email,
          //         password: password,
          //       );
          //       final user = AuthService.firebase().currentUser;
          //       if (user?.isEmailVerified ?? false) {
          //         navigator.pushNamedAndRemoveUntil(
          //           notesRoute,
          //           (route) => false,
          //         );
          //       } else {
          //         navigator.pushNamedAndRemoveUntil(
          //           verifyEmailRoute,
          //           (route) => false,
          //         );
          //       }
          //     } on UserNotFoundAuthException {
          //       await showErrorDialog(
          //         context,
          //         "User not found",
          //       );
          //     } on WrongPaswordAuthException {
          //       await showErrorDialog(
          //         context,
          //         "Wrong Password",
          //       );
          //     } on GenericAuthException {
          //       await showErrorDialog(
          //         context,
          //         "Authenication Error:",
          //       );
          //     }
          //   },
          //   child: const Text('Login'),
          // ),
          // XelaDivider(
          //   style: XelaDividerStyle.SOLID,
          //   orientation: XelaDividerOrientation.HORIZONTAL,
          //   color: XelaColor.Gray12,
          // ),
          XelaButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              final navigator = Navigator.of(context);
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  navigator.pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  navigator.pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "User not found",
                );
              } on WrongPaswordAuthException {
                await showErrorDialog(
                  context,
                  "Wrong Password",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Authenication Error:",
                );
              }
            },
            // leftIcon: const Icon(Icons.bookmark, size: 10, color: Colors.white),
            text: "Login",
            size: XelaButtonSize.MEDIUM,
            background: XelaColor.Gray12,
            type: XelaButtonType.SECONDARY,
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            autoResize: false,
            borderLineWidth: 0,
          ),
          XelaButton(
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            // leftIcon: const Icon(Icons.bookmark, size: 10, color: Colors.white),
            text: "Not registered yet? Register here!",
            size: XelaButtonSize.SMALL,
            background: XelaColor.Gray12,
            type: XelaButtonType.SECONDARY,
            foregroundColor: XelaColor.Gray9,
            autoResize: false,
            borderLineWidth: 0,
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamedAndRemoveUntil(
          //       registerRoute,
          //       (route) => false,
          //     );
          //   },
          //   child: const Text('Not Registered Yet? Register here!'),
          // ),
        ],
      ),
    );
  }
}
