
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_setup/Utils/ImportFile.dart';
import 'package:http/http.dart' as http;





class MyGlobalKeys{
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

}
class CommonWidgets {
  static String cur = "RM";
  // static final isConnect = false.obs;
  final Connectivity connectivity = Connectivity();

  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  ///For Check Post Api Response
  static Future<bool> responseCheckForPostMethod(
      {http.Response? response, bool wantSnackBar = true}) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.message]);
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.error]);
      }
    }
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  ///For Check Get Api Response
  static Future<bool> responseCheckForGetMethod({
    http.Response? response,
    bool wantSuccessToast = false,
    bool wantErrorToast = true,
    // BuildContext context
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null && response.statusCode == 200) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarView(
      {String title = ''}) {
    var snackBar = SnackBar(
      content: Text(title),
      // backgroundColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.onSecondary,
    );
  
    return ScaffoldMessenger.of(MyGlobalKeys.navigatorKey!.currentContext!)
        .showSnackBar
      (snackBar);
  }

  static AppBar appBarView(
      {String? title,
        GestureTapCallback? onTap,
        bool wantBackButton = true,
        List<Widget>? actions,
        Widget? leading}) {
    return AppBar(
      backgroundColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).scaffoldBackgroundColor,
      elevation: 0.px,
      leading: wantBackButton
          ? GestureDetector(
        onTap: onTap ??
                () {
              Navigator.pop(MyGlobalKeys.navigatorKey!.currentContext!) ;
            },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(IconConstants.icBack,
                width: 34.px, height: 34.px),
          ],
        ),
      )
          : leading,
      centerTitle: true,
      actions: actions,
      title: Text(
        title ?? '',
        style: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 20.px),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64.px,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.px),
        child: Image.network(
          image,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              color:
              Theme.of(context).colorScheme.onSecondary.withOpacity(.2.px),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.px),
                child: Icon(Icons.error, color: Theme.of(context).primaryColor),
              ),
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return SizedBox(
              height: height ?? 64.px,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context)
                    .colorScheme
                    .onSecondary
                    .withOpacity(.4.px),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(.4.px),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton(
      {double? height,
        double? width,
        EdgeInsetsGeometry? buttonMargin,
        EdgeInsetsGeometry? contentPadding,
        double? borderRadius,
        Color? splashColor,
        bool wantContentSizeButton = false,
        Color? buttonColor,
        TextStyle? textStyle,
        double? elevation,
        ButtonStyle? style,
        BoxBorder? border,
        required BuildContext context,
        required VoidCallback onPressed,
        required Widget child}) {
    return Container(
      height: wantContentSizeButton ? height : 50.px,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 4.px),
        border: border,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ??
            ElevatedButton.styleFrom(
              elevation: elevation ?? 0.px,
              padding: contentPadding,
              textStyle: textStyle ??
                  Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 30.px),
              ),
              backgroundColor:
              buttonColor ?? Theme.of(context).colorScheme.primary,
              foregroundColor:
              splashColor ?? Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Colors.transparent,
            ),
        child: child,
      ),
    );
  }

  static Widget commonTextFieldForLoginSignUP(
      {double? elevation,
        String? hintText,
        String? labelText,
        String? errorText,
        EdgeInsetsGeometry? contentPadding,
        TextEditingController? controller,
        int? maxLines,
        double? cursorHeight,
        bool wantBorder = false,
        ValueChanged<String>? onChanged,
        FormFieldValidator<String>? validator,
        Color? fillColor=const Color(0xffF8F8F8),
        Color? initialBorderColor,
        double? initialBorderWidth,
        TextInputType? keyboardType,
        double? borderRadius,
        double? maxHeight,
        TextStyle? hintStyle,
        TextStyle? style,
        TextStyle? labelStyle,
        TextStyle? errorStyle,
        List<TextInputFormatter>? inputFormatters,
        TextCapitalization textCapitalization = TextCapitalization.none,
        bool autofocus = false,
        bool readOnly = false,
        bool hintTextColor = false,
        Widget? suffixIcon,
        Widget? prefixIcon,
        AutovalidateMode? autoValidateMode,
        int? maxLength,
        GestureTapCallback? onTap,
        bool obscureText = false,
        FocusNode? focusNode,
        bool? filled,
        ValueChanged<String>? onFieldSubmitted,
        bool isCard = false}) {
    return Material(
      elevation: isCard ? 4 : 0,
      borderRadius: BorderRadius.circular(15.px),
      shadowColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor,
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        onTap: onTap,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        cursorHeight: cursorHeight,
        cursorColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor,
        autovalidateMode: autoValidateMode,
        controller: controller,
        onChanged: onChanged ??
                (value) {
              value = value.trim();
              if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                controller?.text = "";
              }
            },
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.streetAddress,
        readOnly: readOnly,
        autofocus: autofocus,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: style ??
            Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.titleMedium?.copyWith(
              color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor,
            ),
        decoration: InputDecoration(

          errorText: errorText,
          counterText: '',
          errorStyle: errorStyle ??
              Theme.of(MyGlobalKeys.navigatorKey!.currentContext!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.error),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          fillColor:
          fillColor ?? Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).scaffoldBackgroundColor,
          filled: filled ?? true,
          contentPadding:
          contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
          hintStyle: hintStyle ??
              Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.titleMedium?.copyWith(
                  color: hintTextColor
                      ? Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor
                      : Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.titleMedium?.color),
          disabledBorder: OutlineInputBorder(
            borderSide: wantBorder
                ? BorderSide(
                color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.onSurface,
                width: 2.px)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(
              borderRadius ?? 15.px,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: wantBorder
                  ? BorderSide(
                  color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor, width: 2.px)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 4.px)),
          enabledBorder: OutlineInputBorder(
              borderSide: wantBorder
                  ? BorderSide(
                  color: initialBorderColor ??
                      Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor,
                  width: initialBorderWidth ?? 2.px)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 4.px)),
          errorBorder: OutlineInputBorder(
              borderSide: wantBorder
                  ? BorderSide(
                  color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.onError,
                  width: 2.px)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 4.px)),
        ),
      ),
    );
  }

  static pinCode({
    StreamController<ErrorAnimationType>? errorAnimationController,
    TextEditingController? controller,
  }) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: (MyGlobalKeys.navigatorKey!.currentContext!),
      length: 4,
      hintStyle: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.titleMedium,
      hintCharacter: "_",
      blinkDuration: const Duration(milliseconds: 200),
      enablePinAutofill: true,
      textStyle: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.headlineMedium?.copyWith(
          color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.titleMedium?.color,
          fontSize: 20.px),
      cursorColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.primary,
      keyboardType: TextInputType.number,
      readOnly: false,
      blinkWhenObscuring: true,
      autoDisposeControllers: false,
      animationType: AnimationType.none,
      pinTheme: PinTheme(
        inactiveColor: Colors.grey.withOpacity(0.8),
        inactiveFillColor: Colors.transparent,
        activeColor: Colors.grey.withOpacity(0.8),
        activeFillColor: Colors.transparent,
        selectedColor: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.primary,
        selectedFillColor: Colors.transparent,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      //errorAnimationController: errorAnimationController,
      controller: controller,
      onChanged: (value) {
        //  currentText.value = value;
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }

  static Widget dataNotFound() {
    return Text(
      StringConstants.dataNotFound,
      textAlign: TextAlign.center,
      style: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).textTheme.displayMedium?.copyWith(
        fontSize: 24.px,
      ),
    );
  }

  static Widget safeAreaForScreens(
      {bool wantSafeArea = true, required Widget child}) {
    return wantSafeArea
        ? Container(
      color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).scaffoldBackgroundColor,
      child: SafeArea(child: child),
    )
        : child;
  }

  static void showAlertDialog(
      {String title = StringConstants.logout,
        String content = StringConstants.wouldYouLikeToLogout,
        VoidCallback? onPressedYes}) {
    showCupertinoModalPopup<void>(
      context: MyGlobalKeys.navigatorKey!.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(MyGlobalKeys.navigatorKey!.currentContext!),
            child: const Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }

  static void showAlertDialogWithOk(
      {String title = StringConstants.logout,
        String content = StringConstants.wouldYouLikeToLogout,
        VoidCallback? onPressedYes}) {
    showCupertinoModalPopup<void>(
      context: MyGlobalKeys.navigatorKey!.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text(StringConstants.ok),
          ),
        ],
      ),
    );
  }

  static progressBarView() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor:
        Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.onSecondary.withOpacity(.2),
        color: Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor,
        strokeCap: StrokeCap.round,
        strokeWidth: 6.px,
      ),
    );
  }

  static prefixIconWidget({required String iconName, bool? colorValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          height: 18.px,
          width: 18.px,
          iconName,
          color: colorValue ?? false
              ? Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).primaryColor
              : Theme.of(MyGlobalKeys.navigatorKey!.currentContext!).colorScheme.onSecondary,
        ),
      ],
    );
  }
}

enum ErrorAnimationType { shake, clear }
