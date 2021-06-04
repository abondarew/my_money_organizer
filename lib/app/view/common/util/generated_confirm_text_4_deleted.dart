import 'package:mymoneyorganizer/generated/l10n.dart';

String buildTextToConfirmDelete({List<String>? confirmData, String what = '', int viewEntities = 3}) {
  if (confirmData == null || !(confirmData is List<String>)) return '';
  if (confirmData.length <= viewEntities) {
    return S.current.confirm_text('${what.toLowerCase()}:', confirmData.join(', '));
  } else {
    return S.current.confirm_text_more(
        '${what.toLowerCase()}:', confirmData.take(viewEntities).join(', '), confirmData.length - viewEntities);
  }
}
