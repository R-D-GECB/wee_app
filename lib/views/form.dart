import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/note_modal.dart';

class FormView extends StatefulWidget {
  final Map data;
  final bool editMode;
  const FormView({Key key, this.data, this.editMode = false}) : super(key: key);
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  Map data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    if (widget.editMode) {
      dateController.value = TextEditingValue(text: widget.data['Date']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onDoubleTap: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => FractionallySizedBox(
                  heightFactor: 0.7,
                  child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).accentColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SelectableText(
                              Provider.of<NotesModel>(context, listen: false)
                                  .content,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                  ),
                )),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                widget.editMode ? 'Edit' : 'Add',
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
                              Navigator.pop(context);
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
                            icon: Icon(widget.editMode
                                ? Icons.save_rounded
                                : Icons.add),
                            label: Text(widget.editMode ? "Save" : "Add"),
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
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomField(label: 'Organization', data: data, maxSize: 50),
          CustomField(
            data: data,
            label: 'Locality & Pincode',
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
                if (date != null) {
                  String d = date.month < 10
                      ? '${date.day}/0${date.month}/${date.year}'
                      : '${date.day}/${date.month}/${date.year}';
                  dateController.value = TextEditingValue(text: d);
                  data['Date'] = d;
                }
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
            label: 'Collection Number',
            data: data,
            maxSize: 20,
          ),
          CustomField(
            data: data,
            label: 'Scientific Name',
            maxSize: 50,
          ),
          CustomField(label: 'Author citation', data: data, emptyAllowed: true),
          CustomField(
              label: 'Infraspecific category', data: data, emptyAllowed: true),
          CustomField(label: 'Epithet', data: data, emptyAllowed: true),
          CustomField(label: 'Author', data: data),
          CustomField(
            data: data,
            label: 'Family',
            maxSize: 30,
          ),
          CustomField(
            data: data,
            label: 'Notes \n\n',
            emptyAllowed: true,
            maxSize: 300,
            maxLines: 20,
          ),
          CustomField(
            data: data,
            label: 'Collected By',
            maxSize: 30,
          ),
          CustomField(label: 'Locality', data: data),
          CustomField(
            label: 'Coordinates',
            data: data,
            emptyAllowed: true,
          ),
          CustomField(
            data: data,
            label: 'Description \n\n',
            emptyAllowed: true,
            maxSize: 300,
            maxLines: 20,
          ),
          CustomField(label: 'Distribution ', data: data, emptyAllowed: true),
          CustomField(
            label: 'Flowering & Fruiting',
            data: data,
            emptyAllowed: true,
          ),
          CustomField(
            data: data,
            label: 'URL for Reference \n\n',
            emptyAllowed: true,
            maxSize: 200,
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
  final Map data;
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
