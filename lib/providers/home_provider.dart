import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payback/data/repository/home_repo.dart';
import 'package:payback/model/categories_response.dart';
import 'package:payback/model/commitment_model.dart';
import 'package:payback/model/onboarding_response.dart';
import 'package:payback/model/partner_custom_fields_response.dart';
import 'package:payback/model/partner_model.dart';

import '../data/repository/auth_repo.dart';
import '../data/service_locator.dart';
import '../model/cities_response.dart';
import '../model/product_model.dart';

enum AVAILABILITY { ALL, AVAILABLE, UNAVAILABLE }

class HomeProvider extends ChangeNotifier {
  AVAILABILITY availability = AVAILABILITY.ALL;

  changeAvailability(AVAILABILITY a) {
    availability = a;
    notifyListeners();
  }

  double minPrice = 0;
  double maxPrice = 10000;

  changeRange(double min, double max) {
    minPrice = min;
    maxPrice = max;
    notifyListeners();
  }

  resetFilters() {
    //selectedShoppingIndex = -1;
    availability = AVAILABILITY.ALL;
    minPrice = 0;
    maxPrice = 10000;
    vendors.forEach((element) {
      element.isChecked = false;
    });

    notifyListeners();
  }

  bool isLoading = false;

  int selectedVendoDetailsIndex = -1;
  int selectedHomeIndex = -1;
  int selectedShoppingIndex = -1;

  List<int> checkedVendors = [];

  checkVendorInFilter(int id) {
    vendors.firstWhere((element) => element.id == id).isChecked =
        !vendors.firstWhere((element) => element.id == id).isChecked;
    notifyListeners();
  }

  String getPartnerNameByID(int id) {
    String name = '';
    vendors.forEach((element) {
      if (element.id == id) name = element.name ?? '';
    });
    return name;
  }

  void onReorder(List<Commitment> newOrder) {
    commitments = newOrder;
    notifyListeners();
  }

  selectHomeIndex(int i) {
    if (selectedHomeIndex == i)
      selectedHomeIndex = -1;
    else
      selectedHomeIndex = i;
    notifyListeners();
  }

  selectVendorDetailsIndex(int i) {
    if (selectedVendoDetailsIndex == i)
      selectedVendoDetailsIndex = -1;
    else
      selectedVendoDetailsIndex = i;
    notifyListeners();
  }

  selectShoppingIndex(int i) {
    if (selectedShoppingIndex == i)
      selectedShoppingIndex = -1;
    else
      selectedShoppingIndex = i;
    notifyListeners();
  }

  List<Category> categories = [];
  List<Data>? onBoarding = [];

  List<Product> products = [];
  List<Product> hotDealsProducts = [];
  List<Product> suggestedProducts = [];
  List<Product> shoppingProducts = [];
  List<Product> vendorProducts = [];
  List<Commitment> commitments = [];
  List<Partner> vendors = [];
  List<Partner> partners = [];

  Future<Map<String, dynamic>> getVendors() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getVendors();
    if (response.containsKey('data')) {
      vendors = response['data'];
    }

    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getPartners() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getPartners();
    if (response.containsKey('data')) {
      partners = response['data'];
    }

    notifyListeners();
    return response;
  }

  List<CustomField> partnerCustomFields = [];
  Future<Map<String, dynamic>> getPartnerCustomFields(int id) async {
    isLoading = true;
    partnerCustomFields.clear();
    notifyListeners();

    final response = await sl<HomeRepository>().getPartnerCustomFields(id);
    if (response.containsKey('data')) {
      partnerCustomFields = response['data'] as List<CustomField>;
    }

    isLoading = false;
    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getCommitments() async {
    final response = await sl<HomeRepository>().getCommitments();
    if (response.containsKey('data')) {
      commitments = response['data'];
    }

    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> reOrderCommitments() async {
    isLoading = true;
    notifyListeners();
    final response0 = await sl<HomeRepository>()
        .reOrderCommitments(commitments.map((e) => e.id).toList());

    if (response0['data']) {
      final response = await sl<HomeRepository>().getCommitments();
      if (response.containsKey('data')) {
        commitments = response['data'];
      }
    }

    isLoading = false;

    notifyListeners();
    return response0;
  }

  Future<Map<String, dynamic>> getProducts(
      {String location = 'HOME',
      Map<String, dynamic>? filters,
      bool? isHotDeals,
      bool? isSuggested}) async {
    isLoading = true;
    notifyListeners();
    List<int> vendorIds = [];
    filters ??= {};
    if (location == 'HOME') {
      if (isHotDeals != null && isHotDeals)
        filters.putIfAbsent('hot_deal', () => 1);
      else if (isSuggested != null && isSuggested)
        filters.putIfAbsent('suggested', () => 1);

      if (selectedHomeIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedHomeIndex].id);
      }
    } else if (location == 'SHOPPING') {
      vendors.forEach((element) {
        if (element.isChecked) {
          vendorIds.add(element.id);
        }
      });
      if (vendorIds.isNotEmpty) {
        filters.putIfAbsent(
            'vendor_ids[]', () => vendorIds);
      }
      filters.putIfAbsent('min_price', () => minPrice.toPrecision(0));
      filters.putIfAbsent('max_price', () => maxPrice.toPrecision(0));
      if (selectedShoppingIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedShoppingIndex].id);
      }
    } else if (location == 'VENDOR') {
      if (selectedVendoDetailsIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedVendoDetailsIndex].id);
      }
    }
    print(filters.toString());

    final response = await sl<HomeRepository>().getProducts(filters);
    if (response.containsKey('data')) {
      if (location == 'HOME') {
        products = response['data'];
        if (isHotDeals != null && isHotDeals)
          hotDealsProducts = products;
        else if (isSuggested != null && isSuggested)
          suggestedProducts = products;
      } else if (location == 'SHOPPING')
        shoppingProducts = response['data'];
      else
        vendorProducts = response['data'];
    }

    isLoading = false;

    notifyListeners();
    return response;
  }

  Future<Map> getOnBoarding() async {
    isLoading = true;
    notifyListeners();

    Map response = await sl<HomeRepository>().getOnBoarding();
    onBoarding = response['data'];

    isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Map> getCategories() async {
    isLoading = true;
    notifyListeners();

    Map response = await sl<HomeRepository>().getCategories();
    categories = response['data'];

    isLoading = false;
    notifyListeners();

    return response;
  }

  List<City> cities = [];

  Future<List<City>> getCities() async {
    final response = await sl<HomeRepository>().getCities();

    cities = response;

    notifyListeners();
    return response;
  }
}
