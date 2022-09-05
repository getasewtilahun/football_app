// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football3/Screen/League/Allleague/allleague.dart';
import '../Screen/Match/matchs.dart';

class MAinScreenpage extends StatefulWidget {
  const MAinScreenpage({Key? key}) : super(key: key);

  @override
  State<MAinScreenpage> createState() => _MAinScreenpageState();
}

class _MAinScreenpageState extends State<MAinScreenpage> {
  final PageController _pageController = PageController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey[900],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  InkWell(
                    onTap: () {
                      _pageController.jumpToPage(1);
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              height: 20.h,
                              width: 20.w,
child:const Icon(Icons.sports_football),
                          ),
                          Text(
                            "Match",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _pageController.jumpToPage(2);
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: Icon(Icons.group)
                          ),
                          Text(
                            "Teams",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: const [  Matchspage(), AllleaguePage(),
          // M3u8Page()
        ],
      ),
    );
  }
}
