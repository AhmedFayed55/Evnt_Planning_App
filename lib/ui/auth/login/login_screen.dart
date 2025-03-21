import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/firebase/firebase_utils.dart';
import 'package:evnt_planning_app/providers/user_provider.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_routes.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/dialoug_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: "ahmed@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .03),
          child: Form(
            key: formKey,
            child: Column(
              spacing: height * .02,
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Image.asset(AppImages.logo),
                CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter an email."; // invalid
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Please enter a valid email";
                      }
                      return null; // valid
                    },
                    hintText: AppLocalizations.of(context)!.email,
                    prefixIcon: Icon(Icons.email)),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter a password."; // invalid
                    }
                    if (text.length < 6) {
                      return "password must be at least 6 characters";
                    }
                    return null; // valid
                  },
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.lock),
                  sufixIcon: Icon(Icons.hide_source_sharp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: AppColors.primaryLight),
                      ),
                    )
                  ],
                ),
                CustomElevatedButton(
                    text: AppLocalizations.of(context)!.login, onTap: login),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.dont_have_account,
                      style: AppStyles.medium16Black),
                  TextSpan(
                      text: AppLocalizations.of(context)!.create_account,
                      style: TextStyle(
                          fontSize: 16, color: AppColors.primaryLight),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // todo: navigate to register screen
                          Navigator.pushNamed(
                              context, AppRoutes.registerScreenRoute);
                        }),
                ])),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .085),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        thickness: 2,
                        endIndent: 20,
                        color: AppColors.primaryLight,
                      )),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: AppStyles.medium16Primary,
                      ),
                      const Expanded(
                          child: Divider(
                              thickness: 2,
                              indent: 20,
                              color: AppColors.primaryLight)),
                    ],
                  ),
                ),
                CustomElevatedButton(
                    backgroundColor: AppColors.transparentColor,
                    prefixIconButton: Image.asset(AppImages.googleLogo),
                    text: AppLocalizations.of(context)!.login_with_google,
                    onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //todo: show loading
      DialogueUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? "");
        if (user == null) {
          // user doesn't there in firestore => احتمال ضئيل يكون اتسجل في الauth بس حصل مشكلة في النت وملحقش يوصل فايرستور
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        //todo: hide loading
        DialogueUtils.hideLoading(context);
        //todo: show msg
        DialogueUtils.showMessage(
            context: context,
            message: "Login Successfully",
            title: "Success",
            posActionName: "OK",
            posAction: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.mainScreenRoute);
            });
        print("Login Successfully");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message: 'No user found for that email.',
              title: "Fail",
              posActionName: "OK");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message: 'Wrong password provided for that user.',
              title: "Fail",
              posActionName: "OK");
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message:
                  'The supplied auth credential is incorrect, malformed or has expired.',
              title: "Fail",
              posActionName: "OK");
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        } else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message:
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
              title: "Fail",
              posActionName: "OK");
          print(
              'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
        }
      } catch (e) {
        //todo: hide loading
        DialogueUtils.hideLoading(context);
        //todo: show msg
        DialogueUtils.showMessage(context: context, message: e.toString());
        print(e.toString());
      }
    }
  }
}
