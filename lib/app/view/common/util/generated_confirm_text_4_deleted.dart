import 'package:mymoneyorganizer/app/lib/localization/utils.dart';

String buildTextToConfirmDelete({List<String>? confirmData, String what = '', int viewEntities = 3}) {
  if (confirmData == null) return '';
  if (confirmData.length <= viewEntities) {
    return t('common.confirm.text', args: {
      'what': what.toLowerCase(),
      'records': confirmData.join(', '),
    });
  } else {
    return t('common.confirm.text.more', args: {
      'what': what.toLowerCase(),
      'records': confirmData.take(viewEntities),
      'quantity': confirmData.length - viewEntities,
    });
  }
}
