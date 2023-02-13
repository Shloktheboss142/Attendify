import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'profile.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

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
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
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
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
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
        const InfoPage(),
        const SettingsPage()
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
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 230,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dashboard",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LessonResources()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Lessons & Resources',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StudentAid()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Student Aid',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Community()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Community',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const StudentAttendance()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Student Attendance',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
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
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Attendance Report',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
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
                        backgroundColor:
                            const Color.fromARGB(255, 168, 175, 255),
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
                        backgroundColor:
                            const Color.fromARGB(255, 168, 175, 255),
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
                        backgroundColor:
                            const Color.fromARGB(255, 168, 175, 255),
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
                        backgroundColor:
                            const Color.fromARGB(255, 168, 175, 255),
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

class StudentAid extends StatelessWidget {
  const StudentAid({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 220,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Student Aid",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Healthcare()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Healthcare',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FoodNutrition()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Food & Nutrition',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Scholarships()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Scholarships',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExtraLessons()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            minimumSize: Size(double.infinity,
                                (MediaQuery.of(context).size.height - 210) / 7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: const Text('Extra English Lessons',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}

class Healthcare extends StatelessWidget {
  const Healthcare({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Healthcare",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      ElevatedButton(
                          onPressed: () {
                            const url =
                                'https://docs.google.com/forms/d/e/1FAIpQLSdJVCwBcOvV4G363oOjvxTVR3WWavHcjePuzNICX2w2WTyJMA/viewform?usp=sf_link';
                            launchUrlString(url);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Open Form',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}

class FoodNutrition extends StatelessWidget {
  const FoodNutrition({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Food & Nutrition",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      ElevatedButton(
                          onPressed: () {
                            const url =
                                'https://docs.google.com/forms/d/e/1FAIpQLSe6isL_GnO97sieozXKTS9BmgHfpAgAiXvfi-EQv5A3s8iB5g/viewform?usp=sf_link';
                            launchUrlString(url);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Open Form',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}

class Scholarships extends StatelessWidget {
  const Scholarships({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Scholarships",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      ElevatedButton(
                          onPressed: () {
                            const url =
                                'https://docs.google.com/forms/d/e/1FAIpQLSdOHKXxuJ3HgLRyfxdCfCL75Ozxy2iziUl5fHWJEmjUvZNDwA/viewform?usp=sf_link';
                            launchUrlString(url);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Open Form',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}

class ExtraLessons extends StatelessWidget {
  const ExtraLessons({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Extra English Lessons",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                      ElevatedButton(
                          onPressed: () {
                            const url =
                                'https://docs.google.com/forms/d/e/1FAIpQLSdF57ootuj51PZljRx0hjxqAvZrbndRK2uLcitSq_ZoCov8hg/viewform?usp=sf_link';
                            launchUrlString(url);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 175, 255),
                              minimumSize: Size(
                                  double.infinity,
                                  (MediaQuery.of(context).size.height - 210) /
                                      7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          child: const Text('Open Form',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Staatliches',
                                  fontSize: 35))),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromARGB(255, 168, 175, 255),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35)),
                      ),
                    ]))
          ],
        ),
      ),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 250, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan QR',
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 250, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan QR',
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 250, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan QR',
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 250, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
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

class ScanBarcode extends StatefulWidget {
  final VoidCallback? foundBarcode;
  const ScanBarcode({Key? key, this.foundBarcode}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  MobileScannerController cameraController =
      MobileScannerController(); // defining mobile scanner controller
  bool _screenOpened =
      false; // to prevent from opening many screens everytime we want to scan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text("Mobile Scanner"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () =>
                cameraController.toggleTorch(), // to enable or disable flash
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () =>
                cameraController.switchCamera(), // to switch camera sides
          ),
        ],
      ),
      body: MobileScanner(
        allowDuplicates: true, // allow to scan multiple times
        controller: cameraController,
        onDetect: _foundBarcode, // camera detecting barcode
      ),
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FoundCodeScreen(screenClosed: _screenWasClosed, value: code),
        ),
      );
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scanned Code:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
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

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 220,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Information",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                    ]))
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 220,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Settings",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
                    ]))
          ],
        ),
      ),
    );
  }
}
