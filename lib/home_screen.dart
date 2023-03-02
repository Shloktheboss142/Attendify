import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'profile.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import './studentlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  String userID = FirebaseAuth.instance.currentUser!.uid;
  String ProfileURL = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/$userID').get();
    if (snapshot.exists) {
      setState(() {
        ProfileURL = snapshot.child('profile_picture').value.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                elevation: 0,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: const TextSpan(
                        text: 'A',
                        style: TextStyle(
                            color: Color.fromARGB(255, 250, 158, 159),
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat'),
                        children: [
                      TextSpan(
                          text: 'T',
                          style: TextStyle(
                              color: Color.fromARGB(255, 236, 155, 166),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'T',
                          style: TextStyle(
                              color: Color.fromARGB(255, 223, 153, 174),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'E',
                          style: TextStyle(
                              color: Color.fromARGB(255, 208, 150, 181),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'N',
                          style: TextStyle(
                              color: Color.fromARGB(255, 195, 148, 188),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'D',
                          style: TextStyle(
                              color: Color.fromARGB(255, 181, 145, 195),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'I',
                          style: TextStyle(
                              color: Color.fromARGB(255, 167, 142, 203),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'F',
                          style: TextStyle(
                              color: Color.fromARGB(255, 153, 140, 210),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                      TextSpan(
                          text: 'Y',
                          style: TextStyle(
                              color: Color.fromARGB(255, 139, 137, 217),
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat')),
                    ])),
              )
            ],
          ),
        ),
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
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(0, 98, 107, 182),
              ),
              child: Row(children: [
                Material(
                  elevation: 0,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(ProfileURL),
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                    ),
                  ),
                ),
              ]))
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
        //surfaceTintColor: Colors.pink,
        
        destinations: const <Widget>[
          NavigationDestination(
            
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: ""
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width,
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
                              builder: (context) => const LessonResources(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/LessonResources.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          //width: (MediaQuery.of(context).size.width),
                          child: const Center(
                            child: Text(
                              'Lessons & Resources',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentAid(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/StudentAid.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          child: const Center(
                            child: Text(
                              'Student Aid',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Community(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/Community.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          child: const Center(
                            child: Text(
                              'Community',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentAttendance(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/StudentAttendance.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          child: const Center(
                            child: Text(
                              'Student Attendance',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AttendanceReport(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/AttendanceReport.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          child: const Center(
                            child: Text(
                              'Attendance Report',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 500,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Lessons & Resources",
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
                              builder: (context) => const LessonPlan(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/LessonPlan.webp'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          //width: (MediaQuery.of(context).size.width),
                          child: const Center(
                            child: Text(
                              'Lesson Plan',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Text("", style: TextStyle(fontSize: 25)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReferenceBook(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(double.infinity,
                              (MediaQuery.of(context).size.height - 210) / 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/ReferenceBook2.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(0, 98, 107, 182),
                          ),
                          height:
                              (MediaQuery.of(context).size.height - 210) / 7,
                          child: const Center(
                            child: Text(
                              'Reference Book',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Staatliches',
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
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
                                MediaQuery.of(context).size.width - 250, 60),
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

class LessonPlan extends StatelessWidget {
  const LessonPlan({super.key});
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
                      Text("Lesson Plan",
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

class ReferenceBook extends StatelessWidget {
  const ReferenceBook({super.key});
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
                      Text("Reference Book",
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
                                MediaQuery.of(context).size.width - 250, 60),
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
                                MediaQuery.of(context).size.width - 250, 60),
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
                                MediaQuery.of(context).size.width - 250, 60),
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
                                MediaQuery.of(context).size.width - 250, 60),
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
                                MediaQuery.of(context).size.width - 250, 60),
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
                  color: const Color.fromARGB(100, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Community",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
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
                  MaterialPageRoute(
                      builder: (context) => const ScanQRandBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode/ QR Code',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentClasses()),
                );
              },
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
                  MaterialPageRoute(
                      builder: (context) => const ScanQRandBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode/ QR Code',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentClasses()),
                );
              },
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
                  MaterialPageRoute(
                      builder: (context) => const ScanQRandBarcode()),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 20,
                      MediaQuery.of(context).size.height / 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Scan Barcode/ QR Code',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentClasses()),
                );
              },
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

// class for Barcode and QR code scanner
class ScanQRandBarcode extends StatefulWidget {
  final VoidCallback? foundBarcode;
  const ScanQRandBarcode({Key? key, this.foundBarcode}) : super(key: key);

  @override
  State<ScanQRandBarcode> createState() => _ScanQRandBarcodeState();
}

class _ScanQRandBarcodeState extends State<ScanQRandBarcode> {
  MobileScannerController cameraController =
      MobileScannerController(); // defining mobile scanner controller
  bool _screenOpened =
      false; // to prevent from opening many screens everytime we want to scan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text("Scanner"),
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

//class for Student classes
class StudentClasses extends StatelessWidget {
  const StudentClasses({super.key});
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
            const Text("Student List",
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
                  MaterialPageRoute(builder: (context) => StudentNameListA()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                fixedSize: Size(
                  MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Class A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const Opacity(
                    opacity: 1.0,
                    child: Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentNameListB()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                fixedSize: Size(
                  MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Class B',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const Opacity(
                    opacity: 1.0,
                    child: Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentNameListC()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                fixedSize: Size(
                  MediaQuery.of(context).size.width - 10,
                  MediaQuery.of(context).size.height / 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Class C',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const Opacity(
                    opacity: 1.0,
                    child: Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentNameListD()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                fixedSize: Size(
                  MediaQuery.of(context).size.width - 20,
                  MediaQuery.of(context).size.height / 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Class D',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const Opacity(
                    opacity: 1.0,
                    child: Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
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

class StudentNameListA extends StatelessWidget {
  final List<String> studentNames = [
    'John Doe',
    'Jane Smith',
    'Bob Johnson',
    'Ali',
    'Ah Kau',
    'Abu',
    'Ryker',
    'Ryan',
    'Amanda',
    'Andy',
    'Shlok',
    'Bel',
    'Laila',
    'Ramesh',
    'Siti',
    'Amad',
    'Muthu',
    'Leo',
    'Wai Jin',
    'Peter',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text(
          'Class A Student List',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontFamily: 'Cairo-Regular',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
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
                color: const Color.fromARGB(255, 168, 175, 255),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 120,
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      studentNames[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentNameListB extends StatelessWidget {
  final List<String> studentNames = [
    'Johny Depp',
    'Peter Parker',
    'Christiano Ronaldo',
    'Billie Eilish',
    'Neymar Da Silva Santos Junior',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text(
          'Class B Student List',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontFamily: 'Cairo-Regular',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
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
                color: const Color.fromARGB(255, 168, 175, 255),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 120,
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      studentNames[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentNameListC extends StatelessWidget {
  final List<String> studentNames = [
    'Jeffry Bezoz',
    'Elon Musk',
    'Unknown',
    'Ali',
    'Ah Kau',
    'Abu',
    'Lily',
    'Ryan',
    'Suzy',
    'Andy',
    'Shlok',
    'Bel',
    'Laila',
    'Ramesh',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text(
          'Class C Student List',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontFamily: 'Cairo-Regular',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
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
                color: const Color.fromARGB(255, 168, 175, 255),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 120,
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      studentNames[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentNameListD extends StatelessWidget {
  final List<String> studentNames = [
    'John Doe',
    'Jane Smith',
    'Bob Johnson',
    'Ali',
    'Ah Kau',
    'Abu',
    'Ryker',
    'Ryan',
    'Amanda',
    'Andy',
    'Shlok',
    'Bel',
    'Laila',
    'Ramesh',
    'Siti',
    'Amad',
    'Muthu',
    'Leo',
    'Wai Jin',
    'Peter',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        title: const Text(
          'Class D Student List',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontFamily: 'Cairo-Regular',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
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
                color: const Color.fromARGB(255, 168, 175, 255),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 120,
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      studentNames[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
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
                  color: const Color.fromARGB(100, 98, 107, 182),
                ),
                width: MediaQuery.of(context).size.width - 25,
                height: MediaQuery.of(context).size.height - 610,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" Attendance Report",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w400)),
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
