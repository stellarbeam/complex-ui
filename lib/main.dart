import 'package:flutter/material.dart';

import 'home_page.dart';
import 'custom_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI practice',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(0x1D, 0x5C, 0x1B, 1),
        fontFamily: "ComicNue",
      ),
      home: HomePageWithCustomDrawer(),
    );
  }
}

class HomePageWithCustomDrawer extends StatefulWidget {
  @override
  _HomePageWithCustomDrawerState createState() =>
      _HomePageWithCustomDrawerState();
}

class _HomePageWithCustomDrawerState extends State<HomePageWithCustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  int maxSlide = 240;
  bool canBeDragged;
  double minDragStartEdge;
  double maxDragStartEdge;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = HomePage(toggleDrawer);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    minDragStartEdge = MediaQuery.of(context).size.width / 2;
    maxDragStartEdge = MediaQuery.of(context).size.width / 2;
  }

  void onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    canBeDragged = isDragCloseFromRight || isDragOpenFromLeft;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() > 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      // close();
      animationController.fling(velocity: -1.0);
    } else {
      // open();
      animationController.fling(velocity: 1.0);
    }
  }

  void toggleDrawer() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  void setCurrentPage(Widget page) {
    setState(() {
      currentPage = page;
      animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (ctx, _) {
        double slide = maxSlide * animationController.value;
        double scale = 1 - 0.3 * animationController.value;
        return GestureDetector(
          child: Stack(
            children: [
              CustomDrawer(
                animationControllerValue: animationController.value,
                setCurrentPage: setCurrentPage,
                toggleDrawer: toggleDrawer,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withAlpha((animationController.value * 50).round()),
                      offset: Offset(-5, 5),
                      blurRadius: 25 * animationController.value,
                    )
                  ]),
                  child: currentPage,
                ),
              ),
            ],
          ),
          onHorizontalDragStart: onDragStart,
          onHorizontalDragUpdate: onDragUpdate,
          onHorizontalDragEnd: onDragEnd,
        );
      },
    );
  }
}
