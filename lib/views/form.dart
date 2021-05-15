import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddView extends StatefulWidget {
  const AddView({Key key}) : super(key: key);
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  Map<String, String> data = {};
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
              'Add entry',
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
                          onPressed: () {},
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
                            if (_formKey.currentState.validate())
                              Navigator.pop(context, data);
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
                          icon: Icon(Icons.add),
                          label: Text('Add'),
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomField(label: 'Organization', data: data),
          CustomField(
            data: data,
            label: 'Locality & Pincode',
            maxSize: 20,
          ),
          GestureDetector(
            onTap: () async {
              DateTime date = DateTime.now();
              ThemeData theme = Theme.of(context);
              date = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: date.subtract(Duration(days: 3650)),
                  lastDate: date.add(Duration(days: 3650)),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark().copyWith(
                          primary: theme.accentColor,
                        ),
                      ),
                      child: child,
                    );
                  });
              setState(() {
                dateController.value = TextEditingValue(
                    text: '${date.day}/${date.month}/${date.year}');
              });
            },
            child: Container(
              child: CustomField(
                data: data,
                controller: dateController,
                enabled: false,
                label: 'Date',
                maxSize: 10,
              ),
            ),
          ),
          CustomField(
            data: data,
            label: 'Scientific Name & Author',
            maxSize: 50,
          ),
          CustomField(
            data: data,
            label: 'Family',
            maxSize: 20,
          ),
          CustomField(
            data: data,
            label: 'Notes \n\n',
            emptyAllowed: true,
            maxSize: 100,
            maxLines: 10,
          ),
          CustomField(
            data: data,
            label: 'Collected By',
            maxSize: 20,
          ),
          CustomField(
            data: data,
            label: 'Scientific Name with Citations',
            maxSize: 50,
          ),
          CustomField(
            data: data,
            label: 'Description \n\n',
            emptyAllowed: true,
            maxSize: 100,
            maxLines: 10,
          ),
          CustomField(label: 'Distribution ', data: data),
          CustomField(label: 'Flowering & Fruiting', data: data),
          CustomField(
            data: data,
            label: 'URL for Reference \n\n',
            emptyAllowed: true,
            maxSize: 100,
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final String label;
  final int maxSize;
  final bool emptyAllowed;
  final int maxLines;
  final bool enabled;
  final Map<String, String> data;
  final TextEditingController controller;
  CustomField({
    Key key,
    @required this.label,
    @required this.data,
    this.controller,
    this.maxSize = 30,
    this.emptyAllowed = false,
    this.maxLines = 1,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        onChanged: (value) {
          data[label] = value;
        },
        controller: controller ??
            TextEditingController.fromValue(
                TextEditingValue(text: data[label] ?? '')),
        enabled: enabled,
        maxLength: maxSize,
        style: TextStyle(color: Theme.of(context).primaryColorLight),
        cursorColor: Theme.of(context).primaryColorLight,
        maxLines: maxLines,
        minLines: maxLines > 1 ? 3 : 1,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        validator: (String value) {
          if (value.isEmpty && !emptyAllowed) {
            return "Can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.black38)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Theme.of(context).errorColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 3)),
          labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
          counterStyle: TextStyle(color: Theme.of(context).primaryColorLight),
          errorStyle: TextStyle(color: Theme.of(context).errorColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
