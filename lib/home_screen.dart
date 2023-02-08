import 'package:edu_point/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: RichText(
            text: const TextSpan(
                text: "Edu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Cairo-Regular'),
                children: [
              TextSpan(
                  text: ' Point',
                  style: TextStyle(
                      color: Color.fromRGBO(130, 133, 168, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Cairo-Regular'))
            ])),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Jiffy([
                  DateTime.now().year.toInt(),
                  DateTime.now().month.toInt(),
                  DateTime.now().day.toInt()
                ]).format("EEEE MMMM do yyyy"),
                style: const TextStyle(
                    color: Color.fromRGBO(130, 133, 168, 1),
                    fontFamily: 'Cairo-Regular'),
              ),
              const Text("", style: TextStyle(fontSize: 5)),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.circle, size: 40),
            padding: const EdgeInsets.fromLTRB(0, 10, 25, 10),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: "",
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.info, color: Colors.white),
              icon: Icon(Icons.info_outline, color: Colors.white),
              label: ""),
          NavigationDestination(
              selectedIcon: Icon(Icons.settings, color: Colors.white),
              icon: Icon(Icons.settings_outlined, color: Colors.white),
              label: ""),
        ],
      ),
      body: <Widget>[
        DashboardPage(),
        InfoPage(),
        SettingsPage()
      ][currentPageIndex],
    );
  }
}

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  var pageName = 'Dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Dashboard",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 25)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LessonResources()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color.fromARGB(255, 168, 175, 255),
                    minimumSize: const Size(double.infinity, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: const Text('Lessons & Resources',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35))),
            const Text("", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentAid()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  minimumSize: const Size(double.infinity, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Student Aid',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Community()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  minimumSize: const Size(double.infinity, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Community',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentAttendance()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  minimumSize: const Size(double.infinity, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Student Attendance',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AttendanceReport()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Attendance Report',
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

class LessonResources extends StatelessWidget {
  const LessonResources({super.key});
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
            const Text("Lessons & Resources",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width / 2 - 20,
                            MediaQuery.of(context).size.height / 2 - 170),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Pre-Class',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35))),
                const Text("  ", style: TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width / 2 - 20,
                            MediaQuery.of(context).size.height / 2 - 170),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Lesson Plan',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35)))
              ],
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width / 2 - 20,
                            MediaQuery.of(context).size.height / 2 - 170),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Quizzes',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35))),
                const Text("  ", style: TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width / 2 - 20,
                            MediaQuery.of(context).size.height / 2 - 170),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Reference Book',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35)))
              ],
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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

class StudentAid extends StatelessWidget {
  const StudentAid({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Student Aid"),
    );
  }
}

class Community extends StatelessWidget {
  const Community({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Community"),
    );
  }
}

class StudentAttendance extends StatelessWidget {
  const StudentAttendance({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Student Attendance",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EnglishAttendance()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('English',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MathAttendance()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Math',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScienceAttendance()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Science',
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
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20, 50),
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

class EnglishAttendance extends StatelessWidget {
  const EnglishAttendance({super.key});
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
            const Text("English Attendance",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Manual Attendance',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Student List',
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
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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

class MathAttendance extends StatelessWidget {
  const MathAttendance({super.key});
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
            const Text("Math Attendance",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Manual Attendance',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Student List',
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
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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

class ScienceAttendance extends StatelessWidget {
  const ScienceAttendance({super.key});
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
            const Text("Science Attendance",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Manual Attendance',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Staatliches',
                      fontSize: 35)),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Student List',
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
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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

class AttendanceReport extends StatelessWidget {
  const AttendanceReport({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Attendance Report"),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});
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
                color: Color.fromARGB(100, 98, 107, 182),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.width / 2,
                  ),
                  const Text("Jeffery Bezoz",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Cairo-Regular',
                          fontWeight: FontWeight.w400)),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                          text: "Location: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: 'North Sumatra',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                          text: "Education: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: 'Degree in Education',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                          text: "Experience: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: '5 Years',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                          text: "Subject: ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: 'English',
                                style: TextStyle(
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
                  const Text(
                    'Licensed School Teacher with 5 years of experience managing classrooms of 20 - 30 students. Adept at using positive reinforcement teaching techniques to encourage student learning and growth.',
                    style: TextStyle(
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
                Future<void> _signOut() async {
                  await FirebaseAuth.instance.signOut();
                }

                _signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: Color.fromARGB(255, 168, 175, 255),
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

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Info"),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Settings"),
    );
  }
}
