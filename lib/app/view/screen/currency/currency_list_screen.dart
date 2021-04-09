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
  bool _visibleDelButton = false;

  @override
  void initState() {
    viewModel.event.listen((CurrencyListNotification event) {
      dispatch(event);
    });
    EventBusCore.getInstance().events.listen((event) {
      if (event is CurrencyChangedEvent) {
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
        action: [
          Visibility(
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => viewModel.delete(currencyList),
            ),
            visible: _visibleDelButton,
          )
        ],
      ),
      body: ListView.builder(
        controller: this.widget._scrollController,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          CurrencyListReadModel currencyReadModel = currencyList[index];
          print('color: ${currencyReadModel.avatarColor}');
          return ListTile(
            leading: CircleAvatar(
              child: Text(currencyReadModel.symbol),

              backgroundColor: Color(currencyReadModel.avatarColor),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currencyReadModel.id),
                Divider(
                  height: 2,
                  color: Colors.orange,
                ),
              ],
            ),
            //Text(currencyReadModel.name),
            subtitle: Text(currencyReadModel.name),
            selectedTileColor: Colors.lightBlueAccent,
            onLongPress: () {
              setState(() {
                currencyList[index].selected = !currencyList[index].selected;
                _visibleDelButton = currencyList.any((element) => element.selected);
              });
            },
            selected: currencyReadModel.selected,
            trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () => viewModel.delete(currencyList)),
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
          //return ListItem();
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

  /*Widget buildItem(List<CurrencyListReadModel> currencyList, int index) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrencyDetailScreen(
              currencyId: currencyList[index].id,
            ),
          ),
        ),
      },
      onLongPress: () => {
        setState(() {
          currencyList[index].selected = !currencyList[index].selected;
          _visibleDelButton = currencyList.any((element) => element.selected);
        })
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Row(
            children: [
              Visibility(
                child: Checkbox(
                  value: currencyList[index].selected,
                  onChanged: (value) {
                    setState(() {
                      currencyList[index].selected = value;
                    });
                  },
                ),
                visible: _visibleDelButton,
              ),
              CircleAvatar(
                child: Text(currencyList[index].symbol),
              ),
              Column(
                children: [
                  Text(currencyList[index].id),
                  Text(currencyList[index].name),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }*/

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

class ListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
