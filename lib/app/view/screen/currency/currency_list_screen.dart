import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';
import 'package:mymoneyorganizer/app/view/common/scroll_handled_appbar.dart';
import 'package:mymoneyorganizer/app/view/common/util/generated_confirm_text_4_deleted.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/currency/currency_list.dart';

enum MenuItem { edit, delete, setAsDefault }

//TODO make Stateless and split into screen and list (see account)
class CurrencyListScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();

  CurrencyListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

// ==================================================================

class _State extends State<CurrencyListScreen> with TickerProviderStateMixin {
  final List<CurrencyListReadModel> currencyList = [];
  final CurrencyListViewModel viewModel = CurrencyListViewModelBuilder.build();
  bool _visibleDelButton = false;
  bool _selectMode = false;

  //bool _fabView = true;
  //late ScrollController _controller;
  late AnimationController _animationController;

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
    _animationController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    super.initState();
    _animationController.forward();
    /*widget._scrollController.addListener(() {
      if (widget._scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _fabView = true;
        });
      } else {
        if (widget._scrollController.position.userScrollDirection == ScrollDirection.forward) {
          setState(() {
            _fabView = false;
          });
        }
      }
    });*/
    /*_controller = widget._scrollController;
    _controller.addListener(() {
      bool _currentFABVisible = _controller.position.userScrollDirection == ScrollDirection.forward;
      if (_fabView != _currentFABVisible) {
        setState(() {
          _fabView = _currentFABVisible;
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotify,
          child: ListView.builder(
            controller: widget._scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: currencyList.length,
            itemBuilder: (context, index) => _buildItem(index: index),
          ),
        ),
        /*floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _fabView ? 1.0 : 0.0,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
            },
          ),
        ),*/
        floatingActionButton: ScaleTransition(
          scale: _animationController,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
            },
          ),
        ),
      ),
      onWillPop: () async {
        bool returnFlag = false;
        if (_selectMode) {
          setState(() {
            for (var element in currencyList) {
              element.selected = false;
            }
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

  bool _handleScrollNotify(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _animationController.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _animationController.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  PreferredSizeWidget _buildAppBar() {
    return ScrollHandledAppBar(
      leading: AnimatedOpacity(
        duration: const Duration(milliseconds: 450),
        //vsync: this,
        curve: Curves.easeInOutQuint,
        opacity: _selectMode ? 1 : 0,
        child: _selectMode ? const BackButton() : null,
      ),
      title: Text(
        t('currency.list.title'),
        style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6?.color),
      ),
      scrollController: widget._scrollController,
      action: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          width: _visibleDelButton ? 48 : 0,
          //vsync: this,
          child: AnimatedOpacity(
            opacity: _visibleDelButton ? 1 : 0,
            duration: const Duration(milliseconds: 350),
            child: IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () {
                List<String> idLst = [];
                for (var element in currencyList) {
                  if (element.selected) {
                    idLst.add(element.id);
                  }
                }
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
      duration: const Duration(milliseconds: 350),
      //vsync: this,
      child: Column(
        children: [
          SizedBox(
            width: _selectMode ? 28 : 0,
            height: 28,
            child: AnimatedOpacity(
              opacity: _selectMode ? 1 : 0,
              duration: const Duration(milliseconds: 350),
              child: Checkbox(
                value: currencyList[index].selected,
                shape: const CircleBorder(),
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
      padding: const EdgeInsets.all(3), //currencyList[index].selected ? .5 : 4),
      child: AnimatedContainer(
        //padding: EdgeInsets.all(currencyList[index].selected ? 3 : 1),
        decoration: BoxDecoration(
          color: currencyList[index].selected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            currencyList[index].selected
                ? BoxShadow(color: Colors.grey.shade400, blurRadius: 3, spreadRadius: 3, offset: Offset(3, 3))
                : BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))
          ],
        ),
        duration: const Duration(milliseconds: 350),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            child: InkWell(
              onTap: () => _itemOnTap(index),
              onLongPress: () => _itemOnLongPress(index),
              child: Row(
                children: [
                  _buildAvatar(index: index),
                  _buildVerticalDivider(),
                  _buildNameSection(index: index),
                  const Spacer(flex: 1),
                  _buildPopUpButton(isNotDefault, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar({required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              currencyList[index].symbol,
              style: const TextStyle(fontSize: 48),
            ),
          ),
        ),
        backgroundColor: Color(currencyList[index].avatarColor),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.grey.shade300,
        width: 1,
        height: 45,
      ),
    );
  }

  Widget _buildNameSection({required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currencyList[index].name,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
          Text(
            currencyList[index].id,
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpButton(bool isNotDefault, int index) {
    return AnimatedOpacity(
      opacity: _selectMode ? 0 : 1,
      duration: const Duration(milliseconds: 450),
      child: PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
          if (isNotDefault)
            PopupMenuItem<MenuItem>(
              value: MenuItem.setAsDefault,
              child: Text(t('currency.list.menu.set_default')),
              enabled: isNotDefault,
            ),
          if (isNotDefault)
            const PopupMenuDivider(
              height: 2,
            ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.edit,
            child: Text(t('currency.list.menu.edit')),
          ),
          const PopupMenuDivider(
            height: 2,
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.delete,
            child: Text(t('currency.list.menu.delete')),
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
        currencyList.clear();
        currencyList.addAll(event.currencyList!);
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
    _animationController.dispose();
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
        content: Text(buildTextToConfirmDelete(confirmData: listId, what: t('currency.name'))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: Text(t('common.button.cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text(t('common.button.ok')),
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
