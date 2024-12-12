// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.selectedIndex, required this.onSelectIndex});
  final int selectedIndex;
  final Function(int) onSelectIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _tabName
          .mapIndexed(
            (index, tabName) => Expanded(
              child: _tabMenu(
                  tabName: tabName,
                  index: index,
                  isSelected: index == selectedIndex,
                  isLast: index == _tabName.length,
                  onSelectItem:onSelectIndex),
            ),
          )
          .toList(),
    );
  }

  Widget _tabMenu({
    required String tabName,
    bool isSelected = false,
    bool isLast = false,
    required Function(int) onSelectItem,
    required int index,
  }) =>
      GestureDetector(
        onTap: () => onSelectItem.call(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(right: isLast ? 0 : 8),
          decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );

  List<String> get _tabName => ['Daily', 'Weekly', 'Monthly'];
}
