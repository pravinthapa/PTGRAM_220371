// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prabin/features/splash/presentation/view_model/splash_cubit.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SplashCubit>().init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Image.asset('assets/images/splash.png'),
//                 ),
//                 const Text(
//                   'Student Course Management',
//                   style: TextStyle(
//                     fontSize: 25,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: 10),
//                 const Text('version : 1.0.0')
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: MediaQuery.of(context).size.width / 4,
//             child: const Text(
//               'Developed by: Khatra Sir le',
//               style: TextStyle(fontSize: 15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
    context.read<SplashCubit>().init(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Instagram-like logo appearance
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(
                      'assets/images/ptgram-logo.png', // Update with your logo path
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          // Footer Section
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: const Text(
              'Developed by: Prabin Thapa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
