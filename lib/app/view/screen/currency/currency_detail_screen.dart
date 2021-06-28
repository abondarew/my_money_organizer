import 'dart:math';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/exception/create_command_exception.dart';
import 'package:mymoneyorganizer/app/view/common/card_with_avatar.dart';
import 'package:mymoneyorganizer/app/view/common/color_picker.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/viewmodel/currency/currency_detail.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyDetailScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  final String? currencyId;

  CurrencyDetailScreen({this.currencyId});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CurrencyDetailScreen> {
  final CurrencyDetailViewModel viewModel = CurrencyDetailViewModelBuilder.build();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _fractionController = TextEditingController();

  CurrencyDetailReadModel? model;
  Map<String, String?> _errorDetail = Map();
  bool _isModified = false;

  //List<Color> _colorList = [...Colors.primaries, ...Colors.accents];
  Color? dropdownValue;
  late Color _currentColor;

  @override
  void initState() {
    viewModel.event.listen((event) => dispatch(event));
    viewModel.load(id: widget.currencyId);
    _currentColor = Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade300,
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
        avatarText: '${_symbolController.text == '' ? ' ' : _symbolController.text}',
        /*Text(
          '${_symbolController.text == '' ? '?' : _symbolController.text}',
          style: TextStyle(
              fontSize: 400,
              fontWeight: FontWeight.bold,
              color: ColorUtils.contrastText(_currentColor, Colors.grey.shade100, Colors.grey.shade900)),
        ),*/
        avatarBackgroundColor: _currentColor,
        buttonChild: Icon(Icons.color_lens_rounded),
      ),
      floatingActionButton: (viewModel.isNew)
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
                ),
              },
            )
          : Container(),
    );
  }

  Widget formBuild() {
    if (!viewModel.isNew && model == null) {
      //wait data
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(S.of(context).loading),
            ),
          ],
        ),
      );
    } else {
      //output data
      if (!viewModel.isNew && !_isModified && model != null) {
        _idController.text = model!.id;
        _nameController.text = model!.name;
        _symbolController.text = model!.symbol;
        _fractionController.text = model!.fraction.toString();
      }
      return Column(
        children: [
          TextField(
            controller: _idController,
            readOnly: (!viewModel.isNew),
            enabled: (viewModel.isNew),
            maxLength: 3,
            textCapitalization: TextCapitalization.characters,
            onChanged: (val) => setModified(),
            decoration: InputDecoration(
              labelText: S.of(context).code(S.of(context).currency),
              hintText: S.of(context).code(''),
              errorBorder: _getErrorBorder(),
              counterText: '',
              errorText: _errorDetail['id'],
            ),
          ),
          TextField(
            controller: _nameController,
            onChanged: (val) => setModified(),
            decoration: InputDecoration(
              labelText: '${S.of(context).currency} ${S.of(context).name}',
              hintText: S.of(context).name,
              errorBorder: _getErrorBorder(),
              errorText: _errorDetail['name'],
            ),
          ),
          TextField(
            controller: _symbolController,
            onChanged: (value) => {
              setState(() {
                setModified();
              }),
            },
            decoration: InputDecoration(
                labelText: '${S.of(context).currency} ${S.of(context).symbol}',
                hintText: S.of(context).symbol,
                errorBorder: _getErrorBorder(),
                errorText: _errorDetail['symbol']),
          ),
          TextField(
            controller: _fractionController,
            onChanged: (val) => setModified(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: S.of(context).fraction,
              hintText: S.of(context).fraction,
              errorBorder: _getErrorBorder(),
              errorText: _errorDetail['fraction'],
            ),
          ),
          SizedBox(height: 32)
        ],
      );
    }
  }

  OutlineInputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
      ),
    );
  }

  void _pickColor() {
    Color _oldColor = _currentColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.color_lens),
              Text('${S.of(context).choice_color}'),
            ],
          ),
          content: Container(
            child: ColorPicker(
              pickerColor: _currentColor,
              onChanged: (color) => _setNewColor(color),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'cancel'), child: Text(S.of(context).cancel)),
            TextButton(onPressed: () => Navigator.pop(context, 'ok'), child: Text(S.of(context).ok)),
          ],
        );
      },
    ).then((value) => {if (value != 'ok') _setNewColor(_oldColor)});
  }

  void _setNewColor(Color color) {
    setState(() {
      _currentColor = color;
      setModified();
    });
  }

  void dispatch(CurrencyDetailNotification event) {
    if (event is ResultCurrencyDetailNotification) {
      model = event.currencyReadModel;
      if (!viewModel.isNew && model != null) {
        setState(() {
          _currentColor = Color(model!.avatarColor);
        });
      } else {
        _setNewColor(defaultAvailableColors[Random().nextInt(defaultAvailableColors.length - 1)]);
        _fractionController.text = '0';
      }
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
        CurrencyCreateCommandException error = event.error as CurrencyCreateCommandException;
        setState(() {
          _errorDetail['id'] = error.id.length > 0 ? error.id.first : null;
          _errorDetail['name'] = error.name.length > 0 ? error.name.first : null;
          _errorDetail['symbol'] = error.symbol.length > 0 ? error.symbol.first : null;
          _errorDetail['fraction'] = error.fraction.length > 0 ? error.fraction.first : null;
        });
      } else {
        SnackBar snackBar = SnackBar(content: Text(S.of(context).unknown_error + event.error.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  saveData() {
    viewModel.updateData('id', _idController.text);
    viewModel.updateData('name', _nameController.text);
    viewModel.updateData('symbol', _symbolController.text);
    viewModel.updateData('fraction', int.tryParse(_fractionController.text));
    viewModel.updateData('color', _currentColor.value);
    viewModel.updateData('isDefault', false);
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
