import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResponsiveCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ResponsiveCard({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = screenWidth * 0.05;
    double iconSize = screenWidth * 0.04;
    double fontSize = screenWidth * 0.035;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Card(
        child: Container(
          height: screenHeight / 6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoColumn(Icons.star, Colors.amber, '4.2', 'Ratings',
                  iconSize, fontSize),
              buildInfoColumn(FontAwesomeIcons.fire, Colors.orange, '250kCal',
                  'Calories', iconSize, fontSize),
              buildInfoColumn(Icons.timer, Colors.black, '15 min',
                  'Time For Delivery', iconSize, fontSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoColumn(IconData icon, Color color, String value, String label,
      double iconSize, double fontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              shadows: [Shadow(offset: Offset.zero, blurRadius: 2)],
              size: iconSize,
            ),
            SizedBox(width: 5),
            Text(
              value,
              style: GoogleFonts.albertSans(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(fontSize: fontSize * 0.8),
        ),
      ],
    );
  }
}
