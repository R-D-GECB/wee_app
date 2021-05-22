import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/default_model.dart';
import 'package:wee_app/views/form.dart';

class DefaultView extends StatefulWidget {
  const DefaultView({Key key}) : super(key: key);

  @override
  _DefaultViewState createState() => _DefaultViewState();
}

class _DefaultViewState extends State<DefaultView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(
              'Default',
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                letterSpacing: 2.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 15.0,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  _buildForm(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).accentColor),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.red),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 3))),
                          icon: Icon(Icons.close),
                          label: Text('Cancel'),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Provider.of<DefaultsModel>(context, listen: false)
                                .data = data;
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).accentColor),
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).backgroundColor),
                              overlayColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColorLight),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(8, 8, 20, 8))),
                          icon: Icon(Icons.save),
                          label: Text('Save'),
                        )
                      ],
                    ),
                  )
                ],
              )),
            )
          ]))
        ],
      ),
    );
  }

  Form _buildForm() {
    data = Map.from(Provider.of<DefaultsModel>(context, listen: false).data);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomField(
            label: 'Organization',
            data: data,
            emptyAllowed: true,
          ),
          CustomField(
              label: 'Locality & Pincode', data: data, emptyAllowed: true),
          CustomField(
              data: data, label: 'Family', maxSize: 30, emptyAllowed: true),
          CustomField(
              data: data,
              label: 'Collected By',
              maxSize: 30,
              emptyAllowed: true),
          LabelSwitch()
        ],
      ),
    );
  }
}

class LabelSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Color Label: ',
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 16),
        ),
        Switch(
            value: Provider.of<DefaultsModel>(context).label,
            onChanged: (b) {
              Provider.of<DefaultsModel>(context, listen: false).labelNeeded =
                  b;
            }),
      ],
    );
  }
}
