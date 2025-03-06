import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/common/widget/custom_icons_button.dart';
import 'package:ptgram/common/widget/custom_scaffold.dart';
import 'package:ptgram/common/widget/text_field.dart';
import 'package:ptgram/feature/auth/cubit/login_cubit.dart';
import 'package:ptgram/feature/auth/cubit/sign_up_cubit.dart';
import 'package:ptgram/feature/auth/page/sign_up_page.dart';
import 'package:ptgram/feature/dashboard/page/dashboard_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberPassword = true;
  TextEditingController emailController = TextEditingController();

  login() async {
    if (_formKey.currentState!.validate()) {
      // FocusScope.of(context).unfocus();
      context.read<LoginCubit>().login(
            password: passwordController.text,
            email: emailController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, CommonState>(
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
          NavigationService.push(target: DashboardPage());
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
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'PtGram',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              // color: lightColorScheme.primary,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          PrimaryTextField(
                            hintTxt: "Enter Your Email",
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          PrimaryTextField(
                            hintTxt: "Enter Your Password",
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          PrimaryButton(
                            height: 55,
                            radius: 8,
                            onPressed: login,
                            title: "Submit",
                            widget: state is CommonLoading
                                ? const CustomCupertinoIndicator()
                                : null,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
                                      });
                                    },
                                    // activeColor: lightColorScheme.primary,
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // color: lightColorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // const SizedBox(
                          //   height: 25.0,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //       child: Divider(
                          //         thickness: 0.7,
                          //         color: Colors.grey.withOpacity(0.5),
                          //       ),
                          //     ),
                          //     const Padding(
                          //       padding: EdgeInsets.symmetric(
                          //         vertical: 0,
                          //         horizontal: 10,
                          //       ),
                          //       child: Text(
                          //         'Sign up with',
                          //         style: TextStyle(
                          //           color: Colors.black45,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Divider(
                          //         thickness: 0.7,
                          //         color: Colors.grey.withOpacity(0.5),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 25.0,
                          // ),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Text('Facebook'),
                          //     Text('Twitter'),
                          //     Text('Google'),
                          //     Text('Apple'),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          // don't have an account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (e) => const SignUpPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,

                                    // color: lightColorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
