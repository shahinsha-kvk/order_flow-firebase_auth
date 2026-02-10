import 'package:flutter/material.dart';
import '../../../helpers/ui_helper.dart';
import '../../model/menu_model.dart';
import '../../provider/home_view_model.dart';

class CategoryTabs extends StatelessWidget {
  final List<Category> categories;
  final HomeViewModel vm;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context: context) * 0.07,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == vm.selectedCategoryIndex;

          return GestureDetector(
            onTap: () => vm.selectCategory(index),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(
                  bottom: BorderSide(
                    color: Colors.red,
                    width: 3,
                  ),
                )
                    : null,
              ),
              child: Text(
                categories[index].name,
                style: TextStyle(
                  color: isSelected ? Colors.red : Colors.black,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: getWidth(context: context)*0.04,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
