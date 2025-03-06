import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ptgram/common/core/data_state.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/feature/home/cubit/post_content_cubit.dart';

class AddPostWidget extends StatefulWidget {
  const AddPostWidget({super.key});

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _selectedImage;
  void sendReport() {
    if (_formKey.currentState!.validate()) {
      print("Description: ${_descriptionController.text}");
      print("Photo: ${_selectedImage?.path}");

      context.read<PostContentCubit>().postContent(
            description: _descriptionController.text,
            photo: _selectedImage,
          );
    }
  }

  // Function to pick image or video
  Future<void> _pickImageOrVideo() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostContentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess) {
          // CustomToast.success(message: "Report Send Sucessfully");
          Fluttertoast.showToast(
              msg: "Post Upload SucessFully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          NavigationService.pop();
        } else if (state is CommonError) {
          CommonError(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text(
              'Create Post',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              TextButton(
                onPressed: sendReport,
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Profile Picture
                      // const CircleAvatar(
                      //   radius: 24,
                      //   backgroundImage: NetworkImage(
                      //     'https://via.placeholder.com/150',
                      //   ), // Replace with user profile image
                      // ),
                      const SizedBox(width: 10),

                      // Text Input Field
                      Expanded(
                        child: TextFormField(
                          controller: _descriptionController,
                          maxLines: 5,
                          minLines: 1,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Media Preview with smooth animation
                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_selectedImage!.path),
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                const Spacer(),

                // Add Photo/Video Options with a modern look
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPostOption(
                        icon: Icons.photo_library,
                        label: "Photo/Video",
                        color: Colors.green,
                        onTap: _pickImageOrVideo,
                      ),
                      _buildPostOption(
                        icon: Icons.tag_faces,
                        label: "Feeling/Activity",
                        color: Colors.orange,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget for Post Options (Photo, Feeling, etc.)
  Widget _buildPostOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 6),
          Text(label,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
