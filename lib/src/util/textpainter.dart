//------------------------------------------------------------------------------
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class CustomTextPainter extends CustomPainter {
  final String _text;
  final double _size; //this is pixel unit.
  final int color;

  double get pictureW => _size * (_text.length);

  //this value can smaller.
  double get pictureH => _size * 2; //there is 2 times _size due to text will around word-spacing.

  CustomTextPainter(this._text, this._size, {this.color = 0xff000000});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final textStyle = ui.TextStyle(
      color: Color(color),
      fontSize: _size,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(_text);
    final constraints = ui.ParagraphConstraints(width: pictureW);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    const offset = Offset(0, 0);
    canvas.drawParagraph(paragraph, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  /// Returns a [ui.Picture] object.
  ui.Picture toPicture() {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    paint(canvas, Size(pictureW, pictureH));
    return recorder.endRecording();
  }

  /// Returns [ui.Image] object.
  Future<ui.Image> toImage({ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    return await toPicture().toImage(pictureW.toInt(), pictureH.toInt());
  }

  /// Returns image byte data.
  Future<ByteData?> toImageData({ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    final image = await toImage(format: format);
    return image.toByteData(format: format);
  }
}