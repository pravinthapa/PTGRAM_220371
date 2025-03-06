import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:ptgram/common/app/theme.dart';

class PrimaryTextField extends HookWidget {
  final String? hintTxt;
  final String? initialValue;
  final String? keyName;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLine;
  final String? label;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? innerIcon;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool? isReadOnly;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final bool enableBorder;
  final Color? fillColor;
  final TextEditingController? controller;
  final double? labelHeight;
  final bool enable;
  final EdgeInsets? contentPadding;
  final Function()? ontap;

  const PrimaryTextField({
    this.enable = true,
    this.innerIcon,
    this.label,
    this.maxLine,
    this.validator,
    this.initialValue,
    this.borderRadius,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.hintTxt,
    this.keyName,
    this.controller,
    this.fillColor,
    this.labelHeight,
    this.enableBorder = false,
    this.isReadOnly,
    this.isPassword = false,
    this.textInputType,
    this.maxLength,
    this.ontap,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(prefixIcon),
                  ),
                Text(
                  label!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        if (label != null)
          SizedBox(
            height: labelHeight ?? 10,
          ),
        Container(
          alignment: Alignment.centerLeft,
          child: FormBuilderTextField(
            onTap: ontap,
            controller: controller,
            enabled: enable,
            key: fieldKey,
            initialValue: initialValue,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isPasswordVisible.value,
            style: Theme.of(context).textTheme.bodyLarge,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              prefixIcon: innerIcon,
              fillColor: fillColor,
              isDense: true,
              errorText: errorText,
              counterText: "",
              errorMaxLines: 2,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              hintText: hintTxt ?? "",
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color.fromRGBO(108, 117, 125, 1)),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10.0)),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10.0)),
                borderSide: BorderSide(
                  color: enableBorder
                      ? Theme.of(context).shadowColor
                      : Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10.0)),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(191, 191, 191, 1)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 5.0)),
                borderSide: BorderSide(
                  color: enableBorder
                      ? Theme.of(context).shadowColor
                      : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 5.0)),
                borderSide: BorderSide(
                    color: enableBorder
                        ? Theme.of(context).shadowColor
                        : Colors.transparent),
              ),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(
                          isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ))
                  : Container(
                      padding: const EdgeInsets.all(15),
                      child: suffixIcon ?? const Text(''),
                    ),
            ),
            maxLines: maxLine ?? 1,
            maxLength: maxLength,
            validator: validator,
            name: keyName ?? "null",
          ),
        ),
      ],
    );
  }
}

class SecondaryTextField extends HookWidget {
  final String? hintTxt;
  final String? initialValue;
  final String? keyName;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLine;
  final String? label;
  final String? errorText;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool? isReadOnly;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final bool enableBorder;
  final Color? fillColor;
  final TextEditingController? controller;
  final double? labelHeight;
  final bool isPassword;
  final double verticalPadding;
  final double horizontalPadding;

  // final Function onSaved;

  const SecondaryTextField({
    required this.onSaved,
    this.label,
    this.validator,
    this.initialValue,
    this.borderRadius,
    this.errorText,
    this.isPassword = false,
    this.prefixIcon,
    this.maxLine,
    this.suffixIcon,
    this.hintTxt,
    this.keyName,
    this.controller,
    this.fillColor,
    this.labelHeight,
    this.enableBorder = false,
    this.isReadOnly,
    this.textInputType,
    this.maxLength,
    this.fieldKey,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: prefixIcon,
                ),
              Text(
                '$label',
              ),
            ],
          ),
        SizedBox(
          height: labelHeight,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: FormBuilderTextField(
            controller: controller,
            key: fieldKey,
            initialValue: initialValue,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isPasswordVisible.value,
            style: Theme.of(context).textTheme.headlineSmall,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor ?? Colors.white,
              errorText: errorText,
              counterText: "",
              errorMaxLines: 2,
              contentPadding: EdgeInsets.symmetric(
                  vertical: verticalPadding, horizontal: horizontalPadding),
              // labelText:
              hintText: hintTxt ?? "",
              // hintStyle:Theme.of(context).textTheme.bodyText1 ,
              // "Email or Phone",
              // labelStyle: AppTextStyle.textboxtext,
              filled: true,
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green.withOpacity(0.5)),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ))
                  : Container(
                      padding: const EdgeInsets.all(15),
                      child: suffixIcon ?? const Text('')),
            ),
            onSaved: onSaved,
            maxLength: maxLength,
            maxLines: maxLine ?? 1,
            validator: validator,
            name: keyName ?? "null",
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    required this.label,
    this.validator,
    this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isInVisible = true;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: isInVisible,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        label: Text(widget.label),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomTheme.primaryColor,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isInVisible = !isInVisible;
            });
          },
          icon: Icon(
            isInVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: CustomTheme.darkGrey,
          ),
        ),
      ),
    );
  }
}

