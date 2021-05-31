import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/common/util/generated_confirm_text_4_deleted.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/common/currency_list.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

enum MenuItem { edit, delete, setAsDefault }

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
                icon: Icon(Icons.delete_rounded),
                onPressed: () {
                  List<String> idLst = [];
                  currencyList.forEach((element) {
                    if (element.selected) {
                      idLst.add(element.id);
                    }
                  });
                  _deleteElements(idLst);
                },
              ),
              visible: _visibleDelButton,
            )
          ],
        ),
        body: ListView.builder(
          controller: this.widget._scrollController,
          padding: EdgeInsets.all(8),
          itemCount: currencyList.length,
          itemBuilder: (context, index) {
            return _buildItem(index: index);
          },
        ),
        floatingActionButton: FloatingActionButton(
          //TODO add show/hide method
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

  Widget _buildItem({@required int index}) {
    bool isNotDefault = currencyList[index].isDefault == null ? true : !currencyList[index].isDefault;
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
                                  textAlign: TextAlign.left,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
                          if (isNotDefault)
                            PopupMenuItem<MenuItem>(
                              value: MenuItem.setAsDefault,
                              child: Text(S.of(context).setAsDefault),
                              enabled: isNotDefault,
                            ),
                          if (isNotDefault)
                            PopupMenuDivider(
                              height: 2,
                            ),
                          PopupMenuItem<MenuItem>(
                            value: MenuItem.edit,
                            child: Text(S.current.edit),
                          ),
                          PopupMenuDivider(
                            height: 2,
                          ),
                          PopupMenuItem<MenuItem>(
                            value: MenuItem.delete,
                            child: Text(S.current.delete),
                          ),
                        ],
                        onSelected: (MenuItem result) => _contextMenuDispatch(result, index),
                      ),
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

  void _deleteElements(List<String> listId) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        //title: Text(S.of(context).confirm),
        content: Text(buildTextToConfirmDelete(confirmData: listId, what: S.of(context).currency)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text(S.of(context).ok),
          ),
        ],
      ),
    ).then((value) {
      if (value != null) {
        if (value == 'ok') {
          viewModel.delete(listId);
          setState(() {
            _selectMode = false;
            _visibleDelButton = false;
          });
        }
      }
    });
  }

  void _contextMenuDispatch(MenuItem item, int index) {
    if (item == MenuItem.edit) {
      _openElement(index);
    }
    if (item == MenuItem.delete) {
      //viewModel.delete([currencyList[index].id]);
      _deleteElements([currencyList[index].id]);
    }
    if (item == MenuItem.setAsDefault) {
      _setAsDefault(index);
    }
  }

  void _setAsDefault(int index) {
    viewModel.setAsDefault(currencyList[index].id);
  }

  void _openElement(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencyDetailScreen(
          currencyId: currencyList[index].id,
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
      _openElement(index);
    }
  }

  void _itemOnLongPress(int index) {
    setState(() {
      _selectMode = true;
      currencyList[index].selected = true;
      _visibleDelButton = true;
    });
  }
}

/*class ListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}*/
