
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/data/repository/checkout_repo.dart';
import 'package:payback/data/repository/help_community_repo.dart';
import 'package:payback/model/community_user.dart';
import 'package:payback/model/product_model.dart';
import 'package:payback/model/shipping_model.dart';
import 'package:payback/screens/checkout_object.dart';

import '../data/service_locator.dart';
import '../model/orders_model.dart';

class HelpCommunityProvider extends ChangeNotifier{

  bool isLoading = false;

  List<CommunityUser> users = [];

  Future getHelpCommunityUsers()async {

    isLoading = true;
    notifyListeners();

    final response = await sl<HelpCommunityRepository>().getHelpCommunityUsersList();

    users = response['data']??[];
    isLoading = false;
    notifyListeners();
    return response;
  }



}