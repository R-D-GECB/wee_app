import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

MemoryImage labelImage;
Future<String> generate(List<Map> values, bool label, Function callback) async {
  Document pdf = Document();
  int perPage = 4;
  callback = callback;
  int numberOfPages = values.length ~/ perPage;
  int lastPage = values.length % perPage;
  labelImage = MemoryImage(
    (await rootBundle.load('assets/wee_label.jpg')).buffer.asUint8List(),
  );
  for (var i = 0, start = 0, end = perPage; i < numberOfPages; i++) {
    pdf.addPage(await makePage(values.getRange(start, end), label, callback));
    start += perPage;
    end += perPage;
  }
  if (lastPage != 0) {
    pdf.addPage(await makePage(
        values.getRange(values.length - lastPage, values.length),
        label,
        callback));
  }

  final output = await getTemporaryDirectory();
  final String path = "${output.path}/generated_file.pdf";
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  return path;
}

Future<Page> makePage(Iterable<Map> values, bool label, callback) async {
  List valuesList = values.toList();
  List qrCodes = await makeQrcodes(valuesList, callback);
  return Page(
      theme: ThemeData(defaultTextStyle: TextStyle(font: Font.times())),
      margin: EdgeInsets.all(0),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(values.length, (index) {
              return itemBlock(valuesList[index], label, qrCodes[index]);
            }));
      });
}

Widget itemBlock(Map value, label, List qrCodes) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    mainLabelBlock(value),
    Column(children: [
      Row(children: [
        Container(
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.1),
          height: PdfPageFormat.cm * 2,
          width: PdfPageFormat.cm * 2,
          child: Image(qrCodes[0]),
        ),
        Container(
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.1),
          height: PdfPageFormat.cm * 2,
          width: PdfPageFormat.cm * 2,
          child: Image(qrCodes[1]),
        ),
        Container(
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.1),
          height: PdfPageFormat.cm * 2,
          width: PdfPageFormat.cm * 2,
          child: Image(qrCodes[0]),
        ),
      ]),
      outerLabelBlock(value),
      label
          ? Container(
              child: Image(labelImage,
                  height: PdfPageFormat.cm * 2.3,
                  width: PdfPageFormat.cm * 10.5))
          : Container()
    ]),
  ]);
}

Container outerLabelBlock(value) {
  List<String> words = value['Scientific Name & Author'].split(' ');
  String nameOne = words[0];
  String nameTwo = words.length > 1 ? words[1] : '';
  String rest = words.length > 2 ? words.skip(2).join(" ") : '';
  return Container(
      margin: EdgeInsets.all(PdfPageFormat.cm * 0.1),
      height: PdfPageFormat.cm * 2,
      width: PdfPageFormat.cm * 8,
      decoration: BoxDecoration(border: Border.all()),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: '$nameOne $nameTwo ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(text: rest, style: TextStyle(font: Font.times())),
        ])),
        Text(value['Family'].toUpperCase())
      ]));
}

Container mainLabelBlock(value) {
  List<String> words = value['Scientific Name & Author'].split(' ');
  String nameOne = words[0];
  String nameTwo = words.length > 1 ? words[1] : '';
  String rest = words.length > 2 ? words.skip(2).join(" ") : '';
  return Container(
    margin: EdgeInsets.all(PdfPageFormat.cm * 0.1),
    height: PdfPageFormat.cm * 7,
    width: PdfPageFormat.cm * 10,
    decoration: BoxDecoration(border: Border.all()),
    padding: EdgeInsets.all(6),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(value['Organization'].toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      font: Font.times(),
                      fontBold: Font.timesBold()),
                  textAlign: TextAlign.center),
              Text(value['Locality & Pincode'],
                  style: TextStyle(fontSize: 13, font: Font.times()),
                  textAlign: TextAlign.center),
            ])),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${value['Date']}'),
                  Text('Collection No: ${value['Collection ID']}'),
                ])),
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(text: 'Scientific Name: '),
          TextSpan(
              text: '$nameOne $nameTwo ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(text: rest, style: TextStyle(font: Font.times())),
        ])),
        Text("Family: ${value['Family'].toUpperCase()}"),
        value['Notes \n\n'] == null
            ? Container()
            : Text('Notes: ${value['Notes \n\n']}'),
        Text("Locality: ${value['Locality']}"),
        value['Coordinates'] == null
            ? Container()
            : Text('Coordinates: ${value['Coordinates']}'),
        Text("Collected By: ${value['Collected By']}"),
      ],
    ),
  );
}

Future<List> makeQrcodes(List values, callback) async {
  var out = [];
  for (var value in values) {
    out.add(await makeQr(value));
    callback();
  }

  return out;
}

Future<List> makeQr(value) async {
  String content1 = '''
Organization: ${value['Organization'].toUpperCase()}
Place: ${value['Locality & Pincode']}
Date: ${value['Date']}
Collection ID: ${value['Collection ID']}
Scientific Name: ${value['Scientific Name & Author']}
Family: ${value['Family'].toUpperCase()}${value['Notes \n\n'] == null ? '' : '\nNotes: ${value['Notes \n\n']}'}
Collected By: ${value['Collected By']}
Locality: ${value['Locality']}${value['Coordinates'] == null ? '' : '\nGPS: ${value['Coordinates']}'} 
''';
  String content2 = '''
Scientific Name: ${value['Scientific Name with Citations']}
Distribution: ${value['Distribution ']}
  ''';
  if (value['Flowering & Fruiting'] != null) {
    content2 += '\nFlowering & Fruiting: ${value['Flowering & Fruiting']}';
  }
  if (value['Description \n\n'] != null) {
    content2 += '\nDescription: ${value['Description \n\n']}';
  }
  if (value['URL for Reference \n\n'] != null) {
    content2 += '\nURL for Reference: ${value['URL for Reference \n\n']}';
  }

  return [
    MemoryImage((await QrPainter(data: content1, version: QrVersions.auto)
            .toImageData(2048, format: ImageByteFormat.png))
        .buffer
        .asUint8List()),
    MemoryImage((await QrPainter(data: content2, version: QrVersions.auto)
            .toImageData(2048, format: ImageByteFormat.png))
        .buffer
        .asUint8List()),
  ];
}
