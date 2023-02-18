import 'dart:io';
import 'package:edu_point/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:developer';

class ProfilePicPicker extends StatefulWidget {
  const ProfilePicPicker({super.key});

  @override
  _ProfilePicPicker createState() => _ProfilePicPicker();
}

class _ProfilePicPicker extends State<ProfilePicPicker> {
  String? imageURL;
  String profilepicURL = '';
  File? photo;
  var profileURL = '';
  final ImagePicker picker = ImagePicker();
  bool submit = false;

  Future getFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        uploadProfile();
      } else {
        log('No image selected.');
      }
    });
  }

  Future uploadProfile() async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(photo!);
      profileURL = await ref.getDownloadURL();
      setState(() {
        profilepicURL = profileURL;
      });
    } catch (e) {
      log('error occured');
    }

    String userID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users/$userID");
    await ref.update({
      "profile_picture": profilepicURL,
    });

    setState(() {
      submit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 40, 43, 78),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                onPressed: () {},
                elevation: 1,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: NetworkImage(profilepicURL),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2.5,
                )),
            const SizedBox(
              height: 80.0,
            ),
            ElevatedButton(
              onPressed: () {
                getFromGallery();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Choose Profile Picture',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: submit
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  : () => null,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Continue',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
          ],
        ),
      ),
    );
  }
}

//Confirm Password
//name
