import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontSize: 30.0,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/institutes.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'This app is a collaborative project of CATH Herbarium, Department of Botany, Catholicate College, Pathanamthitta, Kerala, India and R&D, Government Engineering College Barton Hill, Thiruvananthapuram, Kerala, India.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor,
                height: 30,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Designed and Developed by R & D GECB \n\n Find Us at:',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 20.0, height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        launch('mailto:randdgecb@gmail.com');
                      },
                      icon: Icon(Icons.mail_rounded),
                      color: Theme.of(context).accentColor,
                      iconSize: 40.0,
                    ),
                    IconButton(
                      onPressed: () {
                        launch('http://www.gecbh.ac.in/');
                      },
                      icon: Icon(Icons.public_sharp),
                      color: Theme.of(context).accentColor,
                      iconSize: 40.0,
                    ),
                    IconButton(
                      onPressed: () {
                        launch('https://www.linkedin.com/company/r-d-gecbh');
                      },
                      icon: Image.asset('assets/linkedin.png'),
                      iconSize: 35.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
