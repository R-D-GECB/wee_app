import 'dart:io';
import 'dart:ui';
import 'package:flutter/rendering.dart' as r;
import 'package:vector_math/vector_math.dart' as v;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

MemoryImage labelImage;
Future<String> generate(List<Map> values, bool label, Function callback) async {
  Document pdf = Document();
  int perPage = 3;
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
  final String path = "${output.path}/generated.pdf";
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  return path;
}

Future<Page> makePage(Iterable<Map> values, bool label, callback) async {
  List valuesList = values.toList();
  List qrCodes = await makeQrcodes(valuesList, callback);
  return Page(
      theme: ThemeData(defaultTextStyle: TextStyle(font: Font.times())),
      margin: EdgeInsets.only(top: 1),
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
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.5),
          height: PdfPageFormat.cm * 2.5,
          width: PdfPageFormat.cm * 2.5,
          child: Image(qrCodes[0]),
        ),
        Container(
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.5),
          height: PdfPageFormat.cm * 2.5,
          width: PdfPageFormat.cm * 2.5,
          child: Image(qrCodes[1]),
        ),
        Container(
          margin: EdgeInsets.all(PdfPageFormat.cm * 0.5),
          height: PdfPageFormat.cm * 2.5,
          width: PdfPageFormat.cm * 2.5,
          child: Image(qrCodes[0]),
        ),
      ]),
      outerLabelBlock(value),
      label
          ? Container(
              child: Image(labelImage,
                  height: PdfPageFormat.cm * 3, width: PdfPageFormat.cm * 10.5))
          : Container()
    ]),
  ]);
}

Container outerLabelBlock(value) {
  return Container(
      margin: EdgeInsets.only(bottom: PdfPageFormat.cm * 0.5),
      height: PdfPageFormat.cm * 2,
      width: PdfPageFormat.cm * 8,
      decoration: BoxDecoration(border: Border.all()),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: '${value['Scientific Name']} ',
                  style: TextStyle(font: Font.timesBoldItalic())),
              TextSpan(
                  text:
                      '${value['Author citation'] ?? ''} ${value['Infraspecific category'] ?? ''} ',
                  style: TextStyle(font: Font.times())),
              TextSpan(
                  text: '${value['Epithet'] ?? ''} ',
                  style: TextStyle(font: Font.timesBoldItalic())),
              TextSpan(
                  text: '${value['Author'] ?? ''}',
                  style: TextStyle(font: Font.times())),
            ])),
        Text(value['Family'].toUpperCase())
      ]));
}

Container mainLabelBlock(value) {
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
                  Text('Collection No: ${value['Collection Number']}'),
                ])),
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Scentific Name: ', style: TextStyle(font: Font.times())),
          TextSpan(
              text: '${value['Scientific Name']} ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(
              text:
                  '${value['Author citation'] ?? ''} ${value['Infraspecific category'] ?? ''} ',
              style: TextStyle(font: Font.times())),
          TextSpan(
              text: '${value['Epithet'] ?? ''} ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(
              text: '${value['Author'] ?? ''}',
              style: TextStyle(font: Font.times())),
        ])),
        Text("Family: ${value['Family'].toUpperCase()}"),
        value['Notes \n\n'] == null
            ? Container()
            : Text('Notes: ${value['Notes \n\n']}', maxLines: 3),
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
Collection Number: ${value['Collection Number']}
Scientific Name: ${value['Scientific Name']} ${value['Author citation'] ?? ''} ${value['Infraspecific category'] ?? ''} ${value['Epithet'] ?? ''} ${value['Author']}
Family: ${value['Family'].toUpperCase()}${value['Notes \n\n'] == null ? '' : '\nNotes: ${value['Notes \n\n']}'}
Collected By: ${value['Collected By']}
Locality: ${value['Locality']}${value['Coordinates'] == null ? '' : '\nGPS: ${value['Coordinates']}'} 
''';
  String content2 = '''
