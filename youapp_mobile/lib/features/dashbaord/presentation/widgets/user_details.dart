import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:youapptest/core/models/option_item.model.dart';
import 'package:youapptest/data/gender_select_options.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';
import 'package:youapptest/utility/shared_store.dart';
import 'package:youapptest/utility/zodiac_horoscope_util.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final controller = Get.find<UserController>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _horoscopeNameController =
      TextEditingController();
  final TextEditingController _zodiacNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool updateBio = false;
  OptionItem? selectedOption;
  DateTime? birthday;

  final List<OptionItem> options = genderOptions;

  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      final base64String = base64Encode(bytes);
      setState(() {
        _image = imageFile;
        controller.user.value.image = base64String;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initDefaultValue();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void updateProfileDetails() {
    if (updateBio) {
      _saveAndUpdate();
    } else {
      _initDefaultValue();
    }
    setState(() {
      updateBio = !updateBio;
    });
  }

  void _initDefaultValue() {
    if (controller.user.value.displayName != null) {
      _displayNameController.value = TextEditingValue(
        text: controller.user.value.displayName!,
      );
    }

    if (controller.user.value.gender != null) {
      selectedOption = options.firstWhere(
        (value) => value.id == controller.user.value.gender,
      );
    }

    if (controller.user.value.horoscope != null) {
      _horoscopeNameController.value = TextEditingValue(
        text: controller.user.value.horoscope!,
      );
    }

    if (controller.user.value.zodiac != null) {
      _zodiacNameController.value = TextEditingValue(
        text: controller.user.value.zodiac!,
      );
    }

    if (controller.user.value.birthDay != null) {
      birthday = controller.user.value.birthDay;
    }

    if (controller.user.value.weight != null) {
      _weightController.value = TextEditingValue(
        text: controller.user.value.weight!,
      );
    }
    if (controller.user.value.height != null) {
      _heightController.value = TextEditingValue(
        text: controller.user.value.height!,
      );
    }
  }

  void _onTextChanged(TextEditingController controller, String suffix) {
    String text = controller.text;
    if (text.isEmpty) return;

    if (text.endsWith(suffix)) {
      text = text.substring(0, text.length - suffix.length);
    }

    controller.value = TextEditingValue(
      text: '$text$suffix',
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _saveAndUpdate() {
    controller.user.value.displayName = _displayNameController.text;
    controller.user.value.gender = selectedOption?.id;
    controller.user.value.horoscope = _horoscopeNameController.text;
    controller.user.value.zodiac = _zodiacNameController.text;
    controller.user.value.height = _heightController.text;
    controller.user.value.weight = _weightController.text;
    controller.user.value.birthDay = birthday;

    _displayNameController.clear();
    _weightController.clear();
    _heightController.clear();
    setState(() {
      selectedOption = null;
      birthday = null;
    });
    controller.user.refresh();
    String user = jsonEncode(controller.user.toJson());
    SharedStorage.saveData('user', user);
  }

  Widget displayNameInput(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Display Name:", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: width * 0.6,
            child: TextField(
              controller: _displayNameController,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white10,
                filled: true,
                hint: Text('Enter name', style: TextStyle(color: Colors.white)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _horoscopeNameController.value = TextEditingValue(
        text: ZodiacHoroscopeUtility.getHoroscope(picked),
      );
      _zodiacNameController.value = TextEditingValue(
        text: ZodiacHoroscopeUtility.getZodiacSign(picked) ?? 'Unknown',
      );
      setState(() {
        birthday = picked;
      });
    }
  }

  Widget birthDaySelection(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Birthday:", style: TextStyle(color: Colors.white)),
          GestureDetector(
            onTap: () => _pickDate(context),
            child: Container(
              width: width * 0.6,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      birthday == null
                          ? 'DD MM YYYY'
                          : DateFormat('dd MM yyyy').format(birthday!),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget horoscopeInput(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Horoscope:", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: width * 0.6,
            child: TextField(
              controller: _horoscopeNameController,
              enabled: false,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white10,
                filled: true,
                hint: Text('Enter name', style: TextStyle(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget zodiacInput(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Zodiac:", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: width * 0.6,
            child: TextField(
              controller: _zodiacNameController,
              enabled: false,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white10,
                filled: true,
                hint: Text('Enter name', style: TextStyle(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget genderSelection(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Gender:", style: TextStyle(color: Colors.white)),
          Container(
            width: width * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<OptionItem>(
                dropdownColor: Color(0xFF162329),
                value: selectedOption,
                isExpanded: true,
                alignment: AlignmentDirectional.centerEnd,
                style: TextStyle(color: Colors.white),
                hint: Text(
                  'Select an option',
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Color(0xFF162329),
                  ),
                ),
                selectedItemBuilder: (BuildContext context) {
                  return options.map((OptionItem item) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Text(item.label),
                    );
                  }).toList();
                },
                items: options.map((OptionItem option) {
                  return DropdownMenuItem<OptionItem>(
                    value: option,
                    child: Text(option.label),
                  );
                }).toList(),
                onChanged: (OptionItem? newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget heightInput(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Height:", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: width * 0.6,
            child: TextField(
              controller: _heightController,
              onChanged: (val) => _onTextChanged(_heightController, 'cm'),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white10,
                filled: true,
                hint: Text('Add Height', style: TextStyle(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget weightInput(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Weight:", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: width * 0.6,
            child: TextField(
              controller: _weightController,
              onChanged: (val) => _onTextChanged(_weightController, 'kg'),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white10,
                filled: true,
                hint: Text('Add Weight', style: TextStyle(color: Colors.white)),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showBioOrTagline(double width) {
    var hasBioInfo =
        controller.user.value.birthDay != null ||
        controller.user.value.horoscope != null ||
        controller.user.value.zodiac != null ||
        controller.user.value.height != null ||
        controller.user.value.weight != null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: !hasBioInfo
          ? Text(
              'Add in your bio to help others know you better',
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'Birthday: ',
                        style: TextStyle(color: Colors.white54),
                      ),
                      controller.user.value.birthDay != null
                          ? Text(
                              DateFormat(
                                'dd / MM / yyyy',
                              ).format(controller.user.value.birthDay!),
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'Horoscope: ',
                        style: TextStyle(color: Colors.white54),
                      ),
                      controller.user.value.horoscope != null
                          ? Text(
                              controller.user.value.horoscope!,
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text('Zodiac: ', style: TextStyle(color: Colors.white54)),
                      controller.user.value.zodiac != null
                          ? Text(
                              controller.user.value.zodiac!,
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text('Height: ', style: TextStyle(color: Colors.white54)),
                      controller.user.value.height != null
                          ? Text(
                              controller.user.value.height!,
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text('Weight: ', style: TextStyle(color: Colors.white54)),
                      controller.user.value.weight != null
                          ? Text(
                              controller.user.value.weight!,
                              style: TextStyle(color: Colors.white),
                            )
                          : Text('', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: updateProfileDetails,
                      child: updateBio
                          ? Text(
                              'Save & Update',
                              style: TextStyle(color: Color(0xFFD5BE88)),
                            )
                          : Icon(
                              Icons.edit_square,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  ],
                ),
              ),
              !updateBio
                  ? showBioOrTagline(width)
                  : SizedBox(
                      width: width * 0.9,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _image != null
                                      ? Image.file(
                                          _image!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add_a_photo,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add Image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // displayName
                          displayNameInput(width),

                          // Gender
                          genderSelection(width),

                          // Birthday
                          birthDaySelection(width),

                          // Horoscope
                          horoscopeInput(width),

                          // Zodiac
                          zodiacInput(width),

                          // Height
                          heightInput(width),

                          // width
                          weightInput(width),
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
