import 'package:edu_point/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:developer';
import 'package:path/path.dart' as Path;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future logout() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false));
  }

  String? userID = FirebaseAuth.instance.currentUser?.uid;
  final ImagePicker picker = ImagePicker();

  String name = '';
  String location = '';
  String education = '';
  String experience = '';
  String subject = '';
  String about = '';
  String profilepicURL =
      'https://firebasestorage.googleapis.com/v0/b/edupoint-8e35b.appspot.com/o/files%2FProfile%2F0c3b3adb1a7530892e55ef36d3be6cb8.jpg?alt=media&token=79c4d9d4-0799-4740-b005-4642c626a467';
  File? photo;
  var profileURL = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        uploadPhoto();
      } else {
        log('No image selected.');
      }
    });
  }

  Future uploadPhoto() async {
    if (photo == null) return;
    final fileName = Path.basename(photo!.path);
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

    uploadProfileToDB();
  }

  Future uploadProfileToDB() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users/$userID");
    await ref.update({
      "profile_picture": profilepicURL,
    });
  }

  getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/$userID').get();
    if (snapshot.exists) {
      setState(() {
        name = snapshot.child('name').value.toString();
        location = snapshot.child('location').value.toString();
        education = snapshot.child('education').value.toString();
        experience = snapshot.child('experience').value.toString();
        subject = snapshot.child('subject').value.toString();
        about = snapshot.child('about').value.toString();
        profilepicURL = snapshot.child('profile_picture').value.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Profile",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(100, 98, 107, 182),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      onPressed: () {
                        getFromGallery();
                      },
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
                  Text(name.toString(),
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Cairo-Regular',
                          fontWeight: FontWeight.w400)),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Location: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: location.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Education: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: education.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Experience: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: experience.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Subject: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: subject.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 1)),
                  const Text(
                    "About",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Cairo-Regular',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    about.toString(),
                    style: const TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Cairo-Regular',
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  const Text("", style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 25, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 25, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Back',
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
