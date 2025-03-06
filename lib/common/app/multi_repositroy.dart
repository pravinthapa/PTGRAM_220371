import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/common/app/env.dart';
import 'package:prabin/common/app/internet_checker.dart';
import 'package:prabin/common/core/api_provider.dart';
import 'package:prabin/feature/auth/resources/auth_repo.dart';
import 'package:prabin/feature/home/repository/real_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryWrapper(
      {super.key, required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
          lazy: true,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(
            baseUrl: RepositoryProvider.of<Env>(context).baseUrl,
          ),
          lazy: true,
        ),
        // login
        RepositoryProvider(
          create: ((context) => AuthRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: RepositoryProvider.of<Env>(context),
              )),
        ),

        RepositoryProvider(
          create: (context) => RealsRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            env: env,
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
