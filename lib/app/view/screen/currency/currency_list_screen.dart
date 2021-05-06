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
  bool _selectMode = false;

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
    return WillPopScope(
      child: Scaffold(
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
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return buildItem(index: index);
            /*ListTile(
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
                  Text(currencyReadModel.name),
                ],
              ),
              //subtitle: Text(currencyReadModel.name),
              selectedTileColor: Colors.blueGrey,
              selected: currencyReadModel.selected,
              trailing: IconButton(
                icon: Icon(Icons.more_vert_sharp),
                onPressed: () => viewModel.delete(currencyList),
                iconSize: 20,
              ),
              onTap: () => {
                if (_selectMode)
                  {
                    setState(() {
                      currencyList[index].selected = !currencyList[index].selected;
                    })
                  }
                else
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyDetailScreen(
                          currencyId: currencyReadModel.id,
                        ),
                      ),
                    ),
                  }
              },
              onLongPress: () {
                setState(() {
                  currencyList[index].selected = !currencyList[index].selected;
                  _visibleDelButton = currencyList.any((element) => element.selected);
                  _selectMode = true;
                });
              },
            );*/
          },
          itemCount: currencyList.length,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
          },
        ),
      ),
      onWillPop: () async {
        bool returnFlag = false;
        if (_selectMode) {
          setState(() {
            currencyList.forEach((element) {
              element.selected = false;
            });
            _selectMode = false;
            _visibleDelButton = false;
          });
        } else {
          returnFlag = true;
        }
        return returnFlag;
      },
    );
  }

  Widget buildItem({@required int index}) {

    return Material(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Ink(
          decoration: BoxDecoration(
              //border: Border.all(color: Color.fromARGB(100, 200, 200, 200), width: 1.5),
              gradient: LinearGradient(stops: [0.02, 0.001], colors: [Color(currencyList[index].avatarColor), Colors.white]),
              borderRadius: BorderRadius.all(const Radius.circular(5.0))),
          child: InkWell(
            onTap: () => _itemOnTap(index),
            onLongPress: () => _itemOnLongPress(index),
            splashColor: Color.fromARGB(170, 150, 180, 220),
            //highlightColor: Colors.grey,
            child: Padding(
              padding: EdgeInsets.only(left: (_selectMode ? 4 : 16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: _selectMode,
                        child: Checkbox(
                            value: currencyList[index].selected,
                            onChanged: (value) {
                              setState(() {
                                currencyList[index].selected = value;
                                _visibleDelButton = currencyList.any((element) => element.selected);
                              });
                            }),
                      ),
                      CircleAvatar(
                        child: Text(currencyList[index].symbol),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  currencyList[index].name,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  currencyList[index].id,
                                  style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      IconButton(icon: Icon(Icons.more_vert_sharp), onPressed: () => {}),
                    ],
                  ),
                  Divider(
                    height: 0,
                    thickness: .7,
                    indent: _selectMode ? 100 : 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _itemOnTap(int index) {
    if (_selectMode) {
      setState(() {
        currencyList[index].selected = !currencyList[index].selected;
        _visibleDelButton = currencyList.any((element) => element.selected);
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CurrencyDetailScreen(
            currencyId: currencyList[index].id,
          ),
        ),
      );
    }
  }

  void _itemOnLongPress(int index) {
    setState(() {
      _selectMode = true;
      currencyList[index].selected = true;
      _visibleDelButton = true;
    });
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

  void onChanged(bool value) {}
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
