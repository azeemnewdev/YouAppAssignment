import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';

class UserInterests extends StatefulWidget {
  const UserInterests({super.key});

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  final controller = Get.find<UserController>();
  late final List<String> _tags = controller.user.value.interests!;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Obx(() {
      return Container(
        width: width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF162329),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interests',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/interests'),
                    child: Icon(Icons.edit_square, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:
                    (controller.user.value.interests == null ||
                        controller.user.value.interests!.isEmpty)
                    ? Text(
                        'Add in your interests to find a better match',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    : Wrap(
                        spacing: 4,
                        runSpacing: 0,
                        children: [
                          ..._tags.map(
                            (tag) => Chip(
                              backgroundColor: Colors.blueGrey[700],
                              side: BorderSide(width: 0),
                              label: Text(
                                tag,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
