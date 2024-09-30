import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  var pdf = pw.Document();
  Future<pw.Document> createPDF({required String type, required List<XFile> images}) async {
    var imageFileList = [];
    for (var img in images) {
      final image = pw.MemoryImage(await img.readAsBytes());
      imageFileList.add(image);
    }
    selectView(type, imageFileList);
    return pdf;
  }

  selectView(
    String type,
    List<dynamic> imagesList,
  ) {
    switch (type) {
      case "Normal":
        normal(imagesList);
        break;
      case "Narrow":
        narrow(imagesList);
        break;
      case "None":
        none(imagesList);
        break;
      case "1x2":
        oneByTwo(imagesList);
        break;
      case "2x1":
        twoByOne(imagesList);
        break;
      case "2x2":
        twoByTwo(imagesList);
        break;
      case "3x2":
        threeByTwo(imagesList);
        break;
      case "2x3":
        twoByThree(imagesList);
        break;

      case "3x3":
        threeByThree(imagesList);
        break;
    }
  }

  pw.Document normal(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageFileList[i]),
            );
          }));
    }
    return pdf;
  }

  pw.Document narrow(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 48),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageFileList[i]),
            );
          }));
    }
    return pdf;
  }

  pw.Document none(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                imageFileList[i],
              ),
            );
          }));
    }
    return pdf;
  }

  pw.Document twoByOne(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 2; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(children: [
              pw.Expanded(
                child: pw.Image(imageFileList[2 * i]),
              ),
              pw.SizedBox(height: 16),
              ((2 * i) + 1 < imageFileList.length) ? pw.Expanded(child: pw.Image(imageFileList[(2 * i) + 1])) : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }

  pw.Document oneByTwo(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 2; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Row(children: [
              pw.Expanded(
                child: pw.Image(imageFileList[2 * i]),
              ),
              pw.SizedBox(width: 16),
              ((2 * i) + 1 < imageFileList.length) ? pw.Expanded(child: pw.Image(imageFileList[(2 * i) + 1])) : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }

  pw.Document twoByTwo(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 4; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Expanded(
                child: pw.Row(mainAxisSize: pw.MainAxisSize.max, mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                  pw.Expanded(
                    child: pw.Image(imageFileList[4 * i]),
                  ),
                  pw.SizedBox(width: 16),
                  ((4 * i) + 1 < imageFileList.length) ? pw.Expanded(child: pw.Image(imageFileList[(4 * i) + 1])) : pw.Expanded(child: pw.Container()),
                ]),
              ),
              pw.SizedBox(height: 16),
              ((4 * i) + 2 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Row(mainAxisSize: pw.MainAxisSize.max, mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                        pw.Expanded(
                          child: pw.Image(imageFileList[(4 * i) + 2]),
                        ),
                        pw.SizedBox(width: 16),
                        ((4 * i) + 3 < imageFileList.length) ? pw.Expanded(child: pw.Image(imageFileList[(4 * i) + 3])) : pw.Expanded(child: pw.Container()),
                      ]),
                    )
                  : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }

  pw.Document threeByTwo(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 6; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          //   pageTheme: pw.PageTheme(theme: pw.ThemeData()),
          margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Expanded(
                child: pw.Container(
                  child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Container(
                        width: Get.width / 2,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Image(imageFileList[(6 * i)]),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    ((6 * i) + 1 < imageFileList.length)
                        ? pw.Container(
                            width: Get.width / 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Image(imageFileList[(6 * i) + 1]),
                            ),
                          )
                        : pw.Container(
                            width: Get.width / 2,
                          ),
                  ]),
                ),
              ),
              pw.SizedBox(height: 16),
              ((6 * i) + 2 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Container(
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              width: Get.width / 2,
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Image(imageFileList[(6 * i) + 2]),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 16),
                          ((6 * i) + 3 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 2,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(6 * i) + 3]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 2,
                                ),
                        ]),
                      ),
                    )
                  : pw.Expanded(child: pw.Container()),
              pw.SizedBox(height: 16),
              ((6 * i) + 4 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Container(
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              width: Get.width / 2,
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Image(imageFileList[(6 * i) + 4]),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 16),
                          ((6 * i) + 5 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 2,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(6 * i) + 5]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 2,
                                ),
                        ]),
                      ),
                    )
                  : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }

  pw.Document twoByThree(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 6; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          //   pageTheme: pw.PageTheme(theme: pw.ThemeData()),
          margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Expanded(
                child: pw.Container(
                  child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Container(
                        width: Get.width / 3,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Image(imageFileList[(6 * i)]),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    ((6 * i) + 1 < imageFileList.length)
                        ? pw.Container(
                            width: Get.width / 3,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Image(imageFileList[(6 * i) + 1]),
                            ),
                          )
                        : pw.Container(
                            width: Get.width / 3,
                          ),
                    pw.SizedBox(width: 16),
                    ((6 * i) + 2 < imageFileList.length)
                        ? pw.Container(
                            width: Get.width / 3,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Image(imageFileList[(6 * i) + 2]),
                            ),
                          )
                        : pw.Container(
                            width: Get.width / 3,
                          ),
                  ]),
                ),
              ),
              pw.SizedBox(height: 16),
              ((6 * i) + 3 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Container(
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              width: Get.width / 3,
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Image(imageFileList[(6 * i) + 3]),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 16),
                          ((6 * i) + 4 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(6 * i) + 4]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                          pw.SizedBox(width: 16),
                          ((6 * i) + 5 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(6 * i) + 5]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                        ]),
                      ),
                    )
                  : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }

  pw.Document threeByThree(List<dynamic> imageFileList) {
    for (var i = 0; i < imageFileList.length / 9; i++) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Column(mainAxisSize: pw.MainAxisSize.max, children: [
              pw.Expanded(
                child: pw.Container(
                  child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Container(
                        width: Get.width / 3,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Image(imageFileList[(9 * i)]),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    ((9 * i) + 1 < imageFileList.length)
                        ? pw.Container(
                            width: Get.width / 3,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Image(imageFileList[(9 * i) + 1]),
                            ),
                          )
                        : pw.Container(
                            width: Get.width / 3,
                          ),
                    pw.SizedBox(width: 16),
                    ((9 * i) + 2 < imageFileList.length)
                        ? pw.Container(
                            width: Get.width / 3,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Image(imageFileList[(9 * i) + 2]),
                            ),
                          )
                        : pw.Container(
                            width: Get.width / 3,
                          ),
                  ]),
                ),
              ),
              pw.SizedBox(height: 16),
              ((9 * i) + 3 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Container(
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              width: Get.width / 3,
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Image(imageFileList[(9 * i) + 3]),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 16),
                          ((9 * i) + 4 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(9 * i) + 4]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                          pw.SizedBox(width: 16),
                          ((9 * i) + 5 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(9 * i) + 5]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                        ]),
                      ),
                    )
                  : pw.Expanded(child: pw.Container()),
              pw.SizedBox(height: 16),
              ((9 * i) + 6 < imageFileList.length)
                  ? pw.Expanded(
                      child: pw.Container(
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              width: Get.width / 3,
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Image(imageFileList[(9 * i) + 6]),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 16),
                          ((9 * i) + 7 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(9 * i) + 7]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                          pw.SizedBox(width: 16),
                          ((9 * i) + 8 < imageFileList.length)
                              ? pw.Container(
                                  width: Get.width / 3,
                                  child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Image(imageFileList[(9 * i) + 8]),
                                  ),
                                )
                              : pw.Container(
                                  width: Get.width / 3,
                                ),
                        ]),
                      ),
                    )
                  : pw.Expanded(child: pw.Container()),
            ]));
          }));
    }
    return pdf;
  }
}
