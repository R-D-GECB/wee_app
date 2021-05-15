import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Card(
          elevation: 10,
          color: Colors.grey[600],
          child: SizedBox(
            width: 300,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 50.0),
              child: Column(
                children: [
                  Text(
                    'This APP is a collaborative project of ...... and Govt Eng College Barton Hill. Initiative taken by Dr.Binoy, Dr.Thomas and R&D GECBH. ',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
