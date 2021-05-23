import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class SavePdf extends StatefulWidget {
  @override
  _SavePdfState createState() => _SavePdfState();
  String groupId;
  SavePdf( this.groupId);
}

class _SavePdfState extends State<SavePdf> {
  Future<Uint8List> generateDocument() async {
    final pw.Document doc = pw.Document();

    doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          // if (context.pageNumber == 1) {
          //   print("null reached");
          //   return null;
          // }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              // decoration: pw.BoxDecoration(
              //   border: pw.Border(
              //     top: pw.BorderSide(color: PdfColors.red, width: 10, style: pw.BorderStyle.dashed),
              //     left: pw.BorderSide(color: PdfColors.red, width: 10, style: pw.BorderStyle.dashed),
              //   ),
              // ),
              child: pw.Text('Portable Document Format',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Center(child: pw.Paragraph(text: "Your QR", style: pw.TextStyle(fontSize: 18)),),
          pw.Center(child: pw.BarcodeWidget(
            data:  "https://flutter-bellapp.web.app/" + widget.groupId,
            width: 150,
            height: 150,
            barcode: pw.Barcode.qrCode(),
          ),),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ]));

    return doc.save();
  }

  Future<File> previewPdf() async {
    print("success level 1");

    Uint8List uint8list = await generateDocument();
    print("success level 2");
    Directory output = await getTemporaryDirectory();
    File filePreview = File(output.path+"lmao.pdf");
    filePreview.writeAsBytes(uint8list);

    return filePreview;


  }

  Future<File> downloadPdf() async {

    Uint8List uint8list = await generateDocument();
    Directory output = await getTemporaryDirectory();
    File file = File("/storage/emulated/0/Download/" "example.pdf");
    await askForStoragePermission();
    try {
      file.writeAsBytes(uint8list);
      final snackBar = SnackBar(content: Text("Download success! Check your download folder."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(content: Text("Error! Please enable storage permissions."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return file;
  }



  Future askForStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate QR Code"),
      ),
      body: FutureBuilder<File>(
        future: previewPdf(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text("Preview", textAlign: TextAlign.left ,style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Container(
                        height: 400,
                        child: AspectRatio(
                          aspectRatio: 1/1.294,
                          child: PDFView(
                            filePath: snapshot.data.path,
                            autoSpacing: false,
                            pageFling: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all( 20.0),
                    child: Text("Tap on Download to save this QR code in printable PDF form", textAlign: TextAlign.center ,style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  ),
                  RaisedButton(child: Text("Download"),onPressed: () async {await downloadPdf();})
              ]
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}