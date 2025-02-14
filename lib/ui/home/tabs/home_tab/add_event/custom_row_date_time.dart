import 'package:flutter/material.dart';

import '../../../../../utils/app_styles.dart';

class CustomRowDateTime extends StatelessWidget {
  Icon icon;
  String text;
  String textButton;
  Function? chooseDateOrTime;
  TextStyle? textButtonStyle;

  CustomRowDateTime(
      {required this.icon,
      required this.text,
      required this.textButton,
      this.chooseDateOrTime,
      this.textButtonStyle});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        icon,
        SizedBox(
          width: width * .03,
        ),
        Text(
          text,
          style: AppStyles.medium16Black,
        ),
        Spacer(),
        TextButton(
            onPressed: chooseDateOrTime != null
                ? () {
                    chooseDateOrTime!();
                  }
                : null,
            child: Text(
              textButton,
              style: textButtonStyle ?? AppStyles.medium16Primary,
            )),
      ],
    );
  }
}
