import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/core/components/default_background.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';
import 'package:youapptest/features/dashbaord/presentation/widgets/user_details.dart';
import 'package:youapptest/features/dashbaord/presentation/widgets/user_interests.dart';
import 'package:youapptest/features/dashbaord/presentation/widgets/user_profile_banner.dart';
import 'package:youapptest/features/dashbaord/presentation/widgets/you_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _loadUserIfExists();
  }

  void _loadUserIfExists() async {
    controller.getProfileFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          DefaultBackground(isAuth: false),
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: height * 0.9,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                '@${controller.user.value.username}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            YouAppBar(),
                          ],
                        ),
                      ),
                      UserProfileBanner(),
                      SizedBox(height: 10),
                      UserDetails(),
                      SizedBox(height: 10),
                      UserInterests(),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
