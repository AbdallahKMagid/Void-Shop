import 'package:flutter/material.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/screens/category_item_screen.dart';

class CategoryItem extends StatelessWidget {
  final Map category;
  final String imgPath;

  const CategoryItem({
    super.key,
    required this.category,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    final slug = category["slug"];
    final name = category["name"];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryItemsScreen(category: slug),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 130,
        height: 150,
        decoration: BoxDecoration(
          color: MyColors.mainColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.primaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imgPath,
                height: 182,
                width: 178,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 60),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
