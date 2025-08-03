import 'package:flutter/material.dart';

class FeedTabBarWidget extends StatelessWidget {
  const FeedTabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildTabItem('For you', true),
            const SizedBox(width: 32),
            _buildTabItem('Upcoming', false),
            const SizedBox(width: 32),
            _buildTabItem('Following', false),
          ],
        ),
      ),
    );
  }
  }
Widget _buildTabItem(String title, bool isActive) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isActive ? Colors.orange : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: isActive ? Colors.white : Colors.grey,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
  );
}
