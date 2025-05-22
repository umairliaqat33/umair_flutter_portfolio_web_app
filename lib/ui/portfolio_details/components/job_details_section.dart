import 'package:flutter/material.dart';

class JobDetailsSection extends StatelessWidget {
  final String organization;
  final String designation;
  final String fromDate;
  final String toDate;
  final String description;
  const JobDetailsSection({
    super.key,
    required this.organization,
    required this.designation,
    required this.fromDate,
    required this.toDate,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(organization,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(
              "$fromDate $toDate",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(width: 30),
        Column(
          children: [
            Icon(Icons.work, size: 36, color: Colors.white),
            Container(width: 2, height: 80, color: Colors.grey[300]),
          ],
        ),
        SizedBox(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(designation,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Container(width: 40, height: 2, color: Colors.grey[400]),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
