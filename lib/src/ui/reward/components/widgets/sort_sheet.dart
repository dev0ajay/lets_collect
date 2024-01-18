import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custome_rounded_button.dart';

class SortSheet extends StatefulWidget {
  const SortSheet({super.key});

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {
  int _selectedRowIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 6, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sort by"),
                  GestureDetector(
                    onTap: () {
                      (context).pop();
                    },
                    child: const Icon(Icons.cancel),
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildSortRow('Recent', 0, setState),
            _buildSortRow('Expiry first', 1, setState),
            _buildSortRow('Points(Low to High)', 2, setState),
            _buildSortRow('Points(High to Low)', 3, setState),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedRowIndex = -1;
                });
              },
              child: const Text("Clear All"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSortRow(String label, int index, StateSetter setState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRowIndex = index;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16.0),
          ),
          CustomRoundedButton(enabled: _selectedRowIndex == index),
        ],
      ),
    );
  }
}
