import 'package:nest/ui/common/app_enums.dart';
import 'package:flutter/material.dart';

class FilterTabBar extends StatelessWidget {
  final EventFilter selectedFilter;
  final Function(EventFilter) onFilterChanged;

  const FilterTabBar({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: EventFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged(filter),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: isSelected
                      ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFFFF6B35),
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    filter.displayName,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFFFF6B35) : Colors.grey,
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
