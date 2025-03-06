import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/common/app/env.dart';
import 'package:prabin/feature/auth/cubit/get_all_users_cubit.dart';
import 'package:prabin/feature/auth/cubit/get_user_profile_cubit.dart';
import 'package:prabin/feature/auth/cubit/login_cubit.dart';
import 'package:prabin/feature/auth/cubit/sign_up_cubit.dart';
import 'package:prabin/feature/auth/resources/auth_repo.dart';
import 'package:prabin/feature/home/cubit/post_content_cubit.dart';
import 'package:prabin/feature/home/cubit/send_like_cubit.dart';
import 'package:prabin/feature/home/repository/real_repository.dart';
import 'package:prabin/feature/onboarding/onboard_cubit.dart';


class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiBlocWrapper({super.key, required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => LoginCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context))),
        ),
        BlocProvider(
          create: ((context) => SignUpCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context))),
        ),
        BlocProvider(
          create: (context) => GetUserProfileCubit(
            authRepository: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(
            create: (context) => PostContentCubit(
                realsRepository:
                    RepositoryProvider.of<RealsRepository>(context))),
        BlocProvider(
            create: (context) => SendLikeCubit(
                realsRepository:
                    RepositoryProvider.of<RealsRepository>(context))),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
            create: (context) =>
                GetAllUserCubit(authRepository: RepositoryProvider.of(context)))
      ],
      child: child,
    );
  }
}
