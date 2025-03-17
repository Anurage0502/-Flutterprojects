import 'package:zaucy/Entities/Coupon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaucy/main.dart';

class Couponservices {
  Future<List<Coupon>> getallActiveCoupons() async {
    final response =
        await http.get(Uri.parse("$baseurlOriginal/api/coupons/ActiveCoupons"));
    final statuscode = response.statusCode;

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Wait for all the OrderItem futures to resolve
      List<Coupon> ActiveCoupons = await Future.wait(data.map((json) =>
              Coupon.fromJson(json)) // Mapping each json to Future<OrderItem>
          );

      return ActiveCoupons;
    } else {
      throw Exception('Failed to fetch Coupons:$statuscode');
    }
  }

  Future<List<Coupon>> getValidCoupons(
      String category, double totalValue) async {
    final Uri url = Uri.parse(
        "$baseurlOriginal/api/coupons/ActiveValidateCategoryMinimumValueCoupons?category=$category&TotalValue=$totalValue");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Coupon> ActivevalidCoupons = await Future.wait(jsonData.map((json) =>
              Coupon.fromJson(json)) // Mapping each json to Future<OrderItem>
          );
      return ActivevalidCoupons;
    } else {
      throw Exception("Failed to fetch valid coupons");
    }
  }
}
