import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/auth/auth_dashboard/api/google_id_verification_api.dart';
import 'package:rainbow_new/screens/auth/login/login_api/login_api.dart';
import 'package:rainbow_new/screens/auth/login/login_api/login_json.dart';
import 'package:rainbow_new/screens/auth/register/list_nationalites/list_nationalites_api.dart';
import 'package:rainbow_new/screens/auth/register/register_controller.dart';
import 'package:rainbow_new/screens/auth/register/register_screen.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/listOfCountry/list_of_country_api.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/register_adviser.dart';
import 'package:rainbow_new/service/notification_service.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';
import 'package:rainbow_new/utils/strings.dart';
import '../login/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
class AuthDashBordController extends GetxController {
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    countryName();
    countryNationalites();
    update(["auth"]);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> countryName() async {
    try {
      await ListOfCountryApi.postRegister()
          .then((value) => listCountryModel = value!);

      getCountry();

    } catch (e) {
      /*   errorToast(e.toString());*/
      debugPrint(e.toString());
    }
  }

  Future<void> countryNationalites() async {
    try {
      await ListOfNationalitiesApi.postRegister()
          .then((value) => listNationalities = value!);

      getCountryNation();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

String? token;
  Future signWithGoogle() async {
    // GoogleIdVerification.postRegister(user.uid).then((value) {print(value);});
    HomeController homeController = Get.put(HomeController());
    AdHomeController adHomeController = Get.put(AdHomeController());
    ConnectionsController connectionsController = Get.put(ConnectionsController());

    adHomeController.viewAdvertiserModel.data?.profilePhoto = null;
    adHomeController.viewAdvertiserModel.data?.fullName = "";
    adHomeController.viewAdvertiserModel.data?.profileImage = "";
    adHomeController.viewAdvertiserModel.data?.email = "";

    homeController.viewProfile.data = null;
    homeController.controller.viewProfile.data?.profileImage = null;
    homeController.controller.viewProfile.data?.profileImage = null;
    homeController.notificationModel?.pendingCount = 0;
    homeController.controller.viewProfile.data?.profileImage = "";
    connectionsController.requestUsers.length = 0;
    connectionsController.requestUsers = [];
    homeController.myStoryController.viewStoryController.storyModel.myStory = null;
    homeController.viewStoryController.storyModel.friendsStory = null;
    homeController.viewStoryController.storyModel.friendsStory?.length = 0;
    homeController.friendPostListData = [];

    try {
      loading.value = true;
      token = await NotificationService.getFcmToken();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
        //flutterToast(Strings.googleLogOutSuccess);
      }

      loading.value = true;
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication = await account!.authentication;


      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );


      final UserCredential authResult =
      await auth.signInWithCredential(credential);
      final User? user = authResult.user;
      print(user!.email);
      print(user.uid);
      print(user.tenantId);
      print(user.displayName);
      await GoogleIdVerification.postRegister(user.uid, user: user,email: user.email.toString())
          .then((LoginModel? model) async {
        LoginApi.updateDeviceToken();
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .get()
            .then((value) async {
          if (value.exists) {
            await firebaseFirestore
                .collection("users")
                .doc(user.uid)
                .update({"online": true,"id":model?.data?.id, "UserToken": token.toString()});
            await PrefService.setValue(PrefKeys.uid, user.uid);
          } else {
            await firebaseFirestore.collection("users").doc(user.uid).set({
              "id": model?.data?.id,
              "email": user.email,
              "uid": user.uid,
              "name": user.displayName,
              "image": user.photoURL,
              "UserToken": token.toString(),
              "online": true,
            });
          }
        });
      });
      loading.value = false;
    } catch (e) {
      loading.value = false;
      /*  errorToast(e.toString());*/
      debugPrint(e.toString());
      loading.value = false;
    }
    loading.value = false;

    //flutterToast(Strings.googleSignInSuccess);
  }

  void onSignInTap() {
    Get.
    to(() => LoginScreen(), transition: Transition.cupertino);
  }

