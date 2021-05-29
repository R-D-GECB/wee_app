import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/note_modal.dart';

class NotesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Notes',
            style: TextStyle(
              fontSize: 30.0,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: NoteField());
  }
}

class NoteField extends StatelessWidget {
  const NoteField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !Provider.of<NotesModel>(context).isReady
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: TextField(
              controller: TextEditingController.fromValue(TextEditingValue(
                  text:
                      Provider.of<NotesModel>(context, listen: false).content)),
              onChanged: (value) {
                Provider.of<NotesModel>(context, listen: false).content = value;
              },
              decoration: InputDecoration(border: InputBorder.none),
              scrollPhysics: BouncingScrollPhysics(),
              maxLines: null,
              minLines: 20,
              cursorColor: Theme.of(context).accentColor,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 20,
              ),
            ),
          );
  }
}
