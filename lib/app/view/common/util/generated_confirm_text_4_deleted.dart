import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

String buildTextToConfirmDelete({List<String>? confirmData, String what = '', int viewEntities = 3}) {
  if (confirmData == null || !(confirmData is List<String>)) return '';
  if (confirmData.length <= viewEntities) {
    return t('confirm_text', args: {'what': what}); //TODO, ('${what.toLowerCase()}:', confirmData.join(', ')));
  } else {
    return t(
        'confirm_text_more'); //TODO ('${what.toLowerCase()}:', confirmData.take(viewEntities).join(', '), confirmData.length - viewEntities);
  }
}
