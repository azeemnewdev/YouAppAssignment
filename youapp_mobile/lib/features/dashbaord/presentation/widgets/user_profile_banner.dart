import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/data/zodiac_options.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';
import 'package:youapptest/utility/date_util.dart';

class UserProfileBanner extends StatefulWidget {
  const UserProfileBanner({super.key});

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  final controller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Obx(() {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: controller.user.value.image == null
                  ? Image.network(
                      'https://images.pexels.com/photos/30886538/pexels-photo-30886538.jpeg?_gl=1*17l5770*_ga*MTIyMDAzNDg0MC4xNzQ4NjgzOTA2*_ga_8JE65Q40S6*czE3NTA0Mjc4ODYkbzIkZzEkdDE3NTA0Mjc5MjEkajI1JGwwJGgw',
                      width: width * 0.95,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64Decode(controller.user.value.image!),
                      width: width * 0.95,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            width: width * 0.9,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '@${controller.user.value.username}, ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.grey.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                        controller.user.value.birthDay != null
                            ? Text(
                                '${DateUtil.calculateAge(controller.user.value.birthDay!)}',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                  ],
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      controller.user.value.horoscope != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '${horoscopeIcons[controller.user.value.horoscope]} ${controller.user.value.horoscope}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(width: 1),
                      SizedBox(width: 10),
                      controller.user.value.zodiac != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '${chineseZodiacIcons[controller.user.value.zodiac]} ${controller.user.value.zodiac}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(width: 1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
