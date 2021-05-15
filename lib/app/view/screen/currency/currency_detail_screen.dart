import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/currency/command/validator/exception/create_command_exception.dart';
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _fractionController = TextEditingController();

  CurrencyDetailReadModel model;
  Map<String, String> _errorDetail = Map();
  bool _visibleSaveButton = false;
  List<Color> options = Colors.primaries;
  Color dropdownValue; // = Colors.red;

  @override
  void initState() {
    viewModel.event.listen((event) => dispatch(event));
    viewModel.load(id: widget.currencyId);
    super.initState();
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
            child: IconButton(icon: Icon(Icons.save_alt), onPressed: () => saveData()),
            visible: _visibleSaveButton,
          ),
        ],
      ),
      body: Center(
        child: formBuild(),
      ),
      floatingActionButton: viewModel.isNew
          ? FloatingActionButton(
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
      //print('id: ${model?.id}');
      if (!viewModel.isNew) {
        _idController.text = model?.id;
        _nameController.text = model?.name;
        _symbolController.text = model?.symbol;
        _fractionController.text = model?.fraction.toString();
      }
      return Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _key,
                onChanged: setModified,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _idController,
                      //initialValue: model?.id,
                      readOnly: (!viewModel.isNew),
                      enabled: (viewModel.isNew),
                      onSaved: (value) => viewModel.updateData('id', value.toString()),
                      validator: (value) => _errorDetail['id'],
                      decoration: InputDecoration(
                        labelText: S.of(context).code(S.of(context).currency),
                        hintText: S.of(context).code(''),
                        counterText: '',
                        icon: CircleAvatar(
                          backgroundColor: dropdownValue,
                          child: Text('${_symbolController.text}'),
                        ),
                      ),
                      //Icon(Icons.monetization_on_outlined)),
                      maxLength: 3,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    TextFormField(
                      controller: _nameController,
                      //initialValue: model?.name,
                      validator: (value) => _errorDetail['name'],
                      onSaved: (value) => viewModel.updateData('name', value.toString()),
                      decoration: InputDecoration(
                        labelText: '${S.of(context).currency} ${S.of(context).name}',
                        hintText: S.of(context).name,
                      ),
                    ),
                    TextFormField(
                      controller: _symbolController,
                      //initialValue: model?.symbol,
                      validator: (value) => _errorDetail['symbol'],
                      onSaved: (value) => viewModel.updateData('symbol', value.toString()),
                      decoration: InputDecoration(
                        labelText: '${S.of(context).currency} ${S.of(context).symbol}',
                        hintText: S.of(context).symbol,
                      ),
                    ),
                    TextFormField(
                      controller: _fractionController,
                      //initialValue: model == null ? '2' : model.fraction.toString(),
                      validator: (value) => _errorDetail['fraction'],
                      onSaved: (value) => viewModel.updateData('fraction', int.parse(value)),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: S.of(context).fraction,
                        hintText: S.of(context).fraction,
                      ),
                    ),
                    Row(
                      children: [
                        Text('Select color:'),
                        Spacer(
                          flex: 1,
                        ),
                        _buildDropdownButton(),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
    }
  }

  Widget _buildDropdownButton() {
    return DropdownButton<Color>(
      hint: (Text('Choice colour:')),
      value: dropdownValue,
      onChanged: (Color newValue) {
        setState(() {
          dropdownValue = newValue;
          //_visibleSaveButton = true;
          viewModel.setModified(true);
          viewModel.updateData('color', dropdownValue.value);
        });
      },
      style: const TextStyle(color: Colors.blue),
      selectedItemBuilder: (BuildContext context) {
        return options.map((Color value) {
          return CircleAvatar(
            maxRadius: 10,
            backgroundColor: dropdownValue,
          );
        }).toList();
      },
      items: options.map<DropdownMenuItem<Color>>((Color value) {
        return DropdownMenuItem<Color>(
          value: value,
          child: Row(
            children: [
              Container(
                color: value,
                width: 25,
                height: 25,
              ),
              Text(value.toString()),
            ],
          ),
        );
      }).toList(),
    );
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
    if (event is SuccessfulSaveCurrency) {
      Navigator.pop(context);
    }
    if (event is ErrorCurrencyDetailNotification) {
      if (event.error is CurrencyCreateCommandException) {
        CurrencyCreateCommandException error = event.error;
        _errorDetail['id'] = error.id.length > 0 ? error.id.first : '';
        _errorDetail['name'] = error.name.length > 0 ? error.name.first : '';
        _errorDetail['symbol'] = error.symbol.length > 0 ? error.symbol.first : '';
        _errorDetail['fraction'] = error.fraction.length > 0 ? error.fraction.first : '';
        _key.currentState.validate();
      } else {
        SnackBar snackBar = SnackBar(content: Text(S.of(context).unknown_error + event.error.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  saveData() {
    _key.currentState.save();
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
