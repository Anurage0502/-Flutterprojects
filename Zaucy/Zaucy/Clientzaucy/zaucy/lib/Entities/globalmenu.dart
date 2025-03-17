import 'package:zaucy/Entities/menu.dart';

List<Menu>? globalmenulist;
Menu? globalmenu;
Menu? getMenuById(String? id) {
  try {
    return globalmenulist!.firstWhere((menu) => menu.id == id);
  } catch (e) {
    print('Menu with id $id not found');
    return null; // Return null if no menu is found
  }
}
