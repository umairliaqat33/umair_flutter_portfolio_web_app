import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> details;
  final Function onDeleteTap;
  final Function onEditTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.details,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.infoCardTitleFontSize(context),
                      ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => onEditTap(),
                      icon: Icon(
                        Icons.edit,
                        color: PortfolioAppTheme.normalTextColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () => onDeleteTap(),
                      icon: Icon(
                        Icons.delete,
                        color: PortfolioAppTheme.normalTextColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            ...details.entries.map(
              (entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${entry.key}: ',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(
                          entry.value?.toString() ?? "",
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
