// ignore_for_file: avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:rainbow_new/common/Widget/buttons.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/settings/payment/add_cart/add_cart_controller.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/ad_dashboard.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/advertisement_controlle.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/create_advertisement/create_advertisement_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/payment_failed.dart/payment_failed_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/setup_date/setup_date_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:table_calendar/table_calendar.dart';

class SetupDateScreen extends StatelessWidget {
  SetupDateScreen({Key? key}) : super(key: key);
  final CreateAdvertisementController createAdvertisementController =
      Get.put(CreateAdvertisementController());
  final SetupDateController setupDateController =
      Get.put(SetupDateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorRes.color_50369C,
                ColorRes.color_50369C,
                ColorRes.colorD18EEE,
                ColorRes.colorD18EEE,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              appBar(),
              // top(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: bottom(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AssetRes.backIcon,
                  height: 16,
                  width: 35,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: Get.width * 0.22,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Setup Date",
                  style: gilroyBoldTextStyle(),
                ),
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
        ],
      ),
    );
  }

  Widget bottom(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0853),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Start and End Date",
                style: gilroySemiBoldTextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Container(
                width: Get.width,
                height: 308,
                padding: const EdgeInsets.only(bottom: 5),
                decoration: const BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: GetBuilder<CreateAdvertisementController>(
                  id: 'range',
                  builder: (controller) => TableCalendar(
                    calendarBuilders: const CalendarBuilders(),
                    shouldFillViewport: true,
                    availableGestures: AvailableGestures.all,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2050),
                    onFormatChanged: (CalendarFormat ca) {
                      CalendarFormat.month;
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.twoWeeks: '2 weeks',
                      CalendarFormat.week: 'Week'
                    },
                    focusedDay: DateTime.now(),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      rangeHighlightColor: ColorRes.colorF4F4F4,
                      todayTextStyle: gilroyBoldTextStyle(fontSize: 11.43),
                      weekendTextStyle: gilroyMediumTextStyle(
                          fontSize: 11.43, color: ColorRes.color_27354C),
                      outsideTextStyle: gilroyMediumTextStyle(
                        fontSize: 11.43,
                        color: ColorRes.color_27354C.withOpacity(0.4),
                      ),
                      defaultTextStyle: gilroyMediumTextStyle(
                          fontSize: 11.43, color: ColorRes.color_27354C),
                      rangeEndTextStyle:
                          const TextStyle(fontSize: 15, color: Colors.white),
                      disabledTextStyle: gilroyMediumTextStyle(
                        fontSize: 11.43,
                        color: ColorRes.color_27354C.withOpacity(0.4),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: ColorRes.black,
                        border: Border.all(
                            color: ColorRes.colorFCE307, width: 1.46),
                      ),
                      // selectedTextStyle:
                      //     TextStyle(fontSize: 15, color: Colors.purple),

                      rangeEndDecoration: BoxDecoration(
                        color: ColorRes.color_50369C,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: ColorRes.colorFCE307, width: 1.5),
                      ),
                      rangeStartDecoration: BoxDecoration(
                        color: ColorRes.color_50369C,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: ColorRes.colorFCE307, width: 1.5),
                      ),
                      withinRangeTextStyle: gilroyMediumTextStyle(
                          fontSize: 11.43, color: ColorRes.color_27354C),
                    ),
                    rangeStartDay: controller.startTime,
                    onRangeSelected: (start, end, as) {
                      controller.rangSelect(start, end, as);
                      //controller.startTime = DateTime.utc(start);
                      print(
                          "<<<<<<<<<<<<<<<<<<<<<<<<<<<<  starn<$start>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                      print(
                          "<<<<<<<<<<<<<<<<<<<<<<<<<<End <<<$end>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                      print(
                          "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<$as>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    },
                    rangeEndDay: controller.endTime,
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    headerStyle: HeaderStyle(
                      titleTextStyle: gilroyBoldTextStyle(
                          fontSize: 11.43, color: ColorRes.black),
                      leftChevronVisible: true,
                      rightChevronVisible: true,
                      formatButtonVisible: false,
                      titleCentered: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: ColorRes.black.withOpacity(0.5),
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: ColorRes.black.withOpacity(0.5),
                      ),
                      rightChevronMargin:
                          EdgeInsets.only(right: Get.width * 0.30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: gilroyBoldTextStyle(
                          fontSize: 11.43, color: ColorRes.color_50369C),
                    ),
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (selectedDay, focusedDay) {
                      print(selectedDay);
                      print(focusedDay);
                    },
                    onHeaderTapped: (focusedDay) {
                      print(
                          "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>$focusedDay");
                    },
                  ),
                ),
              ),
              const SizedBox(height: 19),
              Container(
                height: 191,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.color_50369C.withOpacity(0.5),
                      ColorRes.colorD18EEE.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 191,
                      width: Get.width,
                      child: Center(
                        child: GetBuilder<CreateAdvertisementController>(
                            id: 'selectC',
                            builder: (controller) {
                              return (controller.totalAmount == 0)
                                      ? Text(
                                          "£10",
                                          style: gilroySemiBoldTextStyle(
                                              fontSize: 24),
                                        )
                                      : Text(
                                          "£${controller.totalAmount ?? "10"}",
                                          style: gilroySemiBoldTextStyle(
                                              fontSize: 24),
                                        ) 
                                        /*TextField(
                                enabled: false,
                                inputFormatters: [
                                  MoneyInputFormatter(
                                      leadingSymbol: controller.currency),
                                ],
                                controller: createAdvertisementController
                                    .amountController,
                                style: gilroySemiBoldTextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterStyle:
                                      gilroySemiBoldTextStyle(fontSize: 24),
                                  hintText: "${controller.currency}00.00",
                                  hintStyle:
                                      gilroySemiBoldTextStyle(fontSize: 24),
                                ),
                              )*/
                                  ;
                            }),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 17),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Get.width * 0.085),
                            Text(
                              "Amount",
                              style: gilroyMediumTextStyle(fontSize: 18),
                            ),
                            /*   const Spacer(),
                             GetBuilder<SetupDateController>(
                              id: 'selectC',
                              builder: (controller) => Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: ColorRes.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    height: 25,
                                    width: 90,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.showDrop();
                                        showCurrencyPicker(
                                          context: context,
                                          showFlag: true,
                                          showSearchField: true,
                                          showCurrencyName: true,
                                          showCurrencyCode: true,
                                          onSelect: (Currency currency) {
                                            controller.countryName = currency.code;
                                            controller.countryFlag = currency.flag.toString();
                                            print('Select currency: ${currency.name}');
                                          },
                                          favorite: ['SEK'],
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.network(
                                            controller.countryFlag.toString(),
                                            height: 20,
                                            width: 15,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            controller.countryName.toString()??"",
                                            style: gilroyMediumTextStyle(
                                                fontSize: 12,
                                                color: ColorRes.black),
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            AssetRes.drop,
                                            height: 3.5,
                                            width: 7,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  controller.showDropDown
                                      ? Container(
                                          height: 50,
                                          width: 80,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: ListView.builder(
                                            itemCount:
                                                controller.list.length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                controller.selectContry(index);

                                              },
                                              child: Container(
                                                height: 20,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: ColorRes.white),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Image.asset(controller
                                                        .flagList[index]),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      controller.list[index],
                                                      style: const TextStyle(
                                                          color:
                                                              ColorRes.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.0293,
                            )*/
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SubmitButton(
                onTap: () {
                  createAdvertisementController.onTapNext();
                  /*            Get.bottomSheet(
                    enableDrag: false,
                    BottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      backgroundColor: ColorRes.white,
                      onClosing: () {},
                      constraints: BoxConstraints(
                        maxHeight: Get.height - (Get.height * 0.0480),
                      ),

                      // enableDrag: true,
                      builder: (_) => const ShowBottomNext(),
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    ignoreSafeArea: true,
                  );*/
                },
                child: Text(
                  "Next",
                  style: gilroyBoldTextStyle(
                    fontSize: 16,
                    color: ColorRes.black,
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          )
        ],
      ),
    );
  }
}

