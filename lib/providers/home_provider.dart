import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payback/data/repository/home_repo.dart';
import 'package:payback/model/banches_response.dart';
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

  TextEditingController searchControllerShopping = TextEditingController();
  TextEditingController searchControllerVendor = TextEditingController();
  changeAvailability(AVAILABILITY a) {
    availability = a;
    notifyListeners();
  }

  initSearchControllerShopping(){
    searchControllerShopping.clear();
    notifyListeners();
  }
   initSearchControllerVendor(){
    searchControllerVendor.clear();
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

    getProducts(location: 'HOME',isHotDeals: true);
    getProducts(location: 'HOME',isSuggested: true);
  }

  selectVendorDetailsIndex(int i,List<int>?ids) {
    if (selectedVendoDetailsIndex == i)
      selectedVendoDetailsIndex = -1;
    else
      selectedVendoDetailsIndex = i;
    notifyListeners();

    getProducts(location: 'VENDOR',vendorIDs: ids);

  }

  selectShoppingIndex(int i) {
    if (selectedShoppingIndex == i)
      selectedShoppingIndex = -1;
    else
      selectedShoppingIndex = i;
    notifyListeners();
    getProducts(location: 'SHOPPING');


  }

 selectMapIndex(int i) {
    mapCategories[i].isMapSelected =!mapCategories[i].isMapSelected;
    notifyListeners();
  }

  List<Category> categories = [];
  List<Category> mapCategories = [];
  List<Data>? onBoarding = [];

  List<Product> products = [];
  List<Product> hotDealsProducts = [];
  List<Product> suggestedProducts = [];
  List<Product> shoppingProducts = [];
  List<Product> vendorProducts = [];
  List<Product> QRProducts = [];
  List<Product> savedProducts = [];
  List<Partner> savedVendors = [];
  List<Commitment> commitments = [];
  List<Partner> vendors = [];
  List<Partner> partners = [];
  List<Branch> branches = [];
  List<Branch> filterBranches = [];


  sortProducts(int index)async{

    await getProducts(location: 'SHOPPING',);
    if([0,1,2].contains(index)){
      shoppingProducts.sort((a, b) => a.cashback!.compareTo(b.cashback!));

      shoppingProducts = shoppingProducts.reversed.toList();
    }
    else if(index==3){
      shoppingProducts.sort((a, b) => double.parse(a.price!).compareTo(double.parse(b.price!)));
      shoppingProducts = shoppingProducts.reversed.toList();

    } else if(index==4){
      shoppingProducts.sort((a, b) => double.parse(a.price!).compareTo(double.parse(b.price!)));

    }else if(index==5){
      shoppingProducts.sort((a, b) => a.name!.compareTo(b.name!));
      shoppingProducts = shoppingProducts.reversed.toList();

    } else if(index==6){
      shoppingProducts.sort((a, b) => a.name!.compareTo(b.name!));

    }


    notifyListeners();
  }

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

  Partner? getBranchVendor(int vendorId){
    Partner? vendor;
    vendor = vendors.firstWhereOrNull((element) => element.id==vendorId);

    print(vendor?.id??'0');
    return vendor;
  }

  Future<Map<String, dynamic>> getBranches() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getBranches();
    if (response.containsKey('data')) {
      branches = response['data'];

      branches.forEach((element) {

      });
    }

    mapCategories.forEach((element) {print(element.id);});

    print('branches');
    branches.forEach((element) {print(element.categoryId);});

    if(!mapCategories[0].isMapSelected)
    branches = branches.where((element) => mapCategories.map((category) => category).toList().where((element) => element.isMapSelected).map((e) => e.id).toList().contains(element.categoryId)).toList();

    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getFilterBranches(int? id) async {

    isLoading = true;
    notifyListeners();

    final response = await sl<HomeRepository>().getBranches();
    if (response.containsKey('data')) {
      filterBranches = response['data'];
    }

    if(id!=null){
      filterBranches = filterBranches.where((element) => element.cityId==id).toList();
    }

    isLoading = false;

    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getPartners() async {
    // Implement your loading logic here if needed
    // ...

    final response = await sl<HomeRepository>().getPartners();
    if (response.containsKey('data')) {
      partners = response['data'];
      partners = partners.where((element) => element.id!=1).toList();
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
        .reOrderCommitments(commitments.map((e) => e.id!).toList());

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




  Future<Map<String, dynamic>> saveProduct(Product p) async {
    isLoading = true;
     notifyListeners();

    final response0 = await sl<HomeRepository>().saveProduct(p);
    getSavedProducts();


   /* //mock ////////
    if(savedProducts.any((element) => p.id==element.id)){
      savedProducts.removeWhere((element) => element.id==p.id);
    }
    else{
      savedProducts.add(p);
    }*/
////////////////////////

    isLoading = false;
    notifyListeners();
    return response0;
  }

  Future<Map<String, dynamic>> saveVendor(Partner p) async {
    isLoading = true;


   notifyListeners();

    final response0 = await sl<HomeRepository>().savePartner(p);
    //savedVendors = response0['data'];
    getSavedVendors();

    //mock
   /* if(savedVendors.any((element) => p.id==element.id)){
      savedVendors.removeWhere((element) => element.id==p.id);
    }
    else{
      savedVendors.add(p);
    }*/
/////////////////////////

    isLoading = false;
    notifyListeners();
    return response0;
  }




  Future<Map<String, dynamic>> getSavedProducts() async {
    isLoading = true;
    notifyListeners();
    final response0 = await sl<HomeRepository>().getSavedProducts();
    savedProducts = response0['data'];


    isLoading = false;
    notifyListeners();
    return response0;
  }

  Future<Map<String, dynamic>> getSavedVendors() async {
    isLoading = true;
    notifyListeners();
    final response0 = await sl<HomeRepository>().getSavedVendors();
    savedVendors = response0['data'];


    isLoading = false;
    notifyListeners();
    return response0;
  }

  Future<Map<String, dynamic>> getProducts(
      {String location = 'HOME',
        List<int>? vendorIDs,
      Map<String, dynamic>? filters,
      bool? isHotDeals,
      bool? isSuggested}) async {
    isLoading = true;
    notifyListeners();
    List<int> vendorIds = vendorIDs??[];
    filters ??= {};

    if (location == 'HOME') {
      if (isHotDeals != null && isHotDeals)
        filters.putIfAbsent(/*'hot_deal'*/'is_suggest', () => 1);
      else if (isSuggested != null && isSuggested)
        filters.putIfAbsent('is_suggest', () => 1);

      if (selectedHomeIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedHomeIndex].id);
      }
    } else if (location == 'SHOPPING') {
      /*if(searchControllerShopping.text.isNotEmpty){
        filters.putIfAbsent('search', () => searchControllerShopping.text.toString());
      }*/

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

      if(searchControllerVendor.text.isNotEmpty){
      filters.putIfAbsent('search', () => searchControllerVendor.text.toString());
    }

      if (selectedVendoDetailsIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedVendoDetailsIndex].id);
      }

      vendors.forEach((element) {
        if (element.isChecked) {
          vendorIds.add(element.id);
        }
      });
      if (vendorIds.isNotEmpty) {
        filters.putIfAbsent(
            'vendor_ids[]', () => vendorIds);
      }
    }

    else if (location == 'QR') {

      if (vendorIds.isNotEmpty) {
        filters.putIfAbsent(
            'vendor_ids[]', () => vendorIds);
      }
    }
    print(filters.toString());

    final response = await sl<HomeRepository>().getProducts(filters);
    if (response.containsKey('data')) {
      if (location == 'HOME') {
        products = response['data'];
        if (isHotDeals != null && isHotDeals){
          products.sort((a, b) => a.cashback!.compareTo(b.cashback!));

          hotDealsProducts = products.reversed.toList();
        }


      else if (isSuggested != null && isSuggested)
          suggestedProducts = products;
      } else if (location == 'SHOPPING') {
        shoppingProducts = response['data'];
        shoppingProducts = shoppingProducts.where((element) => element.name!.toLowerCase().contains(searchControllerShopping.text.toString().toLowerCase())).toList();
      }

      else if (location == 'QR')
        QRProducts = response['data'];
      else
        vendorProducts = response['data'];
    }

    isLoading = false;

    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> getVendorProducts(int id) async {
    isLoading = true;
    vendorProducts.clear();
    notifyListeners();
    List<int> vendorIds = [];
    Map<String,dynamic> filters= {};


      if(searchControllerVendor.text.isNotEmpty){
        filters.putIfAbsent('search', () => searchControllerVendor.text.toString());
      }

      if (selectedVendoDetailsIndex != -1) {
        filters.putIfAbsent(
            'category_id', () => categories[selectedVendoDetailsIndex].id);
      }



        filters.putIfAbsent(
            'vendor_ids[]', () => [id]);


    print(filters.toString());

    final response = await sl<HomeRepository>().getProducts(filters);
    if (response.containsKey('data')) {
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

    mapCategories = [Category(image: '',description: '',id: 0,isFeatured: '0',name: 'All',isMapSelected: true)]..addAll(categories);
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
