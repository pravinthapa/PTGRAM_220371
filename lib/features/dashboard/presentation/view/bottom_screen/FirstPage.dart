import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PTgram",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message_rounded))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(width: 10),
                _buildAvatarWithBorder("assets/images/upama.jpg", "Pravin"),
                SizedBox(width: 10),
                _buildAvatarWithBorder("assets/images/pra7.jpg", "Thapa1"),
                SizedBox(width: 10),
                _buildAvatarWithBorder("assets/images/vin.jpg", "Prabat"),
                SizedBox(width: 10),
                _buildAvatarWithBorder("assets/images/ronaldo.jpg", "Ravin_1"),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/upama.jpg"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              ("Pravin_7"),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            // CircleAvatar(),
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.menu),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Image.asset(
                "assets/images/upama.jpg",
                fit: BoxFit.cover,
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(width: 15),
                    Icon(Icons.message),
                    SizedBox(width: 15),
                    Icon(Icons.send),
                    Spacer(),
                    Icon(Icons.bookmark)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAvatarWithBorder(String imagePath, String name) {
    return Column(
      children: [
        Container(
          width: 80, // Slightly larger than the CircleAvatar's diameter
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey, // Gray border color
              width: 2.0, // Border thickness
            ),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        Text(name),
      ],
    );
  }
}