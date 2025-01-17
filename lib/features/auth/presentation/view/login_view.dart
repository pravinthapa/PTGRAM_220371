import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:prabin/features/auth/presentation/view_model/login/login_event.dart';
import 'package:prabin/features/auth/presentation/view_model/login/login_state.dart';
import '../../../dashboard/presentation/view/dashboard.dart';
import '../../../auth/presentation/view/register.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginBloc(loginStudentUsecase: null),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Colors.blueAccent, Colors.purpleAccent],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
            ),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()),
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/ptgram-logo.png',
                            width: 250,
                            height: 250,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            final email = emailController.text;
                            final password = passwordController.text;

                            context.read<LoginBloc>().add(
                                  LoginSubmitted(email, password),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 5,
                          ),
                          child: state is LoginLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                        ),
                        const SizedBox(height: 20),
                        _buildGoogleSignInButton(context),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage())
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.white.withValues(alpha:0.1),
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        context.read<LoginBloc>().add(GoogleSignInRequested());
      },
      icon: const Icon(Icons.account_circle, color: Colors.red),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 5,
      ),
    );
  }
}
