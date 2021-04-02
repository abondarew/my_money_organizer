import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/viewmodel/common/currency_detail.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyDetailScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  final String currencyId;

  CurrencyDetailScreen({this.currencyId});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CurrencyDetailScreen> {
  UsesCurrencyDetailReadModel model;
  final CurrencyDetailViewModel viewModel = CurrencyDetailViewModelBuilder.build();
  bool _visibleSaveButton = false;

  //final GlobalKey<FormState> __key = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel.event.listen((event) => dispatch(event));
    viewModel.load(id: widget.currencyId);
    super.initState();
  }

  void dispatch(CurrencyDetailNotification event) {
    if (event is ResultCurrencyDetailNotification) {
      setState(() {
        model = event.currencyReadModel;
      });
    }
    if (event is CurrencyDetailChangeVisibleSaveButtonNotification) {
      setState(() {
        _visibleSaveButton = event.visibleSaveButton;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollHandledAppBar(
        scrollController: this.widget._scrollController,
        title: Text(S.of(context).currency_detail_title),
        /*Intl.message(
            'currency_detail',
            name: 'currency_detail_title',
            desc: '',
            args: [],
          )),*/ //
        action: [
          Visibility(
            child: IconButton(icon: Icon(Icons.save_alt), onPressed: viewModel.save),
            visible: _visibleSaveButton,
          ),
        ],
      ),
      body: Center(
        child: formBuild(),
      ),
    );
  }

  Widget formBuild() {
    if (!viewModel.isNew && model == null) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(S.of(context).loading),
          )
        ]),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: model?.id,
              onChanged: (value) => setModified(),
              onSaved: (value) => viewModel.updateData('id', value),
              decoration: InputDecoration(
                  labelText: S.of(context).code(S.of(context).currency),
                  hintText: S.of(context).code(''),
                  icon: Icon(Icons.monetization_on_outlined)),
              maxLength: 3,
              textCapitalization: TextCapitalization.characters,
            ),
            TextFormField(
              initialValue: model?.name,
              //onEditingComplete: setModified,
              onChanged: (value) => setModified(),
              onSaved: (value) => viewModel.updateData('name', value),
            )
          ],
        ),
      );
    }
  }

  setModified() {
    viewModel.setModified(true);
  }
}