']}
Scientific Name: ${value['Scientific Name']} ${value['Author citation'] ?? ''} ${value['Infraspecific category'] ?? ''} ${value['Epithet'] ?? ''} ${value['Author'] ?? ''}
  ''';
  if (value['Distribution '] != null) {
    content2 += '\nDistribution: ${value['Distribution ']}';
  }
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

Future<String> generateDataSheet(
    List<Map> values, bool label, Function callback) async {
  Document pdf = Document();
  int perPage = 2;
  callback = callback;
  int numberOfPages = values.length ~/ perPage;
  int lastPage = values.length % perPage;
  for (var i = 0, start = 0, end = perPage; i < numberOfPages; i++) {
    pdf.addPage(await makeSheetPage(values.getRange(start, end), callback));
    start += perPage;
    end += perPage;
  }
  if (lastPage != 0) {
    pdf.addPage(await makeSheetPage(
        values.getRange(values.length - lastPage, values.length), callback));
  }

  final output = await getTemporaryDirectory();
  final String path = "${output.path}/generated.pdf";
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  return path;
}

Future<Page> makeSheetPage(Iterable<Map> values, callback) async {
  List valuesList = values.toList();
  return Page(
      theme: ThemeData(defaultTextStyle: TextStyle(font: Font.times())),
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(0),
      build: (context) {
        return Column(
            children: List.generate(values.length, (index) {
          callback();
          return dataSheetItemBlock(valuesList[index]);
        }));
      });
}

Widget dataSheetItemBlock(Map value) {
  return Container(
      height: PdfPageFormat.a4.height / 2,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, style: BorderStyle.dashed))),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1, style: BorderStyle.dotted))),
              child: Text('Folding 1', textAlign: TextAlign.right),
              width: PdfPageFormat.a4.width / 3),
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1, style: BorderStyle.dotted))),
              child: Text('Folding 2'),
              width: PdfPageFormat.a4.width / 3),
        ]),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Expanded(
                  child: Transform(
                      adjustLayout: true,
                      child: Container(
                          child: Text('Folding 3'),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      style: BorderStyle.solid, width: 1)))),
                      transform: r.Matrix4.rotationZ(v.radians(-90)))),
              Container(
                  child: leftBlock(value),
                  width: PdfPageFormat.a4.width / 3 - 45),
              Container(
                  padding: EdgeInsets.only(left: 18),
                  child: rightBlock(value),
                  width: (PdfPageFormat.a4.width / 3 - 45) * 2),
              Expanded(
                  child: Transform(
                      adjustLayout: true,
                      child: Container(
                          child: Text('Folding 3'),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      style: BorderStyle.solid, width: 1)))),
                      transform: r.Matrix4.rotationZ(v.radians(-90)))),
            ])),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, style: BorderStyle.solid),
                      right: BorderSide(width: 1, style: BorderStyle.dotted))),
              child: Text('Folding 1', textAlign: TextAlign.right),
              width: PdfPageFormat.a4.width / 3),
          Container(
            padding: EdgeInsets.all(5),
            child: Text('Base Out', textAlign: TextAlign.center),
            width: (PdfPageFormat.a4.width / 3),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1, style: BorderStyle.solid),
            )),
          ),
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, style: BorderStyle.solid),
                      left: BorderSide(width: 1, style: BorderStyle.dotted))),
              child: Text('Folding 2'),
              width: PdfPageFormat.a4.width / 3),
        ]),
      ]));
}

Widget leftBlock(Map value) {
  String content2 = '';
  if (value['Description \n\n'] != null) {
    content2 += '\n\n\n ${value['Description \n\n']}';
  }
  if (value['Distribution '] != null) {
    content2 += '\nDistribution: ${value['Distribution ']}';
  }
  if (value['Flowering & Fruiting'] != null) {
    content2 += '\nFlowering & Fruiting: ${value['Flowering & Fruiting']}';
  }
  if (value['URL for Reference \n\n'] != null) {
    content2 += '\nURL for Reference: ${value['URL for Reference \n\n']}';
  }
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: '${value['Scientific Name']} ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(
              text:
                  '${value['Author citation'] ?? ''} ${value['Infraspecific category'] ?? ''} ',
              style: TextStyle(font: Font.times())),
          TextSpan(
              text: '${value['Epithet'] ?? ''} ',
              style: TextStyle(font: Font.timesBoldItalic())),
          TextSpan(
              text: '${value['Author'] ?? ''}',
              style: TextStyle(font: Font.times())),
        ])),
    Text('Family: ${value['Family'].toUpperCase()}'),
    Text(content2)
  ]);
}

Widget rightBlock(Map value) {
  final images = value['images'];
  return images == null
      ? Column()
      : GridView(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          children: List.generate(
              images.length,
              (index) =>
                  Image(MemoryImage(File(images[index]).readAsBytesSync()))));
}
