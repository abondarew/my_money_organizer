import 'dart:math';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/exception/create_command_exception.dart';
import 'package:mymoneyorganizer/app/view/common/card_with_avatar.dart';
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
  final CurrencyDetailViewModel viewModel = CurrencyDetailViewModelBuilder.build();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _fractionController = TextEditingController();

  CurrencyDetailReadModel model;
  Map<String, String> _errorDetail = Map();
  bool _isModified = false;
  List<Color> _colorList = [...Colors.primaries, ...Colors.accents];
  Color dropdownValue; // = Colors.red;
  Color _currentColor;

  @override
  void initState() {
    viewModel.event.listen((event) => dispatch(event));
    viewModel.load(id: widget.currencyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: ScrollHandledAppBar(
        scrollController: this.widget._scrollController,
        title: Text(S.of(context).currency_detail_title),
        action: [
          Visibility(
            child: IconButton(icon: Icon(Icons.save_alt), onPressed: () => saveData()),
            visible: _isModified,
          ),
        ],
      ),
      body: CardWithAvatar(
        cardBody: formBuild(),
        onTap: () => _pickColor(),
        avatarChild: Text(
          '${_symbolController.text == '' ? '?' : _symbolController.text}',
          style: TextStyle(fontSize: 400, fontWeight: FontWeight.bold),
        ),
        avatarBackgroundColor: _currentColor,
        buttonChild: Icon(Icons.color_lens_rounded),
      ),
      floatingActionButton: viewModel.isNew
          ? FloatingActionButton(
              heroTag: 'selectFromList',
              child: Icon(Icons.list_sharp),
              onPressed: () => {
                showCurrencyPicker(
                  context: context,
                  onSelect: (Currency currency) {
                    setState(() {
                      _idController.text = currency.code;
                      _nameController.text = currency.name;
                      _symbolController.text = currency.symbol;
                      _fractionController.text = currency.decimalDigits.toString();
                    });
                  },
                  showCurrencyCode: true,
                  showCurrencyName: true,
                  showFlag: true,
                )
              },
            )
          : Container(),
    );
  }

  Widget formBuild() {
    if (!viewModel.isNew && model == null) {
      //wait data
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
      //output data
      if (!viewModel.isNew && !_isModified) {
        _idController.text = model?.id;
        _nameController.text = model?.name;
        _symbolController.text = model?.symbol;
        _fractionController.text = model?.fraction.toString();
      }
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 56, 16, 16),
        child: Form(
          key: _formKey,
          onChanged: setModified,
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                    helperText: 'helper text',
                    hintText: 'hint text',
                    suffixText: 'suffix',
                    prefixText: 'prefix',
                    labelText: 'label',
                    errorText: _errorDetail['id']),
              ),
              TextFormField(
                controller: _idController,
                readOnly: (!viewModel.isNew),
                enabled: (viewModel.isNew),
                onSaved: (value) => viewModel.updateData('id', value.toString()),
                validator: (value) => _errorDetail['id'],
                decoration: InputDecoration(
                  labelText: S.of(context).code(S.of(context).currency),
                  hintText: S.of(context).code(''),
                  counterText: '',
                ),
                maxLength: 3,
                textCapitalization: TextCapitalization.characters,
              ),
              TextFormField(
                controller: _nameController,
                validator: (value) => _errorDetail['name'],
                onSaved: (value) => viewModel.updateData('name', value.toString()),
                decoration: InputDecoration(
                  labelText: '${S.of(context).currency} ${S.of(context).name}',
                  hintText: S.of(context).name,
                ),
              ),
              TextFormField(
                controller: _symbolController,
                validator: (value) => _errorDetail['symbol'],
                onSaved: (value) => viewModel.updateData('symbol', value.toString()),
                onChanged: (value) => {setState(() {})},
                decoration: InputDecoration(
                  labelText: '${S.of(context).currency} ${S.of(context).symbol}',
                  hintText: S.of(context).symbol,
                ),
              ),
              TextFormField(
                controller: _fractionController,
                validator: (value) => _errorDetail['fraction'],
                onSaved: (value) => viewModel.updateData('fraction', int.tryParse(value)),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: S.of(context).fraction,
                  hintText: S.of(context).fraction,
                ),
              ),
              SizedBox(height: 32)
            ],
          ),
        ),
      );
    }
  }

  void _pickColor() {
    print('tap-tap');
    _currentColor = Colors.red;
    //_cardKey.currentState.setBackgroundColor(_currentColor);
    setState(() {
      //_cardKey.currentState.setState(() {});
    });
  }

  void _test({@required String tes}) {}

  void dispatch(CurrencyDetailNotification event) {
    if (event is ResultCurrencyDetailNotification) {
      setState(() {
        model = event.currencyReadModel;
        if (!viewModel.isNew) {
          _currentColor = Color(model?.avatarColor);
          //_cardKey.currentState.setBackgroundColor(_currentColor);
        } else {
          _currentColor = _colorList[Random().nextInt(_colorList.length - 1)];
          //_cardKey.currentState.setBackgroundColor(_currentColor);
          viewModel.updateData('color', _currentColor.value);
        }
      });
    }
    if (event is CurrencyDetailModifiedNotification) {
      setState(() {
        _isModified = event.isModified;
      });
    }
    if (event is SuccessfulSaveCurrency) {
      Navigator.pop(context);
    }
    if (event is ErrorCurrencyDetailNotification) {
      if (event.error is CurrencyCreateCommandException) {
        CurrencyCreateCommandException error = event.error;
        _errorDetail['id'] = error.id.length > 0 ? error.id.first : null;
        _errorDetail['name'] = error.name.length > 0 ? error.name.first : null;
        _errorDetail['symbol'] = error.symbol.length > 0 ? error.symbol.first : null;
        _errorDetail['fraction'] = error.fraction.length > 0 ? error.fraction.first : null;
        _formKey.currentState.validate();
      } else {
        SnackBar snackBar = SnackBar(content: Text(S.of(context).unknown_error + event.error.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  saveData() {
    _formKey.currentState.save();
    viewModel.save();
  }

  setModified() {
    viewModel.setModified(true);
  }

  @override
  void dispose() {
    viewModel.dispose();
    _idController.dispose();
    _nameController.dispose();
    _symbolController.dispose();
    _fractionController.dispose();
    super.dispose();
  }
}
