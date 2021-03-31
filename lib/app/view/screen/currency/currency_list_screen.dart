import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/uses_currency_model.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/common/currency_list.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

class CurrencyListScreen extends StatefulWidget{
  final ScrollController _scrollController = ScrollController();



  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CurrencyListScreen>{
  final List<UsesCurrencyListReadModel> currencyList = [];
  final CurrencyListViewModel viewModel = CurrencyListViewModelBuilder.build();


  @override
  void initState() {
    viewModel.event.listen((CurrencyListNotification event) {
      dispatch(event);
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
          itemBuilder: (context, index){
            UsesCurrencyListReadModel currencyReadModel = currencyList[index];
            return ListTile(
              title: Text(currencyReadModel.name),
              subtitle: Text(currencyReadModel.id),
            );
      },
      itemCount: currencyList.length,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
          /*CurrencyCommandDispatcher commandDispatcher = CurrencyCoreContainer.getInstance().commandDispatcher;
          //UsesCurrencyDomainModel model = UsesCurrencyDomainModel(id: 'UAH', name: 'hryvna', symbol: 'Hrn', fraction: 2);
          commandDispatcher.dispatch(CurrencyCreateCommand(id: 'usd', isNew: true, name: 'dollar', symbol: '\$', fraction: 2));*/
          //Navigator.push(context, MaterialPageRoute(builder:() => CurrencyListScreen()));
        },
      ),
    );
  }

  void dispatch(CurrencyListNotification event) {
    if(event is ResultCurrencyListNotification){
      return setState((){
        this.currencyList.clear();
        this.currencyList.addAll(event.currencyList);
      });
    }
  }
}