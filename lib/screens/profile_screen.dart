import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks/core/theme/theme_controller.dart';
import 'package:tasks/core/widgets/custom_svg_picture.dart';
import 'package:tasks/screens/user_details.dart';
import 'package:tasks/screens/welcome.dart';

import '../core/services/preference_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? quote;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadQuote();
    _loadUserImage();
  }

  void _loadUsername() async {
    setState(() {
      name = PreferenceManager().getString('username');
    });
  }

  void _loadQuote() async {
    setState(() {
      quote = PreferenceManager().getString('quotename');
    });
  }

  void _loadUserImage() async {
    setState(() {
      userImage = PreferenceManager().getString('userImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile"), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: userImage == null
                            ? AssetImage('assets/images/Leading element.png')
                            : FileImage(File(userImage!)),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      GestureDetector(
                        onTap: () async {
                          _showImageSourceDialog(context, (XFile file) {
                            _saveImage(file);
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          child: const Icon(CupertinoIcons.photo_camera),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$name',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 20),
                  ),
                  Text(
                    quote ?? "one task at time ,one step closer",
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Profile Info',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UserDetails(userName: name ?? "", quote: quote),
                  ),
                );
                if (result == true) {
                  _loadUsername();
                  _loadQuote();
                  _loadUserImage();
                }
              },
              leading: CustomSvgPicture(path: 'assets/images/profile.svg'),
              title: Text('User Details'),
              trailing: Icon(CupertinoIcons.arrow_right),
              contentPadding: EdgeInsets.all(0),
            ),
            Divider(thickness: 1),

            ListTile(
              leading: Icon(CupertinoIcons.moon),
              title: Text('Dark Mode'),
              trailing: ValueListenableBuilder(
                valueListenable: ThemeController.themeNotifier,
                builder: (BuildContext context, value, Widget? child) {
                  return CupertinoSwitch(
                    value:
                        ThemeController.themeNotifier.value == ThemeMode.dark,
                    onChanged: (bool value) async {
                      ThemeController.toggleTheme();
                    },
                  );
                },
              ),
              contentPadding: EdgeInsets.all(0),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () async {
                final pref = await SharedPreferences.getInstance();
                // await PreferenceManager().remove('username');
                // await PreferenceManager().remove('quotename');
                await pref.clear();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Welcome(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              leading: CustomSvgPicture(
                path: 'assets/images/Leading element2.svg',
              ),
              title: Text('Log Out'),
              trailing: Icon(CupertinoIcons.arrow_right),
              contentPadding: EdgeInsets.all(0),
              selectedTileColor: Colors.black,

              splashColor: Color(0XFF1A1A1A),
            ),
          ],
        ),
      ),
    );
  }

  //===========================_showButtonSheet======================
  // void _showButtonSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: .5,
  //         // maxChildSize: .9,
  //         expand: false,
  //         snap: true,
  //         shouldCloseOnMinExtent: true,
  //         builder: (context, scrollController) {
  //           return ListView.builder(
  //             controller: scrollController,
  //             itemCount: 4,
  //             shrinkWrap: true,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ConstrainedBox(
  //                 constraints: BoxConstraints(
  //                   maxHeight: MediaQuery.of(context).size.height * .9,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 50,
  //                     color: Colors.redAccent,
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  //============show date and time ====================

  // void _showDateTime(BuildContext context) {
  //   showDatePicker(
  //     context: context,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now().add(Duration(days: 365*4)),
  //     initialDate: DateTime.now(),
  //   );
  //   showTimePicker(context: context, initialTime: TimeOfDay(hour: 6, minute: 0));
  // }
  void _showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Choose image from:"),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: const Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 16),
                  Text('Camera'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: const Row(
                children: [
                  Icon(Icons.photo),
                  SizedBox(width: 16),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PreferenceManager().setString('userImage', newFile.path);
    setState(() {
      userImage = newFile.path;
    });
  }
}
