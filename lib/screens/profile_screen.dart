import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size whole = MediaQuery.of(context).size;
    double width = whole.width;
    double height = whole.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0,
      ),
      body: Container(
        height: height / 3.8,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: height / 6,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
            Positioned(
              top: height / 30,
              child: InkWell(
                child: Container(
                  width: width / 3.5,
                  height: height / 3.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    "assets/img/jdi_login.png",
                  ),
                ),
              ),
            ),
            Positioned(
              top: height / 7,
              right: width / 50,
              child: Container(
                padding: EdgeInsets.all(width / 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: InkWell(
                  child: Icon(Icons.settings),
                  onTap: () => {},
                ),
              ),
            ),
            Positioned(
              top: height / 7,
              left: width / 50,
              child: Container(
                padding: EdgeInsets.all(width / 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: InkWell(
                  child: Icon(Icons.transit_enterexit),
                  onTap: () => {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