class PrimaryDropDownField extends HookWidget {
  final String hintTxt;
  final String? initialValue;
  final List<DropdownMenuItem<String>> items;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?> onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  final String label;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final IconData? prefixIcon;
  final double? borderRadius;
  final double? labelHeight;

  // final Function onSaved;

  const PrimaryDropDownField(
      {required this.items,
      required this.label,
      this.validator,
      this.initialValue,
      required this.onSaved,
      required this.onChanged,
      this.borderRadius,
      this.prefixIcon,
      required this.hintTxt,
      this.labelHeight,
      this.textInputType,
      this.maxLength,
      this.fieldKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  prefixIcon,
                ),
              ),
            Text(
              label,
            ),
          ],
        ),
        SizedBox(
          height: labelHeight ?? 10,
        ),
        FormBuilderDropdown<String>(
          key: fieldKey,
          initialValue: initialValue,
          style: Theme.of(context).textTheme.bodyLarge,
          name: '',
          isExpanded: true,
          decoration: InputDecoration(
              hintText: hintTxt,
              hintStyle: Theme.of(context).textTheme.bodyMedium),
          // allowClear: false,
          onSaved: onSaved,
          isDense: true,
          onChanged: onChanged,
          validator: validator,
          items: items,
        ),
      ],
    );
  }
}

class SecondaryDropDownField extends HookWidget {
  final String hintTxt;
  final String? initialValue;
  final List<DropdownMenuItem<String>> items;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?> onChanged;
  final TextInputType? textInputType;
  final int? maxLength;
  final String? label;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final IconData? prefixIcon;
  final double? borderRadius;
  final double? labelHeight;

  // final Function onSaved;

  const SecondaryDropDownField(
      {required this.items,
      this.label,
      this.validator,
      this.initialValue,
      required this.onSaved,
      required this.onChanged,
      this.borderRadius,
      this.prefixIcon,
      required this.hintTxt,
      this.labelHeight,
      this.textInputType,
      this.maxLength,
      this.fieldKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  prefixIcon,
                ),
              ),
            if (label != null)
              Text(
                label!,
              ),
          ],
        ),
        SizedBox(
          height: labelHeight ?? 10,
        ),
        Container(
          // alignment: Alignment.centerLeft,
          child: FormBuilderDropdown<String>(
            key: fieldKey,
            initialValue: initialValue,
            style: Theme.of(context).textTheme.bodyLarge,
            name: '',
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: hintTxt,
            ),
            // initialValue: 'Male',
            // allowClear: false,

            onSaved: onSaved,
            isDense: true,
            onChanged: onChanged,
            validator: validator,
            items: items,
          ),
        ),
      ],
    );
  }
}

// class SlideToVerifyField extends StatelessWidget {
//   final String? hintTxt;
//   final FormFieldSetter<String> onSaved;
//   final FormFieldValidator<String>? validator;
//   final bool? isPassword;
//   final TextInputType? textInputType;
//   final int? maxLength;
//   final String? label;
//   final Function? onSuffixTap;
//
//   // final Function onSaved;
//
//   const SlideToVerifyField(
//       {required this.onSaved,
//         this.validator,
//         this.hintTxt,
//         this.label,
//         this.isPassword,
//         this.textInputType,
//         this.onSuffixTap,
//         this.maxLength});
//
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, config) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           if (label != null)
//             Text(
//               '$label',
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           if (label != null) SizedBox(height: 20,),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: FormBuilderTextField(
//               keyboardType: textInputType ?? TextInputType.text,
//               obscureText: isPassword ?? false,
//               style: Theme.of(context).textTheme.bodyText1,
//               decoration: InputDecoration(
//                   counterText: "",
//                   errorMaxLines: 2,
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 15.0, horizontal: 10.0),
//                   // labelText:
//                   hintText: hintTxt ?? "",
//                   hintStyle: Theme.of(context).textTheme.bodyText2,
//                   // "Email or Phone",
//                   // labelStyle: AppTextStyle.textboxtext,
//                   filled: true,
//                   errorBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//                     // borderSide: BorderSide(color: AppColors.secondaryColor(1)),
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     borderSide: BorderSide(
//                       color: Color(0xffececec),
//                     ),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     borderSide: BorderSide(color: Color(0xffECECEC)),
//                   ),
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: GestureDetector(
//                       onTap: onSuffixTap!=null?onSuffixTap:null,
//                       child: Text(
//                         'Resend',
//                         style: themeData.textTheme.bodyText2.apply(
//                           color: AppColors.colorBlack(0.4),
//                         ),
//                       ),
//                     ),
//                   )),
//               onSaved: onSaved,
//               maxLength: maxLength,
//               validator: validator,
//               name: "null",
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
