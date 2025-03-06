import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/feature/auth/cubit/get_user_profile_cubit.dart';
import 'package:ptgram/feature/proifile/page/profile_page.dart';

class ProfileIndex extends StatelessWidget {
  const ProfileIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetUserProfileCubit(authRepository: RepositoryProvider.of(context))
            ..getUserProfile(),
      child: ProfilePage(),
    );
  }
}
