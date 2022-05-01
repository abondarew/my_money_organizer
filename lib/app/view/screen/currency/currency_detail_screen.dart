import 'dart:math';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/exception/create_command_exception.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';
import 'package:mymoneyorganizer/app/view/common/app_bar/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/common/dialog/color_picker.dart';
import 'package:mymoneyorganizer/app/view/common/widget/card_with_avatar_old.dart';
import 'package:mymoneyorganizer/app/viewmodel/currency/currency_detail.dart';

class CurrencyDetailScreen extends StatefulWidget {
  static const String routeName = '/currencyDetail';
  final ScrollController _scrollController = ScrollController();
  final String? currencyId;

  CurrencyDetailScreen({Key? key, this.currencyId}) : super(key: key);

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
  final Map<String, String?> _errorDetail = {};
  bool _isModified = false;

  Color? dropdownValue;
  late Color _currentColor;

  @override
  void initState() {
    viewModel.event.listen((event) => dispatch(event));
    viewModel.load(id: widget.currencyId);
    _currentColor = Colors.transparent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollHandledAppBar(
        scrollController: widget._scrollController,
        title: Text(t('currency.form.title.detail').toTitleCase()),
        action: [
          Visibility(
            child: IconButton(
              icon: const Icon(Icons.save_alt),
              onPressed: () => saveData(),
            ),
            visible: _isModified,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: CardWithAvatarOld(
          cardBody: formBuild(),
          avatarSetting: AvatarSetting(
            onTap: () => _pickColor(),
            avatarText: _symbolController.text.isEmpty ? ' ' : _symbolController.text,
            avatarBackgroundColor: _currentColor,
            badge: Icons.color_lens_outlined,
          ),
        ),
      ),
      floatingActionButton: (viewModel.isNew) ? _buildFloatingActionButton(context) : Container(),
    );
  }

  StatelessWidget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'selectFromList',
      child: const Icon(Icons.list_sharp),
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
    );
  }

  Widget formBuild() {
    if (!viewModel.isNew && model == null) {
      //wait data
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(t('common.wait')),
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
              labelText: t('currency.form.code'),
              hintText: t('currency.form.code.hint'),
              errorBorder: _getErrorBorder(),
              counterText: '',
              errorText: _errorDetail['id'],
            ),
          ),
          TextField(
            controller: _nameController,
            onChanged: (val) => setModified(),
            decoration: InputDecoration(
              labelText: t('currency.form.name'),
              hintText: t('currency.form.name.hint'),
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
              labelText: t('currency.form.symbol'),
              hintText: t('currency.form.symbol.hint'),
              errorBorder: _getErrorBorder(),
              errorText: _errorDetail['symbol'],
            ),
          ),
          TextField(
            controller: _fractionController,
            onChanged: (val) => setModified(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: t('currency.form.fraction'),
              hintText: t('currency.form.fraction.hint'),
              errorBorder: _getErrorBorder(),
              errorText: _errorDetail['fraction'],
            ),
          ),
          const SizedBox(height: 32)
        ],
      );
    }
  }

  OutlineInputBorder _getErrorBorder() {
    return const OutlineInputBorder(
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
              const Icon(Icons.color_lens),
              Text(t('currency.form.dialog.choice_color')),
            ],
          ),
          content: ColorPicker(
            pickerColor: _currentColor,
            onChanged: (color) => _setNewColor(color),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'cancel'), child: Text(t('common.button.cancel'))),
            TextButton(onPressed: () => Navigator.pop(context, 'ok'), child: Text(t('common.button.ok'))),
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
          _errorDetail['id'] = error.id.isNotEmpty ? error.id.first : null;
          _errorDetail['name'] = error.name.isNotEmpty ? error.name.first : null;
          _errorDetail['symbol'] = error.symbol.isNotEmpty ? error.symbol.first : null;
          _errorDetail['fraction'] = error.fraction.isNotEmpty ? error.fraction.first : null;
        });
      } else {
        SnackBar snackBar = SnackBar(content: Text(t('errors.common.unknown_error') + event.error.toString()));
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
