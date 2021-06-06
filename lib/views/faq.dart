import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'FAQs',
          style: TextStyle(
            fontSize: 30.0,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: tiles,
        ),
      ),
    );
  }
}

final List<Entry> tiles = <Entry>[
  Entry('How to use Note feature?',
      'You can type or paste any text into the notes screen, which can be accessed from the main navigation drawer. Double tap anywhere on the edit or add screen to bring up the notes as a popup from which you can copy and paste into the fields.'),
  Entry(
    'What are the swiping actions ?',
    'Inorder to make the experience on application more user friendly two swiping actions are being implemented. Swipe right to archive and swipe left to delete.',
  ),
  Entry(
    'How to save most important data for future reference ?',
    'Archive option is used for archiving the data that user feels more important and needs to access frequently. Archive is interfaced in a table format which shows the date of creation, scientific name, family and collected by.',
  ),
  Entry(
    'Why the app seems to stops working while generating pdf ?',
    'The app does not stops its performance during pdf generation, it is actually working in background for the qr code to be encoded. It might take some time for the generation and varies according to the number of data to be generated.',
  ),
  Entry(
    'What is default option ?',
    'It is used to set some default values for the fields in add page and can also be altered while entering data in add page. The colour label option is used to generate the colour sequence in the pdf.',
  ),
  Entry(
    'How to generate pdf ?',
    'Select the checkbox respective to the corresponding data and a generate button will be seen in bottom of the page. You can also generate multiple data in the same time, select the required checkboxes. The checkbox in the top section is used for selecting all current data to generate pdf. A single page can generate upto 4 data.',
  ),
];

class Entry extends StatelessWidget {
  final String title;
  final String content;
  Entry(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      color: Theme.of(context).backgroundColor,
      child: ExpansionTile(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                content,
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 18),
              ))
        ],
      ),
    );
  }
}
