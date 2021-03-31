import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyDetailScreen extends StatefulWidget{
  final ScrollController _scrollController = ScrollController();
  final String currencyId;
  CurrencyDetailScreen({this.currencyId});
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CurrencyDetailScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollHandledAppBar(
        scrollController: this.widget._scrollController,
        title: Text(S.of(context).currency_detail_title),
      ),
    );
  }

}