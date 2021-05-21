import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<String> generate(List<Map> values) async {
  Document pdf = Document();
  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Center(child: Text('Hello World'));
      }));
  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Center(child: Text('Hello World2'));
      }));

  final output = await getTemporaryDirectory();
  final String path = "${output.path}/generated_file.pdf";
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  return path;
}
