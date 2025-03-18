import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_routes.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:evnt_planning_app/utils/dialogue_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: "Ahmed");

  TextEditingController emailController =
      TextEditingController(text: "ahmed@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "123456");

  TextEditingController rePasswordController =
      TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 25, color: AppColors.black),
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.bold20Black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .03,
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: height * .02,
              children: [
                Image.asset(AppImages.logo),
                SizedBox(
                  height: height * .005,
                ),
                CustomTextField(
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter a name."; // invalid
                    }
                    return null; // valid
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Icon(Icons.person),
                ),
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
                  prefixIcon: Icon(Icons.email_rounded),
                ),
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
                  showSufixIcon: true,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.lock),
                  sufixIcon: Icon(Icons.hide_source_sharp),
                ),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please re-password."; // invalid
                      }
                      if (text.length < 6) {
                        return "password must be at least 6 characters";
                      }
                      if (text != passwordController.text) {
                        return "re-password doesn't match the password";
                      }
                      return null; // valid
                    },
                    showSufixIcon: true,
                    hintText: AppLocalizations.of(context)!.re_password,
                    prefixIcon: Icon(Icons.lock),
                    sufixIcon: Icon(Icons.hide_source_sharp)),
                CustomElevatedButton(
                    textStyle: AppStyles.medium20White,
                    text: AppLocalizations.of(context)!.create_account,
                    onTap: register),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.already_have_account,
                      style: AppStyles.medium16Black),
                  TextSpan(
                      text: AppLocalizations.of(context)!.login,
                      style: AppStyles.bold16Primary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // todo : navigate to login screen
                          Navigator.of(context)
                              .pushNamed(AppRoutes.loginScreenRoute);
                        })
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate() == true) {
      // todo: show loading
      DialogueUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading
        DialogueUtils.hideLoading(context);
        //todo: show msg
        DialogueUtils.showMessage(
            context: context,
            message: "Register Successfully",
            title: "Success",
            posActionName: "OK",
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreenRoute, (route) => false);
            });
        print("Register Successfully");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message: "The password provided is too weak.",
              title: "Error",
              posActionName: "OK");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogueUtils.hideLoading(context);
          //todo: show msg
          DialogueUtils.showMessage(
              context: context,
              message: "The account already exists for that email.",
              title: "Error",
              posActionName: "OK");
          print('The account already exists for that email.');
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
        print(e);
      }
    }
  }
}
