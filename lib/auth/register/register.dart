import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/auth/custom_text_form_field.dart';
import 'package:task_app/dialog_utils.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/home_screen/home_screen.dart';
import 'package:task_app/model/my_user.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: 'Mariam');

  TextEditingController emailController =
      TextEditingController(text: 'mariam@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');
  var form = GlobalKey<FormState>();

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
              AppLocalizations.of(context)!.create_account,
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
                          label: AppLocalizations.of(context)!.user_name,
                          controller: nameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .validate_user_name;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                            label: AppLocalizations.of(context)!.e_mail,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .validate_mail;
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text);
                              if (!emailValid) {
                                return AppLocalizations.of(context)!
                                    .validate_mail_text;
                              }
                              return null;
                            }),
                        CustomTextFormField(
                            obscureText: true,
                            label: AppLocalizations.of(context)!.password,
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .validate_password;
                              }
                              if (text.length < 6) {
                                return AppLocalizations.of(context)!
                                    .password_length;
                              }
                              return null;
                            }),
                        CustomTextFormField(
                            obscureText: true,
                            label:
                                AppLocalizations.of(context)!.confirm_password,
                            controller: confirmPasswordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .validate_confirm_password;
                              }
                              if (text != passwordController.text) {
                                return AppLocalizations.of(context)!
                                    .password_match;
                              }
                              return null;
                            }),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.whiteColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primary,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(
                          color: MyTheme.whiteColor,
                          width: 2,
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context, 'Loading...');
        // todo: show loading
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            email: emailController.text);
        var authprovider = Provider.of<AuthProviders>(context, listen: false);
        authprovider.changeUser(myUser);
        await FirebaseUtils.addUsersToFireStore(myUser);
        // todo: hide loading

        DialogUtils.hideLoading(context);
        // todo: show message

        DialogUtils.showMessage(
            context: context,
            message: "Register successfully",
            posActionName: 'Ok',
            title: 'Success',
            posAction: () {

 Navigator.of(context).pushReplacement(
                MaterialPageRoute(
            builder: (context) => HomeScreen()));         
               });
        print('Register successfully');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email',
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(
          context: context,
          title: "Error",
          message: '${e.toString()}',
        );
        print(e);
      }
    }
  }
}
