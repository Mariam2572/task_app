import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_app/auth/custom_text_form_field.dart';
import 'package:task_app/auth/register/register.dart';
import 'package:task_app/dialog_utils.dart';
import 'package:task_app/home_screen/home_screen.dart';
import 'package:task_app/home_screen/list_task/add_task_bottom_sheet.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController e_mailController = TextEditingController(text: 'mariam@gmail.com');

  TextEditingController passwordController = TextEditingController(text: '123456');

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.backgroundLight,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                        CustomTextFormField(
                            label: AppLocalizations.of(context)!.e_mail,
                            keyboardType: TextInputType.emailAddress,
                            controller: e_mailController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .validate_mail;
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(e_mailController.text);
                              if (!emailValid) {
                                return AppLocalizations.of(context)!
                                    .validate_mail_text;
                              }
                              return null;
                            }),
                        CustomTextFormField(
                            label: AppLocalizations.of(context)!.password,
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .validate_password;
                              }
                              if (text.length < 6) {
                                return AppLocalizations.of(context)!
                                    .password_length;
                              }
                              return null;
                            }),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: MyTheme.whiteColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primary,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        side: BorderSide(
                          color: MyTheme.whiteColor,
                          width: 2,
                        )),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child:
                        Text(AppLocalizations.of(context)!.or_create_account,))
              ],
            ),
          ),
        )
      ],
    );
  }

  void login()async {
    if (formKey.currentState?.validate() == true) {
      try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: e_mailController.text,
    password: passwordController.text
  );
  print('login successfully');
  print(credential.user?.uid??"");
DialogUtils.showMessage(context: context, message: 'login successfully');
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}catch (e){
  print(e.toString());
}
    }
  }
}
