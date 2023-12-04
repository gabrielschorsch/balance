import 'dart:io';

import 'package:app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? image;

  ImageProvider get userImage {
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      return NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!);
    } else if (image != null) {
      return FileImage(File(image!.path));
    } else {
      return const NetworkImage(
          "https://static.vecteezy.com/system/resources/previews/020/911/740/original/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(children: [
          Text(
            "Perfil",
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          const SizedBox(height: 20),
          //Picture
          Stack(children: [
            CircleAvatar(radius: 100, backgroundImage: userImage),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        openCamera(context);
                      })),
            ),
          ]),
          Form(
            child: Column(
              children: [
                TextFormField(
                  initialValue: FirebaseAuth.instance.currentUser!.displayName,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: FirebaseAuth.instance.currentUser!.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  openCamera(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Escolha uma opção"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Galeria"),
                    onTap: () async {
                      XFile selectedImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      ) as XFile;
                      await context
                          .read<AuthController>()
                          .updateProfilePicture(File(selectedImage.path));
                      setState(() {});
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () async {
                      XFile photo = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      ) as XFile;

                      await context
                          .read<AuthController>()
                          .updateProfilePicture(File(photo.path));
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