/// BottomSheet ---> Pay
class ShowBottomNext extends StatelessWidget {
  String? amount;

  ShowBottomNext({Key? key, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateAdvertisementController createAdvertisementController =
        Get.put(CreateAdvertisementController());
    AdHomeController adHomeController = Get.find<AdHomeController>();
    PaymentController paymentController = Get.put(PaymentController());
    AdvertisementController advertisementController =
        Get.put(AdvertisementController());
    return Obx(
      () => Stack(
        children: [
          DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.99,
            minChildSize: 0.84,
            maxChildSize: 0.99,
            builder: (context, scrollController) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                      // top: Get.height * 0.1169,
                      left: Get.width * 0.0853,
                      right: Get.width * 0.0853),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.00985,
                      ),
                      Container(
                        height: 5,
                        width: Get.width * 0.36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: ColorRes.black.withOpacity(0.2)),
                      ),
                      SizedBox(
                        height: Get.height * 0.1009,
                      ),
                      Text(
                        "Confirm Advertisement Details And Pay",
                        style: gilroySemiBoldTextStyle(
                          fontSize: 24,
                          color: ColorRes.black,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.0307),
                      Container(
                        width: Get.width * 0.8293,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorRes.color_50369C,
                              ColorRes.color_50369C,
                              ColorRes.colorD18EEE,
                              ColorRes.colorD18EEE,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.0666),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.0320,
                                  ),
                                  Text(
                                    "You have to pay",
                                    style:
                                        gilroySemiBoldTextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: Get.height * 0.0320),
                                  Row(
                                    children: [
                                      GetBuilder<CreateAdvertisementController>(
                                        id: "select",
                                        builder: (controller) {
                                          return (controller.totalAmount ==
                                                      null ||
                                                  controller.totalAmount == 0)
                                              ? Text(
                                                  "£10",
                                                  style: poppinsSemiBold(
                                                      fontSize: 64),
                                                )
                                              : Text(
                                                  "£${controller.totalAmount}",
                                                  style: poppinsSemiBold(
                                                      fontSize: 64),
                                                );
                                        },
                                      ),
                                      /*Padding(padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "00USD",
                                      style: poppinsSemiBold(fontSize: 12 ),
                                    ),
                                  ),*/
                                    ],
                                  ),
                                  // RichText(
                                  //   text: TextSpan(children: [
                                  //     TextSpan(
                                  //       text: amount,
                                  //       style: poppinsSemiBold(fontSize: 64),
                                  //     ),
                                  //     TextSpan(
                                  //       text: setupDateController.amountController.text,
                                  //       style: poppinsSemiBold(fontSize: 24),
                                  //     )
                                  //   ]),
                                  // ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorRes.black.withOpacity(0.5),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.0666),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.036,
                                  ),
                                  Text(
                                    "Payer’s Name",
                                    style: poppinsRegularBold(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.007389,
                                  ),
                                  Text(
                                    adHomeController.viewAdvertiserModel.data
                                            ?.fullName ??
                                        "",
                                    style: poppinsMediumBold(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0209,
                                  ),
                                  /* Text(
                                "Transaction Number",
                                style: poppinsRegularBold(fontSize: 12),
                              ),
                              SizedBox(
                                height: Get.height * 0.007389,
                              ),
                              Text(
                               // paymentController.viewCardModel?.data?.tokenId ?? "",
                                "id",
                                style: poppinsMediumBold(fontSize: 14),
                              ),
                              SizedBox(
                                height: Get.height * 0.0209,
                              ),*/
                                  Text(
                                    "Service",
                                    style: poppinsRegularBold(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.007389,
                                  ),
                                  Text(
                                    "Post Ads",
                                    style: poppinsMediumBold(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0480,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.066,
                      ),
                      SubmitButton(
                        onTap: () async {
                          createAdvertisementController.loader.value = true;
                          await paymentController.listCardApi(showToast: false);
                          createAdvertisementController.loader.value = false;
                          paymentController.listCardModel.data?.length == null
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        "Would you like to add card for your transaction?",
                                        style: gilroyBoldTextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            "No",
                                            style: gilroyBoldTextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "Yes",
                                            style: gilroyBoldTextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            // // AdHomeController adHomeController =
                                            // //     Get.find();
                                            // // adHomeController.update(["more"]);
                                            // // Get.deleteAll();
                                            // // Get.to(
                                            // //     () => AdvertisementDashBord());
                                            // // AdvertisementController
                                            // //     advertisementController =
                                            // //     Get.put(
                                            // //         AdvertisementController());
                                            // // advertisementController
                                            // //     .onBottomBarChange(1);
                                            // // advertisementController
                                            // //     .update(['bottom_bar']);
                                            // .
                                            // SystemNavigator.pop();
                                            // key =
                                            //     GlobalKey(debugLabel: "dash");
                                            Get.back();
                                            Get.back();
                                            Get.back();
                                            Get.back();
                                            Get.back();
                                            AddCartController
                                                addCartController =
                                                Get.put(AddCartController());
                                            addCartController.isRunPayment =
                                                true;
                                            // ispayment = true;
                                            advertisementController
                                                .onBottomBarChange(1);
                                            advertisementController
                                                .update(['bottom_bar']);
                                            // Get.to(
                                            //     () => AdvertisementDashBord());

                                            // Get.offAll(
                                            //     () => AdvertisementDashBord());
                                          },
                                        )
                                      ],
                                    );
                                  })
                              : await createAdvertisementController
                                  .onTapApiCalling();

                          // createAdvertisementController.loader.value = false;
                          //Get.to(() => PaymentSuccessfulScreen());
                          /* setupDateController.boostAdvertisementApi();*/
                        },
                        child: Text(
                          /*"Pay ${setupDateController.amountController.text}",*/
                          "Pay £$amount",
                          style: gilroyBoldTextStyle(
                            fontSize: 16,
                            color: ColorRes.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.0246,
                      ),
                      SubmitButton(
                        onTap: () {
                          Get.to(() => PaymentFailedScreen());
                        },
                        child: Text(
                          "Cancel",
                          style: gilroySemiBoldTextStyle(fontSize: 16),
                        ),
                        colors: const [
                          ColorRes.colorF86666,
                          ColorRes.colorF82222,
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.0320,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          createAdvertisementController.loader.value == true
              ? const FullScreenLoader()
              : const SizedBox(),
        ],
      ),
    );
  }
}
