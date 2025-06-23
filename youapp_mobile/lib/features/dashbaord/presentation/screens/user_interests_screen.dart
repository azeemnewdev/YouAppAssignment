import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/core/components/default_background.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';
import 'package:youapptest/utility/shared_store.dart';

class UserInterestsScreen extends StatefulWidget {
  const UserInterestsScreen({super.key});

  @override
  State<UserInterestsScreen> createState() => _UserInterestsScreenState();
}

class _UserInterestsScreenState extends State<UserInterestsScreen> {
  final controller = Get.find<UserController>();

  late final List<String> _tags = controller.user.value.interests ?? [];
  final TextEditingController _controller = TextEditingController();

  void _addTag(String value) {
    if (value.trim().isEmpty || _tags.contains(value.trim())) return;
    setState(() {
      _tags.add(value.trim());
      _controller.clear();
    });
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  saveAndGoBack() {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Interests'),
          content: Text('Are you sure you want to continue?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
                controller.user.value.interests = _tags;
                controller.user.refresh();

                String user = jsonEncode(controller.user.toJson());
                SharedStorage.saveData('user', user);
                Get.offAndToNamed('/dashboard');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          DefaultBackground(isAuth: true),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text('Back', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: saveAndGoBack,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Color(0xFF4599DB)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tell everyone about yourself',
                        style: TextStyle(color: Color(0xFFD5BE88)),
                      ),
                      Text(
                        'What interests you?',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: width * 0.95,
                        decoration: BoxDecoration(color: Colors.blueGrey[800]),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 0,
                            children: [
                              ..._tags.map(
                                (tag) => Chip(
                                  backgroundColor: Colors.blueGrey[700],
                                  padding: EdgeInsets.all(4),
                                  labelPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  side: BorderSide(width: 0),
                                  label: Text(
                                    tag,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  deleteIcon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onDeleted: () => _removeTag(tag),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: TextField(
                                  controller: _controller,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                  onSubmitted: _addTag,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
