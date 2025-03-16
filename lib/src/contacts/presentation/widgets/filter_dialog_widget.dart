import 'package:contact_x/src/category/domain/models/category.dart';
import 'package:flutter/material.dart';

class FilterDialogWidget extends StatefulWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category?) onApply;

  const FilterDialogWidget({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onApply,
  });

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory; // Preserve previous selection
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.categories.map(
            (category) => RadioListTile<Category>(
              title: Text(category.name),
              value: category,
              groupValue: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(_selectedCategory);
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