  void faceBookSignIn() async {
    HomeController homeController = Get.put(HomeController());
    AdHomeController adHomeController = Get.put(AdHomeController());

    adHomeController.viewAdvertiserModel.data?.profilePhoto = null;
    adHomeController.viewAdvertiserModel.data?.fullName = "";
    adHomeController.viewAdvertiserModel.data?.profileImage = "";
    adHomeController.viewAdvertiserModel.data?.email = "";
    homeController.viewProfile.data = null;
    homeController.controller.viewProfile.data?.profileImage = null;
    homeController.controller.viewProfile.data?.profileImage = null;

    homeController.controller.viewProfile.data?.profileImage = "";

    homeController.viewStoryController.storyModel.friendsStory = null;
    homeController.viewStoryController.storyModel.friendsStory?.length = 0;
    homeController.friendPostListData = [];

    try {
      loading.value = true;
      token = await NotificationService.getFcmToken();
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ["email", "public_profile"]);
      await FacebookAuth.instance.getUserData();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token,);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      final User? user = userCredential.user;
      print("${userCredential.user!.email.toString()}");
      try {
        await GoogleIdVerification.postRegister(userCredential.user!.uid,
            user: userCredential.user,email: userCredential.user!.email.toString())
            .then((LoginModel? model) async {

          LoginApi.updateDeviceToken();
          await firebaseFirestore
              .collection("users")
              .doc(user!.uid)
              .get()
              .then((value) async {
            if (value.exists) {
              await firebaseFirestore
                  .collection("users")
                  .doc(user.uid)
                  .update({"online": true,   "id": model?.data?.id, "UserToken": token.toString()});
              await PrefService.setValue(PrefKeys.uid, user.uid);
            } else {
              await firebaseFirestore.collection("users").doc(user.uid).set({
                "id": model?.data?.id,
                "email": user.email,
                "uid": user.uid,
                "name": user.displayName,
                "image": user.photoURL,
                "online": true,
                "UserToken": token.toString()
              });
            }
          });
        });
      } catch (e) {
        errorToast(e.toString());
        debugPrint(e.toString());
        loading.value = false;
      }
      loading.value = false;
      flutterToast(Strings.faceBookSignInSuccess);
    } catch (e) {
      loading.value = false;
    }
  }

  void onContinueWithEmailTap() {
    final RegisterController controller = Get.put(RegisterController());
    controller.isSocial = false;

    controller.fullNameController.clear();
    controller.emailController.clear();

    countryNationalites();
    Get.to(() => RegisterScreen());
  }

  void onSignUpTap() {
    Get.to(() => AdviserRegisterScreen());
  }

  final _firebaseAuth = FirebaseAuth.instance;
   signInWithAppleC(BuildContext context) async {
    try {
      final user = await signInWithApple(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
    } catch (e) {
      //print(e);
    }
  }

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential!.identityToken ?? []),
          accessToken:
          String.fromCharCodes(appleIdCredential.authorizationCode ?? []),
        );
        final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user;
     /*   if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser!.updateDisplayName(displayName);
          }
        }*/
        final User? user = userCredential.user;
        try {
          await GoogleIdVerification.postRegister(userCredential.user!.uid,
              user: userCredential.user,email: userCredential.user!.email.toString())
              .then((LoginModel? model) async {

            LoginApi.updateDeviceToken();
            await firebaseFirestore
                .collection("users")
                .doc(user!.uid)
                .get()
                .then((value) async {
              if (value.exists) {
                await firebaseFirestore
                    .collection("users")
                    .doc(user.uid)
                    .update({"online": true,   "id": model?.data?.id, "UserToken": token.toString()});
                await PrefService.setValue(PrefKeys.uid, user.uid);
              } else {
                await firebaseFirestore.collection("users").doc(user.uid).set({
                  "id": model?.data?.id,
                  "email": user.email,
                  "uid": user.uid,
                  "name": user.displayName==null?"":user.displayName,
                  "image": user.photoURL,
                  "online": true,
                  "UserToken": token.toString()
                });
              }
            });
          });
          print("DisplayNAme==========================###################### ${user!.displayName}");
        } catch (e) {
          errorToast(e.toString());
          debugPrint(e.toString());
          loading.value = false;
        }
        return firebaseUser!;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }

  }


}
