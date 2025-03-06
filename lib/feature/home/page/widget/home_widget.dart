import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/app/custom_app_bar.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/feature/add_post/ui/page/add_post.dart';
import 'package:ptgram/feature/auth/cubit/get_all_users_cubit.dart';
import 'package:ptgram/feature/auth/model/user_all_model.dart';
import 'package:ptgram/feature/auth/model/user_model.dart';
import 'package:ptgram/feature/home/cubit/get_reals_cubit.dart';
import 'package:ptgram/feature/home/cubit/send_like_cubit.dart';
import 'package:ptgram/feature/home/model/reals_model.dart';
import 'package:ptgram/feature/message/ui/page/message_page.dart';
import 'package:video_player/video_player.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'PTgram',
        centerMiddle: false,
        appElevation: 0,
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
            ),
            onPressed: () {
              NavigationService.push(target: MessagePage());
            },
          ),
        ],
      ),
      body: BlocBuilder<GetRealsCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommonNoData) {
            return Text("No data Found");
          } else if (state is CommonDataFetchSuccess<Post>) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 11),
                              child: Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey, width: 3),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        NavigationService.push(
                                            target: AddPost());
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Your Story',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.blue,
                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(
                                      state.data[index].photo ?? "",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                BlocBuilder<GetAllUserCubit, CommonState>(
                                  builder: (context, state) {
                                    if (state is CommonDataFetchSuccess<User>) {
                                      return Text(state.data[index].username);
                                    }
                                    return SizedBox();
                                  },
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: BlocBuilder<GetRealsCubit, CommonState>(
                      builder: (context, state) {
                        if (state is CommonLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CommonNoData) {
                          return const Center(child: Text('No Data Found'));
                        } else if (state is CommonDataFetchSuccess<Post>) {
                          return ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return PostCard(post: state.data[index]);
                            },
                          );
                        }
                        return const Center(
                            child: Text('Something went wrong!'));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.post.video != null && widget.post.video!.isNotEmpty) {
      _videoController = VideoPlayerController.network(widget.post.video!)
        ..initialize().then((_) {
          setState(() {}); // Refresh to show video
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  bool showComments = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Section

          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.photo ?? ''),
            ),
            title: BlocBuilder<GetAllUserCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CommonDataFetchSuccess<User>) {
                  List<User> users = state.data.cast<User>();

                  // Find user by userId
                  User matchedUser = users.firstWhere(
                    (user) => user.id == widget.post.userId,
                    orElse: () => User(
                      id: '',
                      username: 'Unknown User',
                      email: '',
                      password: '',
                      friends: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  return UserNameWidget(userId: matchedUser.username);
                } else {
                  return Text(
                    'Unknown User', // Default case
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            subtitle: Text(widget.post.createdAt.timeZoneName ?? ''),
          ),

          // Post Image
          if (widget.post.photo != null && widget.post.photo!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.post.photo!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            )
          else if (widget.post.video != null && widget.post.video!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _videoController != null &&
                      _videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_videoController!),
                          IconButton(
                            icon: Icon(
                              _videoController!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 50,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoController!.value.isPlaying
                                    ? _videoController!.pause()
                                    : _videoController!.play();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),

          // Post Description
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.post.description ?? '',
              style: const TextStyle(fontSize: 14),
            ),
          ),

          // Like & Comment Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like Button
                BlocConsumer<SendLikeCubit, CommonState>(
                  listener: (context, state) {
                    if (state is CommonStateSuccess) {
                      print("Like sent successfully");
                    } else if (state is CommonError) {
                      print("Error: ${state.message}");
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: state is CommonStateSuccess
                                ? Colors.blue
                                : Colors.black,
                          ),
                          onPressed: () {
                            context
                                .read<SendLikeCubit>()
                                .sendLike(id: widget.post.id);
                          },
                        ),
                        Text("${widget.post.likes.length}"),
                      ],
                    );
                  },
                ),

                // Comment Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment_outlined),
                      onPressed: () {
                        setState(() {
                          showComments = !showComments;
                        });
                      },
                    ),
                    const Text("Comment"),
                  ],
                ),
              ],
            ),
          ),

          // Comments Section (Shows when 'showComments' is true)
          if (showComments)
            Column(
              children: [
                // Comment Input Field
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            // widget.post.comments.add(_commentController.text);
                            _commentController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // Display Comments
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.post.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(
                        widget.post.comments[index].text,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          userId,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.verified,
          color: Colors.green,
          size: 16,
        )
      ],
    );
  }
}
