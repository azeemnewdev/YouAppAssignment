import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/utility/shared_store.dart';

class YouAppBar extends StatelessWidget {
  const YouAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            onTap: () async {
              await SharedStorage.clear();
              Get.offNamed('/login');
            },
            child: Icon(
              Icons.logout_rounded,
              size: 25,
              color: Color(0xFF1F4247),
            ),
          ),
        ];
      },
    );
  }
}
