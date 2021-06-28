import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/common/util/generated_confirm_text_4_deleted.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/currency/currency_list.dart';
import 'package:mymoneyorganizer/generated/l10n.dart';

enum MenuItem { edit, delete, setAsDefault }

class CurrencyListScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() => _State();
}

// ==================================================================

class _State extends State<CurrencyListScreen> with TickerProviderStateMixin {
  final List<CurrencyListReadModel> currencyList = [];
  final CurrencyListViewModel viewModel = CurrencyListViewModelBuilder.build();
  bool _visibleDelButton = false;
  bool _selectMode = false;

  @override
  void initState() {
    viewModel.event.listen((CurrencyListNotification event) {
      _viewModelEventDispatch(event);
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
        appBar: _buildAppBar(),
        body: ListView.builder(
          controller: this.widget._scrollController,
          padding: EdgeInsets.all(8),
          itemCount: currencyList.length,
          itemBuilder: (context, index) => _buildItem(index: index),
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

  PreferredSizeWidget _buildAppBar() {
    return ScrollHandledAppBar(
      leading: AnimatedOpacity(
        duration: Duration(milliseconds: 450),
        //vsync: this,
        curve: Curves.easeInOutQuint,
        opacity: _selectMode ? 1 : 0,
        child: _selectMode ? BackButton() : null,
      ),
      title: Text(S.of(context).currency_list_title),
      scrollController: this.widget._scrollController,
      action: [
        AnimatedContainer(
          duration: Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          width: _visibleDelButton ? 48 : 0,
          //vsync: this,
          child: AnimatedOpacity(
            opacity: _visibleDelButton ? 1 : 0,
            duration: Duration(milliseconds: 350),
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
          ),
        )
      ],
    );
  }

  Widget _buildItem({required int index}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildSelectedCheckbox(index: index),
        Expanded(
          child: _buildItemContent(index: index),
        ),
        //Wrap(children: [_buildItemContent(index: index)]),
      ],
    );
  }

  Widget _buildSelectedCheckbox({required int index}) {
    return AnimatedSize(
      duration: Duration(milliseconds: 350),
      vsync: this,
      child: Column(
        children: [
          SizedBox(
            width: _selectMode ? 28 : 0,
            height: 28,
            child: AnimatedOpacity(
              opacity: _selectMode ? 1 : 0,
              duration: Duration(milliseconds: 350),
              child: Checkbox(
                value: currencyList[index].selected,
                shape: CircleBorder(),
                onChanged: (value) {
                  setState(
                    () {
                      currencyList[index].selected = value!;
                      _visibleDelButton = currencyList.any((element) => element.selected);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemContent({required int index}) {
    bool isNotDefault = !currencyList[index].isDefault;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: currencyList[index].selected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            currencyList[index].selected
                ? BoxShadow(color: Colors.grey.shade500, blurRadius: 4, spreadRadius: 3, offset: Offset(2, 4))
                : BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 1, offset: Offset(.5, 1))
          ],
        ),
        duration: Duration(milliseconds: 350),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            child: InkWell(
              onTap: () => _itemOnTap(index),
              onLongPress: () => _itemOnLongPress(index),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: CircleAvatar(
                      child: Text(currencyList[index].symbol),
                      backgroundColor: Color(currencyList[index].avatarColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Container(
                      color: Colors.grey.shade300,
                      width: 1,
                      height: 45,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
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
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  _buildPopUpButton(isNotDefault, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopUpButton(bool isNotDefault, int index) {
    return AnimatedOpacity(
      opacity: _selectMode ? 0 : 1,
      duration: Duration(milliseconds: 450),
      child: PopupMenuButton(
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
        enabled: !_selectMode,
      ),
    );
  }

  void _viewModelEventDispatch(CurrencyListNotification event) {
    if (event is ResultCurrencyListNotification) {
      return setState(() {
        this.currencyList.clear();
        this.currencyList.addAll(event.currencyList!);
      });
    }
  }

  void _contextMenuDispatch(MenuItem item, int index) {
    if (item == MenuItem.edit) {
      _openElement(index);
    }
    if (item == MenuItem.delete) {
      _deleteElements([currencyList[index].id]);
    }
    if (item == MenuItem.setAsDefault) {
      _setAsDefault(index);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
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
