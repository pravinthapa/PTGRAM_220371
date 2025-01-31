// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prabin/features/auth/presentation/view/register_view.dart';
// import 'package:prabin/features/auth/presentation/view_model/login/login_bloc.dart';

// class LoginView extends StatelessWidget {
//   LoginView({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController(text: 'kiran');
//   final _passwordController = TextEditingController(text: 'kiran123');

//   final _gap = const SizedBox(height: 8);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontFamily: 'Brand Bold',
//                       ),
//                     ),
//                     _gap,
//                     TextFormField(
//                       key: const ValueKey('username'),
//                       controller: _usernameController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Username',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter username';
//                         }
//                         return null;
//                       },
//                     ),
//                     _gap,
//                     TextFormField(
//                       key: const ValueKey('password'),
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                       ),
//                       validator: ((value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter password';
//                         }
//                         return null;
//                       }),
//                     ),
//                     _gap,
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           context.read<LoginBloc>().add(
//                                 LoginStudentEvent(
//                                   context: context,
//                                   username: _usernameController.text,
//                                   password: _passwordController.text,
//                                 ),
//                               );

//                           //   if (_usernameController.text == 'kiran' &&
//                           //       _passwordController.text == 'kiran123') {
//                           //     context.read<LoginBloc>().add(
//                           //           NavigateHomeScreenEvent(
//                           //             destination: HomeView(),
//                           //             context: context,
//                           //           ),
//                           //         );
//                           //   } else {
//                           //     showMySnackBar(
//                           //       context: context,
//                           //       message: 'Invalid username or password',
//                           //       color: Colors.red,
//                           //     );
//                           //   }
//                         }
//                       },
//                       child: const SizedBox(
//                         height: 50,
//                         child: Center(
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ElevatedButton(
//                       key: const ValueKey('registerButton'),
//                       onPressed: () {
//                         context.read<LoginBloc>().add(
//                               NavigateRegisterScreenEvent(
//                                 destination: RegisterView(),
//                                 context: context,
//                               ),
//                             );
//                       },
//                       child: const SizedBox(
//                         height: 50,
//                         child: Center(
//                           child: Text(
//                             'Register',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Brand Bold',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/features/auth/presentation/view/register_view.dart';
import 'package:prabin/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'Prabin');
  final _passwordController = TextEditingController(text: '123');
  final _gap = const SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Logo Section
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        'assets/images/ptgram-logo.png', // Update this path to your logo file
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome to Ptgram',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('username'),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    // Login Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, // Instagram-like button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                LoginStudentEvent(
                                  context: context,
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _gap,
                    // Register Button
                    ElevatedButton(
                      key: const ValueKey('registerButton'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, // Instagram-like button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              NavigateRegisterScreenEvent(
                                destination: RegisterView(),
                                context: context,
                              ),
                            );
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
