import 'package:shortening_mobile_app/constant/constant_images.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';

class AdvanceNote {
  String title;
  String description;
  String iconAddress;

  AdvanceNote({this.title, this.description, this.iconAddress});
}

class AdvanceNoteList {
  List<AdvanceNote> list = [
    AdvanceNote(
        title: StringValue.advancedListTitleFirst,
        description: StringValue.advancedListDescriptionFirst,
        iconAddress: ImageAddress.brandRecognitionIcon),
    AdvanceNote(
        title: StringValue.advancedListTitleSecond,
        description: StringValue.advancedListDescriptionSecond,
        iconAddress: ImageAddress.detailedRecordsIcon),
    AdvanceNote(
        title: StringValue.advancedListTitleThird,
        description: StringValue.advancedListDescriptionThird,
        iconAddress: ImageAddress.fullyCustomizableIcon),
  ];
}
