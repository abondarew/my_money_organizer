import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/common/currency_list.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyListScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CurrencyListScreen> {
  final List<CurrencyListReadModel> currencyList = [];
  final CurrencyListViewModel viewModel = CurrencyListViewModelBuilder.build();

  @override
  void initState() {
    viewModel.event.listen((CurrencyListNotification event) {
      dispatch(event);
    });
    EventBusCore.getInstance().events.listen((event) {
      if(event is CurrencyChangedEvent){
        viewModel.load();
      }
    });
    viewModel.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollHandledAppBar(
        title: Text(S.of(context).currency_list_title),
        scrollController: this.widget._scrollController,
      ),
      body: ListView.builder(
        controller: this.widget._scrollController,
        itemBuilder: (context, index) {
          CurrencyListReadModel currencyReadModel = currencyList[index];
          return ListTile(
            title: Text(currencyReadModel.name),
            subtitle: Text(currencyReadModel.id),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrencyDetailScreen(
                    currencyId: currencyReadModel.id,
                  ),
                ),
              ),
            },
          );
        },
        itemCount: currencyList.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
        },
      ),
    );
  }

  void dispatch(CurrencyListNotification event) {
    if (event is ResultCurrencyListNotification) {
      return setState(() {
        this.currencyList.clear();
        this.currencyList.addAll(event.currencyList);
      });
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}