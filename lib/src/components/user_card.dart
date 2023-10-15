import 'package:flutter/material.dart';

import 'avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;
  const UserCard({
    Key? key,
    required this.userId,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6,),
      width: 150,
      height: 220,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.black12)),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0,
            right: 15,
            bottom: 0,
            child: Container(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  AvatarWidget(
                    type: AvatarType.TYPE2,
                    thumbPath: "https://cdn.pixabay.com/photo/2023/09/06/18/10/dandelion-8237710_1280.jpg",
                    size: 80,
                  ),
                  Text(userId, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(description, style: const TextStyle(fontSize: 12,), textAlign: TextAlign.center,),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: const Text("Follow", style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap:() {
                
              },
              child: const Icon(Icons.close, size: 14, color: Colors.grey,)
            ),
          ),
        ],
      ),
    );
  }
}