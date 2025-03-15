import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/ui/auth/login/login_screen.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "Register_Screen";

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
          child: Column(
            spacing: height * .02,
            children: [
              Image.asset(AppImages.logo),
              SizedBox(
                height: height * .005,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Icon(Icons.person),
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(Icons.email_rounded),
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.lock),
                sufixIcon: Icon(Icons.hide_source_sharp),
              ),
              CustomTextField(
                  hintText: AppLocalizations.of(context)!.re_password,
                  prefixIcon: Icon(Icons.lock),
                  sufixIcon: Icon(Icons.hide_source_sharp)),
              CustomElevatedButton(
                  textStyle: AppStyles.medium20White,
                  text: AppLocalizations.of(context)!.create_account,
                  onTap: () {
                    // todo: show toast and navigate to home screen
                  }),
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
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      })
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
