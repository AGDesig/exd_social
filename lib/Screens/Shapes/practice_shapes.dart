import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class PracticeShapes extends StatefulWidget {
  const PracticeShapes({Key? key}) : super(key: key);

  @override
  State<PracticeShapes> createState() => _PracticeShapesState();
}

class _PracticeShapesState extends State<PracticeShapes> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: CustomPaint(
              size: Size(width, (width*1.2941176470588234).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),),
          )
        ),
      ),
    );
  }
}
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.1617020,size.height*0.2545121);
    path_0.cubicTo(size.width*0.3620471,size.height*0.2545121,size.width*0.5623922,size.height*0.2545121,size.width*0.7627373,size.height*0.2545121);
    path_0.cubicTo(size.width*0.8989725,size.height*0.6066000,size.width*0.6780235,size.height*0.8021061,size.width*0.1617020,size.height*0.5862515);
    path_0.lineTo(size.width*0.1617020,size.height*0.2545121);
    path_0.close();

    Paint paint_0_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.0008156863;
    paint_0_stroke.color=Colors.black;
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0,paint_0_stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
