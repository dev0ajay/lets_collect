import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool isEligible = false;
  List<bool> brandCheckboxValues = List.generate(3, (index) => false);
  List<bool> categoryCheckboxValues = List.generate(3, (index) => false);
  Map<String, bool> expansionTileStates = {
    'Brand': false,
    'Category': false,
  };
  double sheetHeight = 300;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: sheetHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 33, right: 45, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filter by"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 14, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Eligible"),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEligible = !isEligible;
                                });
                              },
                              child: Checkbox(
                                value: isEligible,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isEligible = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildExpansionTile('Brand', brandCheckboxValues, ['Brand A', 'Brand B', 'Brand C']),
                      _buildExpansionTile('Category', categoryCheckboxValues, ['Category X', 'Category Y', 'Category Z']),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  brandCheckboxValues = List.generate(3, (index) => false);
                  categoryCheckboxValues = List.generate(3, (index) => false);
                  sheetHeight = 300; // Reset to the initial height
                });
              },
              child: const Text("Clear All"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, List<bool> checkboxValues, List<String> itemTitles) {
    return ExpansionTile(
      title: Text(title),
      trailing: expansionTileStates[title] ?? false
          ? const Icon(Icons.arrow_drop_down_outlined)
          : const Icon(Icons.arrow_right),
      onExpansionChanged: (isExpanded) {
        setState(() {
          expansionTileStates[title] = isExpanded;
          sheetHeight = isExpanded ? 500 : 300;
        });
      },
      children: [
        Column(
          children: List.generate(
            itemTitles.length,
                (index) => ListTile(
              title: Text(itemTitles[index]),
              trailing: Checkbox(
                value: checkboxValues[index],
                onChanged: (value) {
                  setState(() {
                    checkboxValues[index] = value ?? false;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
