import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  final String title;
  final String duration;
  final String institution;
  const EducationSection({
    super.key,
    required this.title,
    required this.duration,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.school, size: 36, color: Colors.white),
            Container(width: 2, height: 80, color: Colors.grey[300]),
          ],
        ),
        SizedBox(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(duration, style: TextStyle(color: Colors.grey[600])),
              SizedBox(width: 30),
              Text(institution,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Container(width: 40, height: 2, color: Colors.grey[400]),
            ],
          ),
        ),
      ],
    );
  }
}
