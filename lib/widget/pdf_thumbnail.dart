import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:pdfx/pdfx.dart';

typedef ThumbnailPageCallback = void Function(int page);

typedef CurrentPageWidget = Widget Function(int page, bool isCurrentPage);

class PdfThumbnail extends StatefulWidget {
  factory PdfThumbnail.fromFile(
    String path, {
    Key? key,
    Color? backgroundColor,
    BoxDecoration? currentPageDecoration,
    CurrentPageWidget? currentPageWidget,
    double? height,
    ThumbnailPageCallback? onPageClicked,
    required int currentPage,
    Widget? loadingIndicator,
    ImageThumbnailCacher? cacher,
    bool? scrollToCurrentPage,
    Widget? closeButton,
  }) {
    return PdfThumbnail._(
      key: key,
      path: path,
      backgroundColor: backgroundColor ?? Colors.black,
      height: height ?? 120,
      onPageClicked: onPageClicked,
      currentPage: currentPage,
      currentPageWidget: currentPageWidget ?? (page, isCurrent) => const SizedBox(),
      currentPageDecoration: currentPageDecoration ??
          BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
          ),
      loadingIndicator: loadingIndicator ??
          const Center(
            child: CircularProgressIndicator(),
          ),
      cacher: cacher,
      scrollToCurrentPage: scrollToCurrentPage ?? false,
      closeButton: closeButton,
    );
  }
  const PdfThumbnail._({
    super.key,
    this.path,
    this.backgroundColor,
    required this.height,
    this.onPageClicked,
    required this.currentPage,
    this.currentPageDecoration,
    this.loadingIndicator,
    this.currentPageWidget,
    this.cacher,
    this.scrollToCurrentPage = false,
    this.closeButton,
  });
  final String? path;
  final Color? backgroundColor;
  final BoxDecoration? currentPageDecoration;
  final CurrentPageWidget? currentPageWidget;
  final double height;
  final ThumbnailPageCallback? onPageClicked;
  final int currentPage;
  final Widget? loadingIndicator;
  final Widget? closeButton;
  final ImageThumbnailCacher? cacher;
  final bool scrollToCurrentPage;

  @override
  State<PdfThumbnail> createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends State<PdfThumbnail> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    imagesFuture = _render(widget.path!, widget.cacher);
    super.initState();
  }

  late Future<Map<int, Uint8List>> imagesFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: FutureBuilder<Map<int, Uint8List>>(
        future: imagesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final images = snapshot.data!;
            final image = images[1];
            if (image == null) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 17),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 120,
                width: 100,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(AppAssets.docLock, color: Colors.grey[800]),
              );
            }
            return DecoratedBox(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Image.memory(image),
            );
          } else {
            return widget.loadingIndicator!;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

Future<Map<int, Uint8List>> _render(
  String filePath,
  ImageThumbnailCacher? cacher,
) async {
  final images = <int, Uint8List>{};
  try {
    if (cacher != null) {
      final cached = await cacher.read(filePath);
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }
    }
    final document = await PdfDocument.openFile(filePath);
    for (var pageNumber = 1; pageNumber <= document.pagesCount; pageNumber++) {
      final page = await document.getPage(pageNumber);
      final pageImage = await page.render(
        width: page.width,
        height: page.height,
      );
      images[pageNumber] = pageImage!.bytes;
      await page.close();
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  if (cacher != null) {
    await cacher.write(id: filePath, map: images);
  }
  return images;
}

abstract class ImageThumbnailCacher {
  Future<PageToImage?> read(String id);

  Future<bool> write({
    required String id,
    required PageToImage map,
  });
}

typedef PageToImage = Map<int, Uint8List>;
