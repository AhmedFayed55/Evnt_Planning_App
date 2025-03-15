import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/ui/auth/register/register_screen.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .03),
          child: Column(
            spacing: height * .02,
            children: [
              SizedBox(
                height: height * .02,
              ),
              Image.asset(AppImages.logo),
              CustomTextField(
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(Icons.email)),
              CustomTextField(
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
                  text: AppLocalizations.of(context)!.login,
                  onTap: () {
                    // todo : navigate to home screen
                  }),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: AppLocalizations.of(context)!.dont_have_account,
                    style: AppStyles.medium16Black),
                TextSpan(
                    text: AppLocalizations.of(context)!.create_account,
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primaryLight),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // todo: navigate to register screen
                        Navigator.pushNamed(context, RegisterScreen.routeName);
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
                  onTap: () {
                    // todo: authentication with google
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
