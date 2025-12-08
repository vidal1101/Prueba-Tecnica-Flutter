
import 'package:flutter/material.dart';


/// MenuCard
/// 
/// This class represents a card for a menu item. It displays an icon, title, and subtitle.
class MenuCard extends StatelessWidget {
  
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black26, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.black87),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),

                  const SizedBox(height: 4),

                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      )),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
