import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/feature/auth/cubit/get_all_users_cubit.dart';
import 'package:ptgram/feature/home/cubit/get_reals_cubit.dart';
import 'package:ptgram/feature/home/page/widget/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const HomeWidget();
    // return BlocProvider(
    //   create: (context) =>
    //       GetRealsCubit(realsRepository: RepositoryProvider.of(context))
    //         ..getReals(),
    //   child: const HomeWidget(),
    // );
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            GetRealsCubit(realsRepository: RepositoryProvider.of(context))
              ..getReals(),
      ),
      BlocProvider(
          create: (context) =>
              GetAllUserCubit(authRepository: RepositoryProvider.of(context))
                ..getAllUser()),
    ], child: HomeWidget());
  }
}
