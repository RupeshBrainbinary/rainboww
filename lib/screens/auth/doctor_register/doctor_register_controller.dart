import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/helper.dart';
import 'package:rainbow_new/screens/auth/login/login_api/login_api.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/adviser_api/adviser_api.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/adviser_api/adviser_json.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/registeradviser_controller.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';
import 'package:rainbow_new/utils/strings.dart';

class DoctorRegisterController extends GetxController {
  TextEditingController profession = TextEditingController();
  String? selectProfession;
  TextEditingController comanyName = TextEditingController();
  TextEditingController companyNumber = TextEditingController();

  TextEditingController streetName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  String? selectCountry;
  TextEditingController postalCode = TextEditingController();
  TextEditingController website = TextEditingController();

  // String selectedLocation = Strings.single;
  AdvertiserRegister advertiserRegister = AdvertiserRegister();
  String? status;
  String? role;

  List<String> professionList = [
    Strings.doctor,
    Strings.admin,
    Strings.endUsers,
  ];

  // bool professions = false;
  bool kidsDropdown = false;
  RxBool loader = false.obs;

  // bool countryCityDropdown = false;

  @override
  void onInit() {
    // countryName();

    update(['doctor']);
    super.onInit();
  }

/*  void onStatusChange(String value) {
    country.text = value;
    update(['doctor']);
  }*/
  dropCloced(context) {
    countryBox = false;
    FocusScope.of(context).unfocus();
    update(["doctor"]);
  }

  void onCountryCoCityChange(String value) {
    selectCountry = value;
    country.text = value;
    update(['doctor']);
  }

  List filterList = [];

  void serching(value) {
    filterList = (listCountryModel.data?.where((element) {
          return element.name
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase());
        }).toList()) ??
        [];
    update(["drop"]);
  }

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

  // void onCountryCoCitySelect() {
  //   if (countryCityDropdown == false) {
  //     countryCityDropdown = true;
  //   } else {
  //     countryCityDropdown = false;
  //   }
  //   update(['doctor']);
  // }
  // void onProfessionOnTap() {
  //   if (professions == false) {
  //     professions = true;
  //   } else {
  //     professions = false;
  //   }
  //   update(['doctor']);
  // }

  void onProfessionChange(String value) {
    selectProfession = value;
    profession.text = value;
    update(['doctor']);
  }

  Future<void> onRegisterTap(context) async {
    dropCloced(context);
    if (validation()) {
      companyRegister();
    }
  }

  // ListCountryModel listCountryModel = ListCountryModel();
  // Future<void> countryName() async {
  //   loader.value = true;
  //   try {
  //     await ListOfCountryApi.postRegister()
  //         .then((value) => listCountryModel = value!);
  //     getCountry();
  //     loader.value = false;
  //   } catch (e) {
  //     errorToast(e.toString());
  //     loader.value = false;
  //     debugPrint(e.toString());
  //   }
  // }

  bool validation() {
    if (profession.text.isEmpty) {
      errorToast(Strings.professionError);
      return false;
    } else if (comanyName.text.isEmpty) {
      errorToast(Strings.companyNameError);
      return false;
    } else if (companyNumber.text.isEmpty) {
      errorToast(Strings.companyNumberError);
      return false;
    } else if (city.text.isEmpty) {
      errorToast(Strings.cityError);
      return false;
    } else if (country.text.isEmpty) {
      errorToast(Strings.countryError);
      return false;
    } else if (postalCode.text.isEmpty) {
      errorToast(Strings.postalCodeError);
      return false;
    } else if (hasValidUrl(website.text) == false) {
      errorToast(Strings.websiteValidError);
      return false;
    } else if (website.text.isEmpty) {
      errorToast(Strings.websiteError);
      return false;
    }
    return true;
  }

  AdviserRegisterController controller = Get.put(AdviserRegisterController());

  String? codeId;

  Future<void> companyRegister() async {
    loader.value = true;
    try {
      
      for (int i = 0; i < listCountryModel.data!.length; i++) {
        if (listCountryModel.data![i].name == country.text.toString().trim()) {
          codeId = listCountryModel.data![i].id!.toString();
        }
        /*       countryCity.add(listCountryModel.data![i].name!);
        countryId.add(listCountryModel.data![i].id!.toString());*/

      }
      await AdvirtisersApi.postRegister(
              controller.fullNameController.text,
              controller.emailController.text,
              controller.pwdController.text,
              controller.houseNumber.text,
              controller.streetName.text,
              "+${'${controller.countryModel.phoneCode} ${controller.phoneNumber.text}'}",
              controller.city.text,
              controller.passId.toString(),
              controller.postalCode.text,
              profession.text,
              comanyName.text,
              companyNumber.text,
              streetName.text,
              city.text,
              codeId.toString(),
              postalCode.text,
              website.text)
          .then(
        (value) => advertiserRegister = value!,
      );

      loader.value = false;
      // await PrefService.setValue(PrefKeys.phonSaveNumberAdvertiser, "+${'${controller.countryModel.phoneCode} ${controller.phoneNumber.text}'}")
      await PrefService.setValue(
          PrefKeys.registerToken, advertiserRegister.token.toString());
      await LoginApi.updateDeviceToken();
      await PrefService.setValue(PrefKeys.userId, advertiserRegister.data!.id);
      status = advertiserRegister.data!.status.toString();
      role = advertiserRegister.data!.role.toString();
    } catch (e) {
      loader.value = false;
      debugPrint(e.toString());
    }
  }
}
