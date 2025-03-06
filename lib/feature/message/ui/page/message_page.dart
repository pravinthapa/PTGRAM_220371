import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prabin/feature/auth/cubit/get_all_users_cubit.dart';
import 'package:prabin/feature/message/ui/widget/messgae_page_widget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetAllUserCubit(authRepository: RepositoryProvider.of(context))
            ..getAllUser(),
      child: MessagePageWidget(),
    );
  }
}
