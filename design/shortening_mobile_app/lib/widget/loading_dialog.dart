import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';

class LoadingDialog extends StatefulWidget {
  @override
  _LoadingDialogFormState createState() => _LoadingDialogFormState();
}

class _LoadingDialogFormState extends State<LoadingDialog> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSize.largeRadius),
        ),
        elevation: 0.0,
        insetPadding: EdgeInsets.only(
            right: ConstantSize.largePadding, left: ConstantSize.largePadding),
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(ConstantSize.largeRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  Text(StringValue.loadingText,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white)),
                ],
              ),
            )
          ],
        ));
  }
}
