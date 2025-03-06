import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/app/custom_app_bar.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/feature/auth/cubit/get_all_users_cubit.dart';
import 'package:ptgram/feature/auth/cubit/get_user_profile_cubit.dart';
import 'package:ptgram/feature/auth/model/user_all_model.dart';
import 'package:ptgram/feature/auth/model/user_model.dart';
import 'package:ptgram/feature/message/ui/widget/chat_screen.dart';

class MessagePageWidget extends StatefulWidget {
  const MessagePageWidget({super.key});

  @override
  State<MessagePageWidget> createState() => _MessagePageWidgetState();
}

class _MessagePageWidgetState extends State<MessagePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chat Screen",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetAllUserCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonLoading) {
                  return CircularProgressIndicator();
                } else if (state is CommonNoData) {
                  return Text("No Data Found");
                } else if (state is CommonDataFetchSuccess<User>) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // leading: const CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //       'https://via.placeholder.com/150'),
                          // ),
                          leading: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          title: InkWell(
                            onTap: () {
                              NavigationService.push(
                                target: ChatScreen(user: state.data[index]),
                              );
                            },
                            child: Text(
                              state.data[index].username,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            'Last message here...',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: const Text(
                            '2:30 PM',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
    );
  }
}
