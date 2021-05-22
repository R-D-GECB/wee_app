import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/default_model.dart';
import 'package:wee_app/generator.dart';

class ProcessingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map> values = ModalRoute.of(context).settings.arguments;
    generate(values, Provider.of<DefaultsModel>(context, listen: false).label)
        .then((value) => Future.delayed(
            Duration(milliseconds: 1500),
            () => Navigator.of(context)
                .pushReplacementNamed('/preview', arguments: value)));
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
      body: Center(
        child: Lottie.asset('assets/loading.json'),
      ),
    );
  }
}
