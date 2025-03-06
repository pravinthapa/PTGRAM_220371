import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ptgram/common/app/theme.dart';
import 'package:ptgram/common/widget/button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final Widget? centerWidget;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? tabBackgroundColor;
  final String? title;
  final bool showBottomBorder;
  final Function()? onBackPressed;
  final bool showBackButton;
  final bool centerMiddle;
  final double? leftPadding;
  final double? rightPadding;
  final double topPadding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? titleStyle;
  final double? appElevation;
  const CustomAppBar(
      {Key? key,
      this.centerWidget,
      this.leadingIcon,
      this.bottom,
      this.backgroundColor,
      this.tabBackgroundColor,
      this.title,
      this.actions = const [],
      this.showBottomBorder = true,
      this.onBackPressed,
      this.centerMiddle = true,
      this.showBackButton = true,
      this.leftPadding,
      this.rightPadding,
      this.topPadding = 10,
      this.borderRadius,
      this.titleStyle,
      this.appElevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    bool canPop = Navigator.of(context).canPop();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.secondary,
          // statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Material(
          borderRadius: borderRadius,
          elevation: appElevation ?? 0.1,
          shadowColor: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                    left: leftPadding ?? CustomTheme.symmetricHozPadding,
                    right: rightPadding ?? CustomTheme.symmetricHozPadding,
                    top: MediaQuery.of(context).padding.top + topPadding,
                  ),
                  decoration: BoxDecoration(
                    color: CustomTheme.white,
                    borderRadius: borderRadius,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 50),
                    child: NavigationToolbar(
                      leading: leadingIcon != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [leadingIcon!],
                            )
                          : ((showBackButton && canPop)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomIconButton(
                                      icon: Icons.arrow_back_ios_new_rounded,
                                      iconColor: CustomTheme.black,
                                      // backgroundColor: CustomTheme.black,
                                      hasBorderOutline: false,
                                      onPressed: onBackPressed ??
                                          () {
                                            Navigator.of(context).maybePop();
                                          },
                                      shadow: false,
                                    ),
                                  ],
                                )
                              : null),
                      middle: title != null
                          ? Text(
                              title!,
                              style: titleStyle ??
                                  textTheme.headlineMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: CustomTheme.black,
                                  ),
                            )
                          : centerWidget,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions,
                      ),
                      centerMiddle: centerMiddle,
                      middleSpacing: NavigationToolbar.kMiddleSpacing,
                    ),
                  ),
                ),
              ),
              if (bottom != null)
                Container(
                  color: tabBackgroundColor,
                  child: bottom!,
                )
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}
