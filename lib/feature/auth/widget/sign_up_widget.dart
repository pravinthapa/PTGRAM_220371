import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ptgram/common/app/theme.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/common/widget/custom_icons_button.dart';
import 'package:ptgram/common/widget/text_field.dart';
import 'package:ptgram/feature/auth/cubit/sign_up_cubit.dart';
import 'package:ptgram/feature/auth/page/login_page.dart';

class SignUpWidgetPage extends StatefulWidget {
  const SignUpWidgetPage({super.key});

  @override
  State<SignUpWidgetPage> createState() => _SignUpWidgetPageState();
}

class _SignUpWidgetPageState extends State<SignUpWidgetPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  signup() async {
    if (_formKey.currentState!.validate()) {
      // FocusScope.of(context).unfocus();
      context.read<SignUpCubit>().signUp(
            password: passwordController.text,
            username: firstController.text,
            email: emailController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess) {
          Fluttertoast.showToast(
              msg: "Sign Up SucessFully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          NavigationService.pop();
        }
        if (state is CommonError) {
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // CustomToast.error(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        // color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    // GestureDetector(
                    //   onTap: _pickImage,
                    //   child: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage: _profileImage != null
                    //         ? FileImage(_profileImage!)
                    //         : AssetImage('assets/images/placeholder.png')
                    //             as ImageProvider,
                    //     child: _profileImage == null
                    //         ? const Icon(
                    //             Icons.camera_alt,
                    //             size: 50,
                    //             color: Colors.grey,
                    //           )
                    //         : null,
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    PrimaryTextField(
                      textInputType: TextInputType.text,
                      hintTxt: "User Name",
                      controller: firstController,
                      // validator: (value) {
                      //   return FormValidator.validateFieldNotEmpty(
                      //       value, "Name");
                      // },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      textInputType: TextInputType.text,
                      controller: emailController,
                      hintTxt: "Enter Your Email",
                      // validator: (value) {
                      //   return FormValidator.validateFieldNotEmpty(
                      //       value, "Password");
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      textInputType: TextInputType.text,
                      hintTxt: "Password",
                      controller: passwordController,
                      // validator: (value) {
                      //   return FormValidator.validateFieldNotEmpty(
                      //       value, "Confoirm Password");
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryButton(
                      height: 55,
                      radius: 5,
                      onPressed: signup,
                      title: "SignUp",
                      widget: state is CommonLoading
                          ? const CustomCupertinoIndicator()
                          : null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        NavigationService.push(target: const LoginPage());
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don’t have an account?',
                              style: TextStyle(
                                color: Color.fromRGBO(115, 115, 115, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: CustomTheme.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TextHeading extends StatelessWidget {
  const _TextHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Registration",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(36, 96, 185, 1),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hello user, you have a grateful journey",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(108, 105, 105, 1),
      ),
    );
  }
}
