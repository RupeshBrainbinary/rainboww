import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/model/ad_add_cart_model.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Home/settings/payment/add_cart/addCart_api/add_cart_api.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/create_advertisement/create_advertisement_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/payment_successful/payment_successful_screen.dart';

import '../../../../../common/popup.dart';
import '../../../../../utils/strings.dart';

class AddCartController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cardNmberController = TextEditingController();
  // TextEditingController expiryMonthController = TextEditingController();
  TextEditingController expiryYearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  String? selectCountry;
  String? myId;
  String? cardNumber;
  bool isRunPayment = false;
  RxBool loader = false.obs;

  bool countryBox = false;

  dropDownBox() {
    if (countryBox == false) {
      countryBox = true;
      update(["drop"]);
    } else {
      countryBox = false;
      update(["drop"]);
    }
    update();
  }

  List filterList = [];

  void serching(value) {
    filterList = (countryCity.where((element) {
      return element
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList());
    update(["drop"]);
  }

  /*void serching(value) {
    filterList = (countryCity.where(
            (element) {
              return element.toString().toLowerCase().contains(value);
        })
        .toList());
    update(["drop"]);
  }*/

  @override
  void onInit() {
    update();
    super.onInit();
  }

  addCart(context) async {
    FocusScopeNode currentfocus = FocusScope.of(context);
    if (!currentfocus.hasPrimaryFocus) {
      currentfocus.unfocus();
    }

    if (validation()) {
      loader.value = true;

      print("payment");

      Future.delayed(const Duration(seconds: 1), () async {
        await addCartDetails(context);

        /*  Get.find<PaymentController>().viewCardModel;
        update(["abc"]);*/
      });
    }
  }

  dropCloced(context) {
    countryBox = false;
    FocusScope.of(context).unfocus();
    update(["addCard"]);
  }

  bool validation() {
    for (int i = 0; i < countryCity.length; i++) {
      if (countryCity[i] == countryController.text) {
        myId = countryController.text;
      }
    }
    if (fullNameController.text.isEmpty) {
      errorToast(Strings.fullNameError);
      return false;
    } else if (addressController.text.isEmpty) {
      errorToast(Strings.addressError);
      return false;
    } else if (cityController.text.isEmpty) {
      errorToast(Strings.cityeError);
      return false;
    } else if (postalCodeController.text.isEmpty) {
      errorToast(Strings.postalCodeError);
      return false;
    } else if (countryController.text.isEmpty) {
      errorToast(Strings.countryError);
      return false;
    } else if (nameOnCardController.text.isEmpty) {
      errorToast(Strings.nameOnCardError);
      return false;
    } else if (cardNmberController.text.isEmpty) {
      errorToast(Strings.cardNumberError);
      return false;
    } else if (cardNmberController.text.length != 19) {
      errorToast(Strings.cardNumberErrorValidation);
      return false;
    } else if (expiryYearController.text.isEmpty) {
      errorToast(Strings.expiryYearError);
      return false;
    } /* else if (expiryMonthController.text.isEmpty) {
      errorToast(Strings.expiryYearError);
      return false;
    }*/
    else if (cvvController.text.isEmpty) {
      errorToast(Strings.cVVError);
      return false;
    } else if (cvvController.text.length != 3) {
      errorToast(Strings.cVVErrorValidation);
      return false;
    } else if (myId == null || myId == "") {
      errorToast("Please enter valid country name");
      return false;
    }
    return true;
  }

  void onCountryCoCityChange(String value) {
    selectCountry = value;
    countryController.text = value;
    update(['addCard']);
  }

  AddCardModel addCardModel = AddCardModel();

  Future<void> addCartDetails(context) async {
     PaymentController controller = Get.find();
     HomeController homeController = Get.find();
    try {
      loader.value = true;
      String str = expiryYearController.text;
      String first;
      String second;
      String str2 = expiryYearController.text;
      first = str.split('/').first;
      second = str2.split('/').last;
      AddCardModel addCardModel = await AddCartApi.addCartDetailsApi(
        context,
        cardNumber: cardNmberController.text.toString().replaceAll(" ", ""),
        exMonth: first,
        cardHolder: nameOnCardController.text,
        cvv: cvvController.text,
        exYear: second,
        fullName: fullNameController.text,
        address: cityController.text,
        city: cityController.text,
        postalCode: postalCodeController.text,
        country: countryController.text,
      );
      if (isRunPayment) {
        loader.value = true;
        CreateAdvertisementController createAdvertisementController =
        Get.put(CreateAdvertisementController());

        createAdvertisementController.addAdvertisement(createAdvertisementController.imgIdList);
        isRunPayment = false;

      }
      if (addCardModel.status ?? false) {
        final PaymentController controller = Get.find();
        await controller.listCardApi(showToast: false);
        controller.transactionPageModel.clear();
        controller.page=1;
        await controller.transactionApiPagination();
        controller.loader.value = true;

        controller.listCardModel.data?.length == null
            ? homeController.viewProfile.data!.userType = "free"
            : homeController.viewProfile.data!.userType = "premium";


        controller.loader.value = false;
        loader.value = false;
      }
    } catch (e) {
      loader.value = false;
      controller.loader.value = false;
      debugPrint(e.toString());
    }
  }
}
