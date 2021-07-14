import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Function toggleDrawer;

  const ProfilePage({Key key, @required this.toggleDrawer}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "WhatsApp",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(0x1D, 0x5C, 0x1B, 1),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
            SliverFillRemaining(
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "CHATS",
                      ),
                      Tab(
                        text: "STATUS",
                      ),
                      Tab(
                        text: "CALLS",
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      ListView(
                        children: [
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item x"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                          ListTile(
                            title: Text("Item 1"),
                          ),
                        ],
                      ),
                      Center(child: Text("Tab")),
                      Center(child: Text("Tab")),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
