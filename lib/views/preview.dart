import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';
import 'package:share/share.dart';

class PreviewView extends StatelessWidget {
  final TextEditingController _filename = TextEditingController.fromValue(
      TextEditingValue(text: 'generated_file.pdf'));
  @override
  Widget build(BuildContext context) {
    String path = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: TextField(
            controller: _filename,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight, fontSize: 20),
            cursorColor: Theme.of(context).primaryColorLight,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight)),
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                FlutterFileDialog.saveFile(
                    params: SaveFileDialogParams(
                        sourceFilePath: path, fileName: _filename.text));
              }),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.shareFiles([path]);
              }),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: PDFDocument.fromFile(File(path)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFViewer(
              document: snapshot.data,
              scrollDirection: Axis.vertical,
              showPicker: false,
              backgorundPickPage: Theme.of(context).backgroundColor,
              backgroundNavigation: Theme.of(context).backgroundColor,
              iconPickPage: Theme.of(context).backgroundColor,
              iconNavigation: Theme.of(context).primaryColorLight,
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
