import 'package:complex_ui/home_page.dart';
import 'package:complex_ui/profile_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    @required this.animationControllerValue,
    @required this.setCurrentPage,
    @required this.toggleDrawer,
  });

  final double animationControllerValue;
  final Function setCurrentPage;
  final Function toggleDrawer;

  int get alpha {
    return animationControllerValue > 0.3
        ? (255 * (animationControllerValue - 0.3) * 10 / 7).round()
        : 0;
  }

  Widget buildTile(String title, IconData icon, Function onSelect) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white.withAlpha(alpha),
            ),
            SizedBox(width: 25),
            Text(
              title,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white.withAlpha(alpha),
                fontSize: 18,
                fontFamily: 'ComicNue',
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
      onTap: onSelect,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(0, 80, 255, 1),
      padding: EdgeInsets.only(
        left: 30,
        top: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello,",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white.withAlpha(alpha),
              fontSize: 30,
              fontFamily: 'ComicNue',
              letterSpacing: 2,
            ),
          ),
          Text(
            "Pranav",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white.withAlpha(alpha),
              fontSize: 40,
              fontFamily: 'ComicNue',
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Column(
            children: [
              buildTile("Home", Icons.home,
                  () => setCurrentPage(HomePage(toggleDrawer))),
              buildTile(
                  "Profile",
                  Icons.person,
                  () => setCurrentPage(ProfilePage(
                        toggleDrawer: toggleDrawer,
                      ))),
              buildTile("News", Icons.new_releases, () => print("News")),
              buildTile("Favorites", Icons.favorite, () => print("Favorites")),
              buildTile("Maps", Icons.map, () => print("Maps")),
              buildTile("Settings", Icons.settings, () => print("Settings")),
            ],
          ),
        ],
      ),
    );
  }
}
