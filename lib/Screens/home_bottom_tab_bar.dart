import 'package:exd_social/Screens/Friends/random_users_list.dart';
import 'package:exd_social/Screens/chats/rooms.dart';
import 'package:exd_social/Screens/chats/users.dart';
import 'package:exd_social/Screens/global_post_screen.dart';
import 'package:exd_social/Screens/profile_screen.dart';
import 'package:exd_social/controllers/home_bottom_tab_bar_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class HomeBottomTabBar extends StatelessWidget {
  HomeBottomTabBar({Key? key}) : super(key: key);
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, homeBottomTabBarController) {
    return Obx(() =>
        MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: SizedBox(
              height: 54,
              child: BottomNavigationBar(
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: homeBottomTabBarController.changeTabIndex,
                currentIndex: homeBottomTabBarController.tabIndex.value,
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                unselectedItemColor: Colors.white.withOpacity(0.5),
                selectedItemColor: Colors.white,
                unselectedLabelStyle: unselectedLabelStyle,
                selectedLabelStyle: selectedLabelStyle,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.list_alt,
                        size: 20.0,
                      ),
                    ),
                    label: 'Home',
                    backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                    ),
                    label: 'Profile',
                    backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.request_page,
                        size: 20.0,
                      ),
                    ),
                    label: 'Friends List',
                    backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                    ),
                    label: 'Chat',
                    backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                ],
              ),
            )));
  }
  @override
  Widget build(BuildContext context) {
    final HomeBottomTabBarController homeBottomTabBarController =
    Get.put(HomeBottomTabBarController(), permanent: false);
    return Scaffold(
        appBar: AppBar(leading: Container(
          child: IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                  title: Text("Logout"),
                  children: [
                    Text(
                        "are you sure you want to logout"),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth
                              .instance
                              .signOut();
                          Navigator.of(context)
                              .pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen(),
                              ));
                        },
                        child: Text("Yes"))
                  ]),
            ),
            icon: Icon(Icons.logout),
          ),
        )),
        bottomNavigationBar: buildBottomNavigationMenu(
            context, homeBottomTabBarController),
        body: Obx(() {
          return IndexedStack(index: homeBottomTabBarController.tabIndex.value,
            children: [
              GlobalPostScreen(),
              ProfileScreen(),
              RandomUsersList(),
              RoomsPage()
            ],);
        })
    );
  }
}
