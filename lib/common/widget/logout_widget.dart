import 'package:flutter/material.dart';
import 'package:ptgram/common/widget/custom_icons_button.dart';

showLogoutAlertDialog(
    {required BuildContext context, required Function() onPressed}) {
  showDialog(
      context: context,
      builder: (context) => CommonAlertDialog(
            onPressed: onPressed,
          ));
}

class CommonAlertDialog extends StatelessWidget {
  final Function() onPressed;

  const CommonAlertDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text("Logout",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold)),
      content: Text(
        "Do You want TO Logout",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            )),
        SizedBox(width: 10),
        SizedBox(
          width: 130,
          height: 34,
          child: PrimaryButton(
            title: "Yes Logout",
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            // fontSize: 12,
            // padding: EdgeInsets.zero,
          ),
        )
      ],
    );
  }
}
