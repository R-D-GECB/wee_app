import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/default_model.dart';
import 'package:wee_app/generator.dart';

class ProcessingView extends StatefulWidget {
  @override
  _ProcessingViewState createState() => _ProcessingViewState();
}

class _ProcessingViewState extends State<ProcessingView> {
  bool init = false;
  int total = 0;
  int complete = 0;
  @override
  Widget build(BuildContext context) {
    if (!init) {
      init = true;
      List<Map> values = ModalRoute.of(context).settings.arguments;
      total = values.length;
      generate(values, Provider.of<DefaultsModel>(context, listen: false).label,
          () {
        setState(() {
          complete += 1;
        });
      }).then((value) => Future.delayed(
          Duration(milliseconds: 1500),
          () => Navigator.of(context)
              .pushReplacementNamed('/preview', arguments: value)));
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: TextButton.icon(
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Theme.of(context).accentColor),
            foregroundColor:
                MaterialStateProperty.all(Theme.of(context).accentColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
          label: Text('Cancel')),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Lottie.asset('assets/loading.json'),
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                '${(complete * 100) ~/ total}%',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 30),
              ),
            ),
            LinearProgressIndicator(
              value: complete / total,
              minHeight: 10,
            ),
          ])
        ],
      ),
    );
  }
}
